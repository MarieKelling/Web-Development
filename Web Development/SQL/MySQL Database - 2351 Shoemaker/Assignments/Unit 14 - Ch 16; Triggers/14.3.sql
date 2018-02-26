-- 14.3 Marie Kelling
-- Adds rule to the Student_Before_Update Trigger that prevents students born before the year 2000 from enrolling 
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
        
        IF NEW.DateOfBirth > '2000-01-01'
			THEN 
				SIGNAL SQLSTATE VALUE '45000'
				SET MESSAGE_TEXT= 'DateOfBirth not valid';
		END IF; 
        
      END $$
DELIMITER ; 

UPDATE Student
SET DateOfBirth = DATE(NOW()) 
WHERE ID = 1; 

------------------------------------------------------------------ 

UPDATE Student
SET EnrolledDate = DATE(NOW())
WHERE ID = 1;

UPDATE Student
SET EnrolledDate = DATE_ADD(NOW(), INTERVAL 1 DAY) 
WHERE ID = 1; 
