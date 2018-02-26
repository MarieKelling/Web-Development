-- 3.9 Marie Kelling
-- Students with last name starting with 'S'
USE starter;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Email AS 'Email Address'
FROM
    Student
WHERE
    LastName LIKE 'S%'
ORDER BY LastName;