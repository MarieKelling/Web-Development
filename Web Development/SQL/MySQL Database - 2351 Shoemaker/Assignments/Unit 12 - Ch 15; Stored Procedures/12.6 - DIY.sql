-- 12.6 Marie Kelling
-- DIY Procedure that takes one IN argument and joins at least three tables
USE college;
DROP PROCEDURE IF EXISTS Student_Club_Memberships;
DELIMITER $$ 
CREATE PROCEDURE Student_Club_Memberships(StudentID INT)
BEGIN
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Club.Name
FROM
    Student
        INNER JOIN
    Membership ON Student.ID = Membership.StudentID
        INNER JOIN
    Club ON Membership.ClubId = Club.ID
    WHERE Student.ID = StudentID;
END
$$
DELIMITER ;

CALL Student_Club_Memberships(2); 

