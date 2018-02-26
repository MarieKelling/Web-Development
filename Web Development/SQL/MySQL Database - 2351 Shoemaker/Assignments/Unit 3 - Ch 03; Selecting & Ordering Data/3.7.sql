-- 3.7 Marie Kelling
-- Students with $4,000 scholarship and majoring in Computer Science, Mathematics, or Criminal Justice
USE starter;
SELECT 
    MajorID AS 'Major Id',
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Scholarship
FROM
    Student
WHERE
    Scholarship = 4000
        AND MajorId IN (1 , 3, 6)
ORDER BY MajorId , LastName;