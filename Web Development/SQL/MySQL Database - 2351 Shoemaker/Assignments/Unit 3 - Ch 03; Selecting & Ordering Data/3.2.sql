-- 3.2 Marie Kelling
-- Students with the last name Cruz

USE starter;

SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Email AS 'Email Address'
FROM
    Student
WHERE
    LastName = 'Cruz'
ORDER BY FirstName; 