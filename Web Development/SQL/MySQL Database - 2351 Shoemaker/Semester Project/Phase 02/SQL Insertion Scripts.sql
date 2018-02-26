-- Priject Phase 2 Marie Kelling
-- Insert 2 records into each table
USE brendasmek; 

INSERT INTO customer (FirstName, LastName, Email, Phone)
VALUES ('John', 'Doe', 'JohnDoe@gmail.com', '330-840-2233');
INSERT INTO customer (FirstName, LastName, Email, Phone)
VALUES ('Jane', 'Doe', 'JaneDoe@gmail.com', '330-840-2244'); 

INSERT INTO employee (FirstName, LastName, Street, City, State, ZipCode, County, Phone, BirthDate, SSN)
VALUES ('William', 'Smith', '345 Cherry Lane', 'Twinsburg', 'OH', '44066', 'Cuyahoga', '216-334-5656', '1980-02-03', 343086654);
INSERT INTO employee (FirstName, LastName, Street, City, State, ZipCode, County, Phone, BirthDate, SSN)
VALUES ('Sarah', 'Smith', '345 Cherry Lane', 'Twinsburg', 'OH', '44066', 'Cuyahoga', '216-552-8989', '1982-05-12', 232092343);

INSERT INTO ingredient (Name, Quantity, UnitOFMeasure)
VALUES ('Flour', 2, 'Pounds');
INSERT INTO ingredient (Name, Quantity, UnitOFMeasure)
VALUES ('Sugar', 6, 'Pounds');

INSERT INTO vendor(FirstName, LastName, VendorType, Street, ZipCode, Phone)
VALUES('Acme', 'Manufacturing', 'Hardware', '786 Loony Road', '66099', '216-675-8892');
INSERT INTO vendor(FirstName, LastName, VendorType, Street, ZipCode, Phone)
VALUES('Home', 'Depot', 'Hardware', '224 Oval Lane', '44867', '216-982-1332');

INSERT INTO orders (EmployeeID, VendorID, OrderDate)
VALUES (1, 1, '2017-08-12');
INSERT INTO orders (EmployeeID, VendorID, OrderDate)
VALUES (2, 2, '2017-08-12');

INSERT INTO recipe (Name)
VALUES ('Apple Pie');
INSERT INTO recipe (Name)
VALUES ('Chocolate Chip Cookies');

INSERT INTO product (Name, RecipeID)
VALUES ('Cupcake Mix', 1);
INSERT INTO product (Name, RecipeID)
VALUES ('Brownie Mix', 2);

INSERT INTO sale(Date, CustomerID, EmployeeID)
VALUES ('2017-09-14', 1, 1);
INSERT INTO sale(Date, CustomerID, EmployeeID)
VALUES ('2017-09-18', 2, 2);

INSERT INTO shop (Address, County, ZipCode, Phone)
VALUES ('820 Skyhawk Lane, Bedford OH', 'Cuyahoga', '44023', '330-990-3423');
INSERT INTO shop (Address, County, ZipCode, Phone)
VALUES ('820 Whitehorse Lane, Strongsville OH', 'Cuyahoga', '44088', '330-885-5411');



SELECT * FROM customer;
SELECT * FROM employee;
SELECT * FROM ingredient;
SELECT * FROM vendor;
SELECT * FROM orders;
SELECT * FROM recipe;
SELECT * FROM product;
SELECT * FROM sale;
SELECT * FROM shop;


