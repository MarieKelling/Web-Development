-- 12.4 Marie Kelling
-- Procedure that takes as its IN the ID of a faculty member and returns the average grade across all sections they teach
USE college;
DROP PROCEDURE IF EXISTS Faculty_GPA ;
DELIMITER $$
CREATE PROCEDURE Faculty_GPA(IN FacultyID INT, OUT outGPA decimal(4, 2))
BEGIN
         DECLARE GPAInfo DECIMAL(4,2); 
         
		 SET GPAInfo= 
         (SELECT AVG(Registration.Grade) 
			   FROM 
		    Registration 
              INNER JOIN 
             Section ON Registration.SectionID= Section.ID
		    WHERE section.TaughtByID= FacultyID); 
            		
     SET outGPA= GPAInfo; 
END $$
DELIMITER ;

CALL Faculty_GPA(2, @GPA); 

SELECT @GPA as GPA; 