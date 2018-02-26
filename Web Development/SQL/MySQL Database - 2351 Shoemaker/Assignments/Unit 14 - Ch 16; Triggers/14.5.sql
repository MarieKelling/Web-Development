-- 14.5 Marie Kelling
-- Create Trigger to prevent a Student from registering for a Section that the student is already registered for
USE college;
DROP TRIGGER IF EXISTS  Registration_Before_Insert; 
DELIMITER $$
CREATE TRIGGER Registration_Before_Insert
BEFORE INSERT ON Registration 
FOR EACH ROW 
	BEGIN 
    
       DECLARE SectionCount INT; 
		SELECT COUNT(*) INTO SectionCount 
        FROM Registration 
        WHERE StudentID = NEW.StudentID AND NEW.SectionID = SectionID; 
			IF SectionCount > 0 THEN 
                 SIGNAL SQLSTATE VALUE '45000'
				 SET MESSAGE_TEXT= 'Student is already registered for this section';
        END IF ; 
      END $$
DELIMITER ;

INSERT INTO Registration(StudentID, SectionID, Grade)
VALUES(1, 2, 3.9); 
INSERT INTO Registration(StudentID, SectionID, Grade)
VALUES(1, 2, 3.9); 



