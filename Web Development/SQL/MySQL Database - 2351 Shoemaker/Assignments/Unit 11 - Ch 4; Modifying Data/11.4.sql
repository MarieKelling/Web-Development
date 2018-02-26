-- 9.4 MarieKelling
-- Delete the Nursing course
USE college;
DELETE FROM course 
WHERE
    Name = 'NS 1020 -Blood Letting' 
    AND DepartmentID = 3;

SELECT 
    name
FROM
    course
WHERE
    DepartmentID = 3;