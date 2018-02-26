-- Phase 3 Marie Kelling
-- 7. An INNER JOIN of at least 3 tables 
USE brendasmek;
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Orders.OrderDate 'Order Date',
    OrderLineItem.Quantity AS 'Quantity'
FROM
    Employee
        INNER JOIN
    Orders ON Employee.ID = Orders.EmployeeID
        INNER JOIN
    OrderLineItem ON Orders.ID = OrderLineItem.OrderID
ORDER BY LastName;
