-- 3.6 Marie Kelling
-- Female students who major in Biology or Anthropology 
USE starter;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Email AS 'Email Address'
FROM
    Student
WHERE
    sex = 'F'
        AND (MajorID = 4 OR MajorID = 7);