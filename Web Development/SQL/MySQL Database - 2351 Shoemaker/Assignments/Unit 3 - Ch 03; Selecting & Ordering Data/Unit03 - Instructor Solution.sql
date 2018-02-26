-- 3.1 - Your Name

USE Starter;


-- Faculty members who make less than $80,000
SELECT 
    lastname AS 'Last Name',
    firstname AS 'First Name',
    Scholarship
FROM
    Student
WHERE
    Scholarship > 2500
ORDER BY lastname; 


-- 3.2 - Your Name


USE Starter;

-- Students with the last name Bennett.  
SELECT 
    lastname AS 'Last Name',
    firstname AS 'First Name',
    Email 'Email Address'
FROM
    Student
WHERE
    LastName = 'Cruz'
ORDER BY FirstName ; 


-- 3.3 - Your Name

USE Starter;

-- All students born before 1997, youngest first.

SELECT 
    lastname AS 'Last Name',
    firstname AS 'First Name',
    DateOfBirth 'Date of Birth'
FROM
    Student
WHERE DateOfBirth < '1997-01-01'
ORDER BY DateOfBirth DESC;

-- 3.4 - Your Name
-- All students with scholarship in a range.

USE Starter;

SELECT 
	Scholarship, 
    lastname AS 'Last Name',
    firstname AS 'First Name' 
    
FROM
    Student
WHERE Scholarship >= 2000 AND Scholarship < 3500
ORDER BY Scholarship, LastName ;

-- 3.5 - Your Name

USE Starter;

-- Student Majoring in Computer Science or Information Systems.

SELECT 
    lastname AS 'Last Name',
    firstname AS 'First Name',
    MajorID AS 'Major ID'
FROM
    Student
WHERE
    MajorID IN(1, 2)
ORDER BY LastName;
 

 
-- 3.6 - Your Name

USE Starter;

-- AND and OR.

SELECT 
    Lastname AS 'Last Name',
    Firstname AS 'First Name',
    Email
FROM
    Student
WHERE
    Sex = 'F'
        AND (MajorID = 4 OR MajorID = 7)
ORDER BY ID;
 

-- 3.7 - Your Name

USE Starter;

-- IN Clause

SELECT 
    MajorID,
    lastname AS 'Last Name',
    firstname AS 'First Name',
    Scholarship
FROM
    Student
WHERE
    MajorID IN (1, 3, 6)
        AND Scholarship = 4000
ORDER BY MajorID , LastName;
 

-- 3.8 - Your Name

USE Starter;

-- BETWEEN Clause
SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Email AS 'Email Address',
    EnrolledDate AS 'Date Enrolled',
    Scholarship
FROM
    Student
WHERE
    EnrolledDate BETWEEN '2016-01-01' AND '2016-12-31'
ORDER BY LastName, FirstName;


-- 3.9 - Your Name


USE Starter;

-- LIKE Clause

SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Email AS 'Email Address'
FROM
    Student
WHERE LastName LIKE 'S%'
ORDER BY LastName;


-- 3.10 - Your Name
-- LIMIT Clause
 

USE Starter;


-- LIMIT Clause

SELECT 
    LastName AS 'Last Name',
    FirstName AS 'First Name',
    Email AS 'Email Address',
    DateOfBirth AS 'Birthday'
FROM
    Student
ORDER BY DateOfBirth ASC
LIMIT 5;
 

 

 



 


