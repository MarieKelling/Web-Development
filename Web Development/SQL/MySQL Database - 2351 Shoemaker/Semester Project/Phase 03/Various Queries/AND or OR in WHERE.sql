-- Phase 3 Marie Kelling
-- 5. An AND or OR in the WHERE clause
USE brendasmek;
SELECT 
    LastName, FirstName, ID
FROM
    Customer
WHERE
    ID > 10 AND FirstName = 'Calvin'
        OR FirstName = 'Tito'
ORDER BY LastName;