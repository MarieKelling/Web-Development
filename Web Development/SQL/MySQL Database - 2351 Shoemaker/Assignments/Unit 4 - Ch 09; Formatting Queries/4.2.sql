-- 4.2 Marie Kelling
-- Average of Scholarships
USE starter;
SELECT 
    ROUND(AVG(Scholarship), 2) AS 'Average Scholarship'
FROM
    student
WHERE
    Scholarship > 0; 