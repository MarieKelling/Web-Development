-- 3.10 Marie Kelling
-- The five oldest students
USE starter;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Email AS 'Email Address',
    DateOfBirth AS 'Birthday'
FROM
    Student
ORDER BY DateOfBirth ASC
LIMIT 5;

