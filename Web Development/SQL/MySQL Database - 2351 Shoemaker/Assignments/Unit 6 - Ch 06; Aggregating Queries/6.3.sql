-- 6.3 - Marie Kelling
-- List each Major, the number of students in each major, and the average, min, and max Scholarship
USE college;
SELECT 
    Major.Name AS 'Major',
    COUNT(*) AS 'Students',
    FORMAT(AVG(Scholarship), 2) AS 'Average Scholarship',
    FORMAT(MIN(Scholarship), 2) AS 'Lowest Scholarship',
    FORMAT(MAX(Scholarship), 2) AS 'Highest Scholarship'
FROM
    Student
        INNER JOIN
    Major ON Student.MajorID = Major.ID
GROUP BY Major.Name
ORDER BY Major.Name;