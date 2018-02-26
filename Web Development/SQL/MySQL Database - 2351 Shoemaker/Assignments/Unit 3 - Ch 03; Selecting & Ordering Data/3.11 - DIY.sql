-- 3.11 Marie Kelling
-- DIY - All female students born in 1997
USE starter;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Sex AS 'Gender',
    DateOfBirth AS 'Birthday'
FROM
    Student
WHERE
    Sex = 'F'
        AND (DateOfBirth BETWEEN '1997-01-01' AND '1997-12-31')
ORDER BY LastName;

