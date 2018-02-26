-- 6.2 - Marie Kelling
-- List the number of Faculty members and their average, min, and max Salary
USE college; 
SELECT 
    COUNT(Faculty.ID) AS 'Faculty Members',
    FORMAT(AVG(Salary), 2) AS 'Average Salary',
    FORMAT(MIN(Salary), 2) AS 'Lowest Salary',
    FORMAT(MAX(Salary), 2) AS 'Highest Salary'
FROM
    Faculty;  