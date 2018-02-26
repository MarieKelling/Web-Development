-- 4.1 - Your Name

USE Starter;

-- Lists only students receiving scholarships

SELECT 
    FORMAT(Scholarship, 0) AS Scholarship,
    lastname AS 'Last Name',
    firstname AS 'First Name'
FROM
    Student
WHERE
    Scholarship > 0
ORDER BY CAST(Scholarship AS DECIMAL) DESC , LastName , FirstName; 


-- 4.2 - Your Name

USE Starter;

-- Average scholarship amount among students
-- receiving a scholarship

SELECT 
    ROUND(AVG(Scholarship), 2) as 'Average Scholarship'
FROM
    Student
WHERE Scholarship > 0; 


-- 4.3 - Your Name

USE Starter;

-- Name of the day that the query is run on

SELECT 
    'Frank Shoemaker' AS 'My Name', 
    DAYNAME(NOW()) AS 'Today is' ;
 

-- 4.4 - Your Name

USE Starter;

-- The date that is 31 days from today

SELECT 
    DATE_ADD(NOW(), INTERVAL 31 DAY) AS '31 Days' ;
  
 

-- 4.5 - Your Name

USE Starter;

-- Days Old

SELECT 
    datediff(NOW(), '1993-12-20') AS 'Days Old' ;  