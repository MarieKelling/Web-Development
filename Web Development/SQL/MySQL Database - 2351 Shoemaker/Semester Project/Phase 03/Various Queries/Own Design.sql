-- Phase 3 Marie Kelling
-- 9. Query of my own design - join at least 4 tables, have a GROUP BY, & have a meaningful purpose
USE brendasmek; 
SELECT 
    Sale.EmployeeID AS 'Employee ID',
    Employee.LastName AS 'Last Name',
    Employee.FirstName AS 'First Name',
    Orders.OrderDate AS 'Order Date',
    Vendor.VendorType AS 'Vendor Type'
FROM
    Sale
        INNER JOIN
    Employee ON Sale.EmployeeID = Employee.ID
        INNER JOIN
    Orders ON Employee.ID = Orders.EmployeeID
        INNER JOIN
    Vendor ON Orders.VendorID = Vendor.ID
ORDER BY Employee.LastName;
    