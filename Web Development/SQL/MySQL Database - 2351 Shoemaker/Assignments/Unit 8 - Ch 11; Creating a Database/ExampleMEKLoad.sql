-- ExampleMEKLoad.SQL
-- Marie Kelling

USE examplemek;

INSERT INTO State (Abbreviation, Name) VALUES 
('AL', 'Alabama'),
('AK', 'Alaska'),
('AZ', 'Arizona'),
('AR', 'Arkansas'),
('CA', 'California'),
('CO', 'Colorado'),
('CT', 'Connecticut'),
('DE', 'Delaware'),
('DC', 'District of Columbia'),
('FL', 'Florida'),
('GA', 'Georgia'),
('HI', 'Hawaii'),
('ID', 'Idaho'),
('IL', 'Illinois'),
('IN', 'Indiana'),
('IA', 'Iowa'),
('KS', 'Kansas'),
('KY', 'Kentucky'),
('LA', 'Louisiana'),
('ME', 'Maine'),
('MD', 'Maryland'),
('MA', 'Massachusetts'),
('MI', 'Michigan'),
('MN', 'Minnesota'),
('MS', 'Mississippi'),
('MO', 'Missouri'),
('MT', 'Montana'),
('NE', 'Nebraska'),
('NV', 'Nevada'),
('NH', 'New Hampshire'),
('NJ', 'New Jersey'),
('NM', 'New Mexico'),
('NY', 'New York'),
('NC', 'North Carolina'),
('ND', 'North Dakota'),
('OH', 'Ohio'),
('OK', 'Oklahoma'),
('OR', 'Oregon'),
('PA', 'Pennsylvania'),
('PR', 'Puerto Rico'),
('RI', 'Rhode Island'),
('SC', 'South Carolina'),
('SD', 'South Dakota'),
('TN', 'Tennessee'),
('TX', 'Texas'),
('UT', 'Utah'),
('VT', 'Vermont'),
('VA', 'Virginia'),
('WA', 'Washington'),
('WV', 'West Virginia'),
('WI', 'Wisconsin'),
('WY', 'Wyoming');

INSERT INTO Supplier (Name, Street, City, Phone, HireDate, State_ID) VALUES
('Marie', '730 Tinkers ln.', 'Sagamore Hills', 2321234, '2017-01-01', 36),  
('John', '123 Cherry ln.', 'Twinsburg', 7653455, '2017-02-02', 2),
('Sarah', '456 Pearl Rd.', 'Strongsville', 8993266, '2017-03-03', 3) ,
('Eric', '789 Marwyck Dr.', 'Northfield', 0660362, '2017-04-04', 4); 

INSERT INTO Part (Name, Number, Color) VALUES
('Harness', '1002', 'Black'),
('Drill', '1003', 'Grey'),
('Shovel', '1004', 'White');

INSERT INTO Supplies (Supplier_ID, Part_ID, Cost) VALUES
(1, 2, 100),
(2, 3, 200),
(3, 1, 300); 

SELECT * FROM Supplier;
SELECT * FROM Part;
SELECT * FROM State;
SELECT * FROM Supplies; 


