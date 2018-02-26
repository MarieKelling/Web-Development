-- 11.5 Marie Kelling
-- Delete the Romance Language Department, and faculty working in the department, and the courses the department offered
USE college;

DELETE FROM faculty 
WHERE
    DepartmentID = 5;
    
DELETE FROM Department 
WHERE
    ID = 5; 

DELETE FROM course 
WHERE
    DepartmentID = 5;
    
SELECT 
    *
FROM
    department; 