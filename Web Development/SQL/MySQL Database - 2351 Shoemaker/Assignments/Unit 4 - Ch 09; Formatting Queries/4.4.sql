-- 4.4 Marie Kelling
-- Displays date 31 days from today
USE starter; 
SELECT DATE_ADD(NOW(), INTERVAL 31 DAY) AS '31 Days';  