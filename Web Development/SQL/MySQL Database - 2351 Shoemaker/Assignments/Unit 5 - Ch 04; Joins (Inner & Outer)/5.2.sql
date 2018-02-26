-- 5.2 Marie Kelling
-- List female students majoring in computer science or math
USE college;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'FirstName',
    Major.Name AS 'Major'
FROM
    student
        INNER JOIN
    major ON major.ID = student.MajorID
WHERE
    sex = 'F' AND MajorID IN (1 , 2)
ORDER BY LastName , FirstName , Major;