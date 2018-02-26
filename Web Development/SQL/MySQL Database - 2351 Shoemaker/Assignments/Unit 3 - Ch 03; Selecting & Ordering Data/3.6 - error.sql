-- 3.6 Marie Kelling
-- Female students who major in Biology or Anthropology 
USE starter;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Email AS 'Email Address',
    sex,
    MajorID,
    Scholarship
FROM
    Student
WHERE
    Sex = 'Female';