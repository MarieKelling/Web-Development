-- 5.1 Marie Kelling
-- List name of departments and faculty members who work there
USE college;
SELECT 
    Department.Name AS 'Department',
    LastName AS 'Last Name',
    FirstName AS 'First Name'
FROM
    faculty
        INNER JOIN
    department ON department.ID = faculty.DepartmentID
ORDER BY department , LastName , FirstName; 