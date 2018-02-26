-- Phase 3 Marie Kelling
-- 4. A WHERE clause
USE brendasmek;
SELECT 
    LastName, FirstName, ID
FROM
    Customer
WHERE
    ID > 5
ORDER BY LastName;