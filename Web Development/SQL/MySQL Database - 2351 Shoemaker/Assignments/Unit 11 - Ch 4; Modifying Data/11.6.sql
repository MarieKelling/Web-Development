-- 11.6 Marie Kelling
-- Add new a course, a new section for the course, and a new student who is registered in the section 
USE college;
INSERT INTO course (Name, CreditHours, DepartmentID)
VALUES ('IT 2014 - C# Programming', 4, 1); 

INSERT INTO section (Name, Capacity, CourseID, SemesterID, TaughtByID)
VALUES ('TTH 4:00', 22, 20, 2, 14); 

INSERT INTO student (LastName, FirstName, Email, Sex, DateOfBirth, EnrolledDate, MajorID, Scholarship)
VALUES ('Kelling', 'Marie', 'MarieKelling@college.edu', 'F', '1997-01-28', '2017-11-02', 1, 1000);

INSERT INTO registration (StudentID, SectionID, Grade)
VALUES (102, 51, 3.7);

SELECT * FROM Course WHERE ID = (SELECT MAX(ID) FROM Course);
SELECT * FROM Section WHERE ID = (SELECT MAX(ID) FROM Section);
SELECT * FROM Student WHERE ID = (SELECT MAX(ID) FROM Student);
SELECT * FROM Registration WHERE ID = (SELECT MAX(ID) FROM Registration);