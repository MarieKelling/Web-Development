-- 5.4 Marie Kelling
-- Lists departments and courses offered 
USE college; 
SELECT 
    department.Name AS 'Department', course.Name AS 'Course'
FROM
    Department
        LEFT JOIN 
    Course ON department.ID = course.DepartmentID; 
