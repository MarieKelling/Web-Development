-- 9.2 Marie Kelling
-- Use a UNION statement to combine the students and faculty into a single result set

USE college;
SELECT 
     FirstName AS 'First', LastName AS 'Last', 'Student' AS Type
FROM
    Student
WHERE
    MajorID = 5  

UNION 
SELECT 
    FirstName AS 'First', LastName AS 'Last', 'Faculty' AS Type
FROM
    Faculty
WHERE
    DepartmentID = 3
ORDER BY Last; 

