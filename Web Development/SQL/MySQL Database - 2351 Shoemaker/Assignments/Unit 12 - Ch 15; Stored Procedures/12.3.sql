-- 12.3 Marie Kelling
-- Takes arguments for info of a new student, and adds that student into the database 
USE college;
DROP PROCEDURE IF EXISTS Student_Add ;
DELIMITER $$
CREATE PROCEDURE Student_Add(IN LastName varchar(45), 
							 IN FirstName varchar(45),
                             IN Email varchar(45),
							 IN Sex char(1),
                             IN DateOfBirth date,
                             IN EnrolledDate date,
                             IN MajorID INT(11), 
							 IN Scolarship DECIMAL(9,2)) 
BEGIN

INSERT INTO Student (LastName, FirstName, Email, Sex,  DateOfBirth, EnrolledDate, MajorID, Scholarship)
VALUES (LastName, FirstName, Email, Sex, DateOfBirth, EnrolledDate, MajorID, Scholarship);
       
END
$$
DELIMITER ;

CALL Student_Add('Kelling', 'Marie', 'mariekelling@college.com', 'F', '1997-01-28', '2015-08-20', 1, 1000.00);

SELECT * FROM Student WHERE Student.ID = (SELECT MAX(ID) FROM Student);


