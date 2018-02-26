-- 12.2 Marie Kelling
-- List all students with the given Major uisng an IN
USE college;
DROP PROCEDURE IF EXISTS Students_Major;
DELIMITER $$ 
CREATE PROCEDURE Students_Major(MajorID INT)
BEGIN 
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Major.ID AS 'Major'
FROM
    Student
        INNER JOIN
    Major ON Student.MajorID = Major.ID
    where Major.ID = MajorID;
END
$$
DELIMITER ; 

CALL Students_Major(1);



