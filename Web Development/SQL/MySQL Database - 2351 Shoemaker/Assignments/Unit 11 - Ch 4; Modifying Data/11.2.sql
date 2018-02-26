-- 11.2 Marie Kelling
-- Add new record into student table
USE college;
INSERT INTO student (LastName, FirstName, Email, Sex, EnrolledDate, DateOfBirth, MajorID, Scholarship)
VALUES ('Biggs', 'Robert', 'RobertBiggs@college.edu', 'M', '2017-10-30', '1997-12-15', 3, 3350) ;

SELECT 
    *
FROM
    student
where ID = 102;
