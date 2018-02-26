-- Phase 3 Marie Kelling
-- 13. BEFORE UPDATE that tests data quality and throws an error when bad data comes in
USE brendasmek;
DROP TRIGGER IF EXISTS  OrderDate_Before_Update; 
DELIMITER $$

	CREATE TRIGGER OrderDate_Before_Update
	BEFORE UPDATE ON Orders
    FOR EACH ROW 
      BEGIN 
		IF NEW.OrderDate > CURDATE() 
			THEN 
				SIGNAL SQLSTATE VALUE '45000'
				SET MESSAGE_TEXT= 'Oder date may not be in the future';
		END IF; 
      END $$
DELIMITER ; 

UPDATE Orders
SET OrderDate = DATE(NOW())
WHERE ID = 1;

UPDATE Orders
SET OrderDate = DATE_ADD(NOW(), INTERVAL 1 DAY) 
WHERE ID = 1; 

