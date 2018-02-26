-- 4.1 Marie Kelling
-- list students receiving scholarships
USE starter;
SELECT 
    FORMAT(Scholarship, 0) AS 'Scholarship',
    LastName AS 'Last Name',
    FirstName AS 'First Name'
FROM
    student
WHERE
    Scholarship > 0
ORDER BY Scholarship DESC , LastName ASC , FirstName ASC;