-- Phase 3 Marie Kelling
-- 8. An OUTER JOIN
USE brendasmek;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    EmployeeShop.EmployeeID AS 'Employee ID',
    EmployeeShop.ShopID AS 'Shop ID',
    Shop.Address AS 'Shop Address'
FROM
    Employee
        LEFT OUTER JOIN
    EmployeeShop ON Employee.ID = EmployeeShop.EmployeeID
        LEFT OUTER JOIN
    Shop ON EmployeeShop.ShopID = Shop.ID
ORDER BY LastName; 
    
    