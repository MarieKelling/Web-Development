-- 3.8 Marie Kelling
-- Students who enrolled last year (2016)
USE starter;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Email AS 'Email Address',
    EnrolledDate AS 'Date Enrolled',
    Scholarship
FROM
    Student
WHERE
    EnrolledDate BETWEEN '2016-01-01' AND '2016-12-31'
ORDER BY LastName , FirstName;