-- 3.1 Marie Kelling
-- Students with a scholarship more than $2,500

USE starter;

SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Scholarship AS 'Scholarship'
FROM
    Student
WHERE
    Scholarship > 2500
ORDER BY LastName;