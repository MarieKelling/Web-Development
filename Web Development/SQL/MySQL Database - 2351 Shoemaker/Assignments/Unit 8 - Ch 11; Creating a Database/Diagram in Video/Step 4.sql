-- Step 4
-- Marie Kelling

USE examplemek;

SELECT 
    
    Supplier.Name AS 'Supplier',
    State.Name AS 'State',
    Number AS 'Part Number',
    Part.Name AS 'Part',
    Supplies.Cost AS 'Cost'
FROM
    Part
        INNER JOIN
    Supplies ON Part.ID = Supplies.Part_ID
        INNER JOIN
    Supplier ON Supplies.Supplier_ID = Supplier.ID
        INNER JOIN
    State ON Supplier.State_ID = State.ID;
        
         



