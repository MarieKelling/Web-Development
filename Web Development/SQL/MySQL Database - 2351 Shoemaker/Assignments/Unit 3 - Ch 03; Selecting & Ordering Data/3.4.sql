-- 3.4 Marie Kelling
-- Students with scholarship of at least $2,000 but less than $3,500
USE starter;
SELECT 
    Scholarship AS 'Scholarship',
LastName AS 'Last Name',
    FirstName AS 'First Name'
FROM
    Student
WHERE
    Scholarship >= 2000
        AND Scholarship < 3500
ORDER BY Scholarship , LastName;
