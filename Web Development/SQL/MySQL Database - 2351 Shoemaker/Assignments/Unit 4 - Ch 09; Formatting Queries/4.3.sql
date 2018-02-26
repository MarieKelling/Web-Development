-- 4.3 Marie Kelling
-- Returns my name and the day the query is run on
USE starter;
SELECT 
    'Marie Kelling' AS 'My Name',
    DAYNAME(CURRENT_DATE()) AS 'Today is';
