-- Phase 3 Marie Kelling
-- 10. Create a View w/ a useful business purpose - Displays the ID, Order Date, & Quantity of each Order
USE brendasmek;
CREATE OR REPLACE VIEW OrdersDateQuantity AS
SELECT 
    Orders.ID AS 'Order ID',
    Orders.OrderDate AS 'Order Date',
    Quantity
FROM
    Orders
        INNER JOIN
    OrderLineItem
ORDER BY Orders.ID;

SELECT 
    *
FROM
    OrdersDateQuantity;