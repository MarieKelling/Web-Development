-- 14.2 Marie Kelling
-- Create trigger that will prevent an update to a student table if EnrolledDate is in the future
USE College ;
DROP TRIGGER IF EXISTS  Student_Before_Update; 
DELIMITER $$

	CREATE TRIGGER Student_Before_Update
	BEFORE UPDATE ON Student 
	FOR EACH ROW 
      BEGIN 
		IF NEW.EnrolledDate > CURDATE() 
			THEN 
				SIGNAL SQLSTATE VALUE '45000'
				SET MESSAGE_TEXT= 'Enrolled date may not be in the future';
		END IF; 
      END $$
DELIMITER ; 

UPDATE Student
SET EnrolledDate = DATE(NOW())
WHERE ID = 1;

UPDATE Student
SET EnrolledDate = DATE_ADD(NOW(), INTERVAL 1 DAY) 
WHERE ID = 1; 
