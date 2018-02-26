-- 2.1 Your Name

USE Starter;

-- List all students

SELECT 
    ID,
    LastName,
    FirstName,
    Email,
    Sex,
    DateOfBirth,
    EnrolledDate,
    MajorID,
    Scholarship
FROM
    Student;
    

-- 2.2 Your Name

USE College;

-- List all Sections

SELECT  *
FROM
    Section;
    
    

-- 2.3 Your Name

USE Starter;
 
-- List student information

SELECT  lastname, firstname, email
FROM
    Student;
    
    
    
-- 2.4 Your Name

USE College;

SELECT 
    lastname AS 'Last Name',
    firstname AS 'First Name',
    email 'Email Address'
FROM
    Student;    