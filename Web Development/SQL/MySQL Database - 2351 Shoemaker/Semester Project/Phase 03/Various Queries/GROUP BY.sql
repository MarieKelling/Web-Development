-- Phase 3 Marie Kelling
-- 6. A GROUP BY
USE brendasmek;
SELECT 
    COUNT(*) AS '# Of Sales',
    Employee.FirstName AS 'First Name',
    Employee.LastName AS 'Last Name'
FROM
    Sale
        INNER JOIN
    Employee ON Sale.EmployeeID = Employee.ID
GROUP BY Employee.LastName
HAVING COUNT(*) > 1
ORDER BY LastName;
