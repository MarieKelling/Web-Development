-- Phase 3 Marie Kelling
-- 11. Create a Stored Procedure (not function) - takes in at least 1 IN ARGUMENT & returns at least 1 OUT ARGUMENT
USE brendasmek;
DROP PROCEDURE IF EXISTS OrdersDateQuantity;
DELIMITER $$
CREATE PROCEDURE OrdersDateQuantity (OrderID INT)
BEGIN
	SELECT 
		Orders.ID AS 'Order ID',
		Orders.OrderDate AS 'Order Date',
		Quantity
	FROM
		Orders
			INNER JOIN
		OrderLineItem
		WHERE Orders.ID = OrderID
        ORDER BY Orders.OrderDate; 
END $$
DELIMITER ;

CALL OrdersDateQuantity(2); 