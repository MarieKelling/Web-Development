-- 3.3 Marie Kelling
-- Students born before 1997
USE starter;

SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    DateOfBirth AS 'Date of Birth'
FROM
    Student
WHERE
    DateOfBirth < '1996-12-31'
ORDER BY DateOfBirth DESC;