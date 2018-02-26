-- Phase 3 Marie Kelling
-- 12. BEFORE INSERT that prepares data to make sure it complies to rules
USE brendasmek;
DROP TRIGGER IF EXISTS Employee_Before_Insert ;
DELIMITER $$

CREATE TRIGGER Employee_Before_Insert
BEFORE INSERT ON Employee
FOR EACH ROW
	 BEGIN
     
		SET NEW.Email =  CONCAT(NEW.FirstName, NEW.LastName, '@BrendasBakery.com');
                        
     END $$ 
DELIMITER ;

INSERT INTO Employee (ID, FirstName, LastName, Street, City, State, ZipCode, Country, Phone, BirthDate, SSN, Email) 
VALUES (31, 'Bob', 'Cork', '384', 'Cleveland', 'OH', '44056', 'United States', '330-308-5620', '2017-05-05', '341479910', 'bcork0@irs.gov');

SELECT * FROM Employee;