-- 3.5 Marie Kelling
-- Students majoring in Computer Science or Information Systems
USE starter;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    MajorID AS 'Major ID'
FROM
    Student
WHERE
    MajorID = 1 OR MajorID = 2
ORDER BY LastName;
