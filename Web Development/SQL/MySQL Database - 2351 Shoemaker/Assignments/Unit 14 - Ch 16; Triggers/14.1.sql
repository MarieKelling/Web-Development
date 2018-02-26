-- 14.1 Marie Kelling
-- Insert trigger that ensures the Email of people added to the facutly table is in the proper format
USE College;
DROP TRIGGER IF EXISTS Faculty_Before_Insert ;
DELIMITER $$

CREATE TRIGGER Faculty_Before_Insert
BEFORE INSERT ON Faculty
FOR EACH ROW
	 BEGIN
     
		SET NEW.Email =  CONCAT(NEW.FirstName, NEW.LastName, '@college.edu');
                        
     END $$ 
DELIMITER ;

INSERT INTO Faculty (LastName, FirstName, Email, HireDate, Salary, DepartmentID)
VALUES ('Kelling', 'Nate', 'bad@bad.bad', '2017-01-01', 60000.00, 1) ; 

SELECT LastName, FirstName, Email 	
FROM Faculty
WHERE ID = LAST_INSERT_ID(); 


