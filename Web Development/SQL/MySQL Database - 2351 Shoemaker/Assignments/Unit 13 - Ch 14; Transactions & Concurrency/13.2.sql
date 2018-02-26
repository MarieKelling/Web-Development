-- 13.2 Marie Kelling
-- Delete Egghead's Registration records, then his Student record, & then create a Faculty record for him
USE college;
DROP PROCEDURE IF EXISTS Fix_Egghead2   ;
DELIMITER $$
USE College$$

CREATE PROCEDURE Fix_Egghead2()
BEGIN
	-- Setup error handing
	DECLARE errorOccurred INT DEFAULT FALSE;
 	DECLARE errorMessage VARCHAR(255);
    
    DECLARE newFacultyID INT DEFAULT 0;
  
	-- Invoked when an error occurs
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN 
		SET errorOccurred = TRUE;
        GET STACKED DIAGNOSTICS CONDITION 1
			errorMessage = MESSAGE_TEXT;
 	END ;
	  
	START TRANSACTION;
    
		DELETE FROM Registration
		WHERE StudentID = 37;

		DELETE FROM Student
		WHERE ID = 37; 

		INSERT INTO Faculty (LastName, FirstName, Email, HireDate, Salary, DepartmentID)
		VALUES ('Egghead', 'Eduardo', 'EduardoEgghead@college.com', '2017-11-11', 115000.00, 1); 
 
	IF errorOccurred = TRUE THEN
		ROLLBACK;
		SELECT CONCAT('The faculty failed to add: ', errorMessage) AS Results;
	ELSE
		COMMIT;
		SELECT 'The faculty was successfully added.' AS Results;
	END IF;    
END
$$
DELIMITER ;

CALL Fix_Egghead2();
