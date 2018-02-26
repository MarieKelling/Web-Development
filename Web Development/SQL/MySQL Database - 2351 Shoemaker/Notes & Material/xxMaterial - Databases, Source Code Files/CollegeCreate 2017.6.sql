-- CollegeCreate 2017.6.sql

-- ------------------------------------------------------------------------
-- ------------------------------------------------------------------------
-- 2017.6 version   2017-11-12
-- ------------------------------------------------------------------------
-- ------------------------------------------------------------------------

-- Copyright (C) 2017, Frank Shoemaker.  All rights reserved.


-- Creates all the tables in the College database.
 
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema College
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `College` ;

-- -----------------------------------------------------
-- Schema College
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `College` DEFAULT CHARACTER SET utf8 ;
USE `College` ;

-- -----------------------------------------------------
-- Table `Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Department` ;

CREATE TABLE IF NOT EXISTS `Department` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`ID`)  COMMENT '',
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COMMENT = 'The academic departments in the college';


-- -----------------------------------------------------
-- Table `Course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Course` ;

CREATE TABLE IF NOT EXISTS `Course` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` VARCHAR(45) NOT NULL COMMENT '',
  `CreditHours` INT(11) NOT NULL COMMENT '',
  `DepartmentID` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`ID`)  COMMENT '',
  UNIQUE INDEX `CourseID_UNIQUE` (`ID` ASC)  COMMENT '',
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC)  COMMENT '',
  INDEX `fk_Course_Department1` (`DepartmentID` ASC)  COMMENT '',
  INDEX `fk_Course_Department1_idx` (`ID` ASC)  COMMENT '',
  CONSTRAINT `fk_Course_Department1`
    FOREIGN KEY (`DepartmentID`)
    REFERENCES `Department` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COMMENT = 'The courses offered by academic departments in the college';


-- -----------------------------------------------------
-- Table `Faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Faculty` ;

CREATE TABLE IF NOT EXISTS `Faculty` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `LastName` VARCHAR(45) NOT NULL COMMENT '',
  `FirstName` VARCHAR(45) NOT NULL COMMENT '',
  `Email` VARCHAR(255) NOT NULL COMMENT '' DEFAULT 'bad',
  `HireDate` DATETIME NOT NULL COMMENT '',
  `Salary` DECIMAL(9,2) NOT NULL DEFAULT '0.00' COMMENT '',
  `DepartmentID` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`ID`)  COMMENT '',
  UNIQUE INDEX `Faculty_ID_UNIQUE` (`ID` ASC)  COMMENT '',
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC)  COMMENT '',
  INDEX `fk_Faculty_Department1` (`DepartmentID` ASC)  COMMENT '',
  CONSTRAINT `fk_Faculty_Department1`
    FOREIGN KEY (`DepartmentID`)
    REFERENCES `Department` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'The faculty of the college';


-- -----------------------------------------------------
-- Table `Major`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Major` ;

CREATE TABLE IF NOT EXISTS `Major` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`ID`)  COMMENT '',
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'The various majors offered by the college';


-- -----------------------------------------------------
-- Table `Semester`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Semester` ;

CREATE TABLE IF NOT EXISTS `Semester` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`ID`)  COMMENT '',
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'The semesters in which sections are offered';


-- -----------------------------------------------------
-- Table `Section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Section` ;

CREATE TABLE IF NOT EXISTS `Section` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` VARCHAR(45) NOT NULL COMMENT '',
  `Capacity` INT(11) NOT NULL COMMENT '',
  `CourseID` INT(11) NOT NULL COMMENT '',
  `SemesterID` INT(11) NOT NULL COMMENT '',
  `TaughtByID` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`ID`)  COMMENT '',
  INDEX `fk_Section_TaughtBy1` (`TaughtByID` ASC)  COMMENT '',
  INDEX `fk_Section_Course1_idx` (`CourseID` ASC)  COMMENT '',
  INDEX `fk_Section_Semester1_idx` (`SemesterID` ASC)  COMMENT '',
  UNIQUE INDEX `Section_Unique` (`CourseID` ASC, `SemesterID` ASC, `TaughtByID` ASC)  COMMENT '',
  CONSTRAINT `fk_Section_Course1`
    FOREIGN KEY (`CourseID`)
    REFERENCES `Course` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Section_Semester1`
    FOREIGN KEY (`SemesterID`)
    REFERENCES `Semester` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Section_TaughtBy1`
    FOREIGN KEY (`TaughtByID`)
    REFERENCES `Faculty` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A section is an offering of a course at a specific time in a specific sememster';


-- -----------------------------------------------------
-- Table `Student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Student` ;

CREATE TABLE IF NOT EXISTS `Student` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `LastName` VARCHAR(45) NOT NULL COMMENT '',
  `FirstName` VARCHAR(45) NOT NULL COMMENT '',
  `Email` VARCHAR(45) NOT NULL COMMENT '',
  `Sex` CHAR(1) NOT NULL COMMENT '',
  `DateOfBirth` DATE NOT NULL COMMENT '',
  `EnrolledDate` DATE NOT NULL COMMENT '',
  `MajorID` INT(11) NULL DEFAULT NULL COMMENT '',
  `Scholarship` DECIMAL(9,2) NOT NULL DEFAULT '0.00' COMMENT '',
  PRIMARY KEY (`ID`)  COMMENT '',
  UNIQUE INDEX `Student_ID_UNIQUE` (`ID` ASC)  COMMENT '',
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC)  COMMENT '',
  INDEX `fk_Course_Major1` (`MajorID` ASC)  COMMENT '',
  CONSTRAINT `fk_Course_Major1`
    FOREIGN KEY (`MajorID`)
    REFERENCES `Major` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Records each student in the college';


-- -----------------------------------------------------
-- Table `Registration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Registration` ;

CREATE TABLE IF NOT EXISTS `Registration` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `StudentID` INT(11) NOT NULL COMMENT '',
  `SectionID` INT(11) NOT NULL COMMENT '',
  `Grade` DECIMAL(2,1) NOT NULL DEFAULT '0.0' COMMENT '',
  PRIMARY KEY (`ID`)  COMMENT '',
  UNIQUE INDEX `Registration_Unique` (`StudentID` ASC, `SectionID` ASC)  COMMENT 'Allow a student to register for a section only once.',
  INDEX `fk_Student_has_Section_Section1_idx` (`SectionID` ASC)  COMMENT '',
  INDEX `fk_Student_has_Section_Student1_idx` (`StudentID` ASC)  COMMENT '',
  CONSTRAINT `fk_Student_has_Section_Section1`
    FOREIGN KEY (`SectionID`)
    REFERENCES `Section` (`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_has_Section_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `Student` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Records a student registering for a section';


-- -----------------------------------------------------
-- Table `Club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club` ;

CREATE TABLE IF NOT EXISTS `Club` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`ID`)  COMMENT '',
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Membership`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Membership` ;

CREATE TABLE IF NOT EXISTS `Membership` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `ClubID` INT NOT NULL COMMENT '',
  `StudentID` INT NOT NULL COMMENT '',
  `DateJoined` DATE NOT NULL COMMENT '',
  INDEX `fk_Club_has_Student_Student1_idx` (`StudentID` ASC)  COMMENT '',
  INDEX `fk_Club_has_Student_Club1_idx` (`ClubID` ASC)  COMMENT '',
  PRIMARY KEY (`ID`)  COMMENT '',
  UNIQUE INDEX `Membership_Unique` (`ClubID` ASC, `StudentID` ASC)  COMMENT '',
  CONSTRAINT `fk_Club_has_Student_Club1`
    FOREIGN KEY (`ClubID`)
    REFERENCES `Club` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Club_has_Student_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `Student` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- -----------------------------------------------------
-- Table DBVersion
-- -----------------------------------------------------
DROP TABLE IF EXISTS DBVersion ;

CREATE TABLE IF NOT EXISTS DBVersion (
  ID INT(11) NOT NULL AUTO_INCREMENT,
  Name VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Contains the version of the database.';

 


-- -----------------------------------------------------
-- End of Tables
-- -----------------------------------------------------

 

 

-------------------------------------------------------------------------------------------
--
--  Load data into the tables
--
-------------------------------------------------------------------------------------------
 
-------------------------------------------------------------------------------------------
--
--  Semester
--
-------------------------------------------------------------------------------------------
INSERT INTO semester (Name)	
VALUES ('2017 - Spring'),
	   ('2017 - Fall');


 
-------------------------------------------------------------------------------------------
--
--  Major
--
-------------------------------------------------------------------------------------------
INSERT INTO Major (Name)	
	VALUES ('Computer Science'),
		 ('Information Systems'),
		 ('Mathematics'),
		 ('Biology'),
		 ('Nursing'),
		 ('Criminal Justice'),
		 ('Anthropology'),
		 ('Steam Technology');

-------------------------------------------------------------------------------------------
--
--  Department
--
-------------------------------------------------------------------------------------------
INSERT INTO department (Name)	
 VALUES   ('Information Technology'),
		   ('Mathematics'),
		   ('Nursing'),
		   ('Biology'),
		   ('Romance Languages'),
		   ('Hospitality Management'),
		   ('Early Childhood'),
		   ('Physical Education'),
		   ('Business Management'),
		   ('Anthropology');

-------------------------------------------------------------------------------------------
--
--  Course
--
-------------------------------------------------------------------------------------------
 INSERT INTO course (Name, DepartmentID, CreditHours) 
 VALUES ('IT 1000 - Intro to Computer Systems', 1, 3), 
		   ('IT 1010 - Intro to Programming', 1, 3), 
		   ('IT 2000 - Database Systems', 1, 4), 
		   ('IT 2020 - Project Management', 1, 4), 

		   ('MT 1000 - College Math', 2, 4) , 
		   ('MT 1010 - Linear Algebra', 2, 4), 
		   ('MT 2000 - Math for Business', 2, 3) , 
		   ('MT 2020 - Pre-calculus', 2, 3), 

		   ('BI 1000 - Intro to Biology', 4, 4) , 
		   ('BI 1012 - Biologial Systems', 4, 3), 
		 
           ('BZ 2000 - Math for Finance', 9, 3) , 
		   ('BZ 2020 - Mangerial Capstone', 9, 3), 
		   
           ('RL 1035 - Romanian I', 5, 3), 

		   ('NS 1000 - Human Anatomy', 3, 3), 
		   ('NS 1010 - Pharmacology', 3, 4), 
		   ('NS 1020 - Blood Letting', 3, 4), 
           
		   ('NS 2000 - Specialized Health Care Needs', 3, 4), 
		   ('NS 2020 - Self Care Needs: Adult Life Span', 3, 4), 
		   ('NS 2020 - Internship', 3, 2); 

-------------------------------------------------------------------------------------------
--
--  Faculty
--
-------------------------------------------------------------------------------------------
 insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (1, 'Kevin', 'Patterson', 'KevinPatterson@college.edu', 61726, '2013-02-24', 3);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (2, 'Joshua', 'Mills', 'JoshuaMills@college.edu', 112204, '2015-10-06', 4);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (3, 'Thomas', 'Harvey', 'ThomasHarvey@college.edu', 57679, '2014-08-11', 3);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (4, 'Edward', 'Howard', 'EdwardHoward@college.edu', 113932, '2011-07-05', 1);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (5, 'Jack', 'Lopez', 'JackLopez@college.edu', 98791, '2015-01-04', 10);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (6, 'Jessica', 'Boyd', 'JessicaBoyd@college.edu', 69520, '2015-06-28', 10);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (7, 'Chris', 'Hill', 'ChrisHill@college.edu', 69624, '2016-03-28', 8);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (8, 'David', 'Hall', 'DavidHall@college.edu', 54641, '2013-02-24', 8);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (9, 'Rose', 'Mcdonald', 'RoseMcdonald@college.edu', 77685, '2011-12-21', 3);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (10, 'Howard', 'Patterson', 'HowardPatterson@college.edu', 86454, '2015-11-19', 2);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (11, 'Debra', 'Rogers', 'DebraRogers@college.edu', 54789, '2012-07-27', 3);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (12, 'Deborah', 'Long', 'DeborahLong@college.edu', 66346, '2011-10-23', 7);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (13, 'Jack', 'Murray', 'JackMurray@college.edu', 116028, '2011-04-10', 9);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (14, 'Jerry', 'Austin', 'JerryAustin@college.edu', 75813, '2014-02-20', 1);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (15, 'Deborah', 'Robinson', 'DeborahRobinson@college.edu', 114503, '2013-08-19', 4);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (16, 'Lisa', 'Murphy', 'LisaMurphy@college.edu', 58602, '2010-11-29', 1);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (17, 'Shawn', 'Carr', 'ShawnCarr@college.edu', 117909, '2010-10-31', 7);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (18, 'Ryan', 'White', 'RyanWhite@college.edu', 57110, '2013-11-11', 3);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (19, 'Frank', 'Stephens', 'FrankStephens@college.edu', 122163, '2010-08-30', 3);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (20, 'Adam', 'Smith', 'AdamSmith@college.edu', 124503, '2012-11-24', 3);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (21, 'Ruth', 'Castillo', 'RuthCastillo@college.edu', 90836, '2015-09-22', 2);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (22, 'Diane', 'Rodriguez', 'DianeRodriguez@college.edu', 85907, '2011-02-22', 1);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (23, 'Sandra', 'George', 'SandraGeorge@college.edu', 114645, '2014-01-24', 4);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (24, 'Larry', 'Burke', 'LarryBurke@college.edu', 103633, '2015-01-25', 2);
insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (25, 'Kathy', 'Wood', 'KathyWood@college.edu', 121608, '2012-11-23', 4);

insert into faculty (id, FirstName, LastName, EMail, Salary, HireDate, DepartmentID) values (26, 'Mary', 'Albright', 'MaryAlbright@college.edu', '90658.25', '2011-05-22', 5);




-------------------------------------------------------------------------------------------
--
--  Club
--
-------------------------------------------------------------------------------------------
INSERT INTO Club (Name) 
VALUES 	('Photography Club'), 
		('Game Design Club'),
		('Engineering Club'),
		('American Sign Language'),
		('Vet Tech Club'),
		('Veterans Today') ;

-------------------------------------------------------------------------------------------
--
--  Student
--
-------------------------------------------------------------------------------------------
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Andy', 'Anderson', 'VirginiaGomez@college.edu', '1985-06-22', 'F', '2012-08-10', 5, 1999);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Rachel', 'Nguyen', 'RachelNguyen@college.edu', '1988-12-17', 'F', '2015-05-04', 1, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Bruce', 'Gilbert', 'BruceGilbert@college.edu', '1998-01-16', 'M', '2014-12-29', 3, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Phyllis', 'Nguyen', 'PhyllisNguyen@college.edu', '1994-02-02', 'F', '2015-10-05', 4, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Nancy', 'Long', 'NancyLong@college.edu', '1985-05-04', 'F', '2014-06-06', 4, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Henry', 'Berry', 'HenryBerry@college.edu', '1997-09-27', 'M', '2013-06-20', 6, 3500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Sean', 'Crawford', 'SeanCrawford@college.edu', '1990-07-22', 'M', '2013-07-02', 1, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Anthony', 'Ruiz', 'AnthonyRuiz@college.edu', '1985-11-23', 'M', '2015-09-10', 6, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Maria', 'Ortiz', 'MariaOrtiz@college.edu', '1989-12-02', 'F', '2014-04-28', 7, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Brenda', 'Berry', 'BrendaBerry@college.edu', '1991-03-17', 'F', '2013-02-12', 2, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Michael', 'Lawson', 'MichaelLawson@college.edu', '1993-06-03', 'M', '2014-02-28', 1, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Katherine', 'Gibson', 'KatherineGibson@college.edu', '1996-02-06', 'F', '2014-05-08', 1, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Amanda', 'Henderson', 'AmandaHenderson@college.edu', '1988-09-14', 'F', '2014-01-06', 3, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Willie', 'Webb', 'WillieWebb@college.edu', '1992-09-19', 'M', '2012-06-14', 6, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Marie', 'Nichols', 'MarieNichols@college.edu', '1990-10-15', 'F', '2016-02-07', 1, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Beverly', 'Lane', 'BeverlyLane@college.edu', '1991-07-14', 'F', '2014-11-15', 2, 500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Karen', 'Day', 'KarenDay@college.edu', '1995-05-23', 'F', '2012-10-27', 3, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Katherine', 'Jackson', 'KatherineJackson@college.edu', '1988-11-30', 'F', '2015-07-02', 2, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Janice', 'Cole', 'JaniceCole@college.edu', '1992-10-26', 'F', '2012-12-05', 6, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kathleen', 'Kelley', 'KathleenKelley@college.edu', '1994-04-18', 'F', '2014-10-09', 1, 1500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Cynthia', 'Harrison', 'CynthiaHarrison@college.edu', '1986-02-27', 'F', '2014-10-03', 4, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Katherine', 'Hernandez', 'KatherineHernandez@college.edu', '1996-01-26', 'F', '2014-06-15', 6, 1500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Barbara', 'Greene', 'BarbaraGreene@college.edu', '1995-10-21', 'F', '2015-02-25', 1, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Carlos', 'Carr', 'CarlosCarr@college.edu', '1995-11-01', 'M', '2014-06-04', 6, 1500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kathryn', 'George', 'KathrynGeorge@college.edu', '1992-03-09', 'F', '2013-01-10', NULL, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Douglas', 'Williamson', 'DouglasWilliamson@college.edu', '1988-07-18', 'M', '2015-12-27', 2, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Charles', 'Miller', 'CharlesMiller@college.edu', '1986-02-23', 'M', '2015-12-23', 7, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Juan', 'Howell', 'JuanHowell@college.edu', '1987-02-18', 'M', '2014-09-02', 6, 500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jonathan', 'Andrews', 'JonathanAndrews@college.edu', '1993-05-29', 'M', '2016-02-09', 2, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Mildred', 'Gardner', 'MildredGardner@college.edu', '1990-02-22', 'F', '2012-08-15', NULL, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Andrew', 'Mcdonald', 'AndrewMcdonald@college.edu', '1997-12-08', 'M', '2013-12-05', 1, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Norma', 'Gilbert', 'NormaGilbert@college.edu', '1985-07-25', 'F', '2012-09-15', 5, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Henry', 'Stephens', 'HenryStephens@college.edu', '1991-10-29', 'M', '2015-08-22', 5, 2500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Stephen', 'Freeman', 'StephenFreeman@college.edu', '1986-06-13', 'M', '2014-05-27', 7, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Nancy', 'Riley', 'NancyRiley@college.edu', '1995-02-15', 'F', '2013-03-19', 2, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Carlos', 'Spencer', 'CarlosSpencer@college.edu', '1994-06-18', 'M', '2015-07-22', 4, 1500);
insert into Student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) VALUES ('Eduardo', 'Egghead', 'EduardoEgghead@college.edu', '1982-12-08', 'M', '2016-10-18', NULL, 105000) ;
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Andrew', 'Campbell', 'AndrewCampbell@college.edu', '1991-09-17', 'M', '2014-08-16', NULL, 4500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Chris', 'Collins', 'ChrisCollins@college.edu', '1988-12-15', 'M', '2013-10-06', 2, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Walter', 'Allen', 'WalterAllen@college.edu', '1994-04-17', 'M', '2013-11-01', 3, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Laura', 'Oliver', 'LauraOliver@college.edu', '1995-07-04', 'F', '2012-05-28', NULL, 500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jesse', 'Riley', 'JesseRiley@college.edu', '1994-07-26', 'M', '2013-01-12', 5, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Frances', 'Lewis', 'FrancesLewis@college.edu', '1997-03-05', 'F', '2012-06-26', 7, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Gerald', 'Hawkins', 'GeraldHawkins@college.edu', '1994-01-15', 'M', '2015-12-04', 3, 3500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ryan', 'Kelly', 'RyanKelly@college.edu', '1993-11-13', 'M', '2015-11-18', 4, 2500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Phillip', 'Oliver', 'PhillipOliver@college.edu', '1987-06-02', 'M', '2014-09-26', 3, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Louis', 'Coleman', 'LouisColeman@college.edu', '1986-05-05', 'M', '2014-11-16', NULL, 1500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Roy', 'Mitchell', 'RoyMitchell@college.edu', '1994-04-14', 'M', '2015-12-02', 6, 2500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Deborah', 'Reid', 'DeborahReid@college.edu', '1996-06-04', 'F', '2015-10-13', 6, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Randy', 'Hansen', 'RandyHansen@college.edu', '1997-11-23', 'M', '2014-02-08', NULL, 500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jessica', 'Johnson', 'JessicaJohnson@college.edu', '1996-12-20', 'F', '2013-09-19', 5, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Todd', 'Lawrence', 'ToddLawrence@college.edu', '1985-09-03', 'M', '2012-06-10', 3, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Christopher', 'Collins', 'ChristopherCollins@college.edu', '1987-06-06', 'M', '2012-12-28', 3, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Paula', 'Castillo', 'PaulaCastillo@college.edu', '1996-11-18', 'F', '2016-01-27', 3, 4500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Benjamin', 'Fowler', 'BenjaminFowler@college.edu', '1991-11-28', 'M', '2012-08-27', NULL, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Julia', 'Elliott', 'JuliaElliott@college.edu', '1995-07-14', 'F', '2014-11-15', 3, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Christine', 'Olson', 'ChristineOlson@college.edu', '1988-06-16', 'F', '2013-01-07', 2, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Nicholas', 'Mason', 'NicholasMason@college.edu', '1992-12-26', 'M', '2013-11-04', 5, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jimmy', 'Burke', 'JimmyBurke@college.edu', '1992-05-24', 'M', '2013-10-26', 6, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Craig', 'Carr', 'CraigCarr@college.edu', '1990-12-09', 'M', '2015-04-01', 3, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('James', 'Carter', 'JamesCarter@college.edu', '1995-03-23', 'M', '2015-08-23', 6, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kathryn', 'Moreno', 'KathrynMoreno@college.edu', '1996-06-15', 'F', '2014-04-19', 2, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Roger', 'Sanders', 'RogerSanders@college.edu', '1990-09-14', 'M', '2012-08-30', 2, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jason', 'Sims', 'JasonSims@college.edu', '1994-03-16', 'M', '2013-04-27', 7, 4500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Joyce', 'Myers', 'JoyceMyers@college.edu', '1997-04-06', 'F', '2015-03-09', 4, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kevin', 'Morgan', 'KevinMorgan@college.edu', '1988-02-09', 'M', '2016-03-01', 5, 500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Sarah', 'Martin', 'SarahMartin@college.edu', '1995-01-13', 'F', '2014-01-09', 1, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Stephen', 'Andrews', 'StephenAndrews@college.edu', '1989-04-25', 'M', '2015-03-11', 1, 1500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Gerald', 'Vasquez', 'GeraldVasquez@college.edu', '1997-01-10', 'M', '2013-10-15', 2, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Roy', 'Adams', 'RoyAdams@college.edu', '1998-03-22', 'M', '2014-10-26', 2, 4500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Melissa', 'Hart', 'MelissaHart@college.edu', '1996-07-10', 'F', '2016-02-14', 6, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Albert', 'Carter', 'AlbertCarter@college.edu', '1996-03-14', 'M', '2014-02-01', 2, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jason', 'Spencer', 'JasonSpencer@college.edu', '1993-07-24', 'M', '2012-12-25', 4, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Rose', 'Green', 'RoseGreen@college.edu', '1987-07-18', 'F', '2013-07-24', 5, 2500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('George', 'Hernandez', 'GeorgeHernandez@college.edu', '1989-01-26', 'M', '2014-06-15', 4, 4500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Bruce', 'Graham', 'BruceGraham@college.edu', '1990-01-23', 'M', '2012-11-03', 4, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('James', 'George', 'JamesGeorge@college.edu', '1997-08-29', 'M', '2015-06-09', 2, 2500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jack', 'Reyes', 'JackReyes@college.edu', '1989-01-08', 'M', '2013-05-09', 1, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jerry', 'Lee', 'JerryLee@college.edu', '1989-07-20', 'M', '2015-10-17', 4, 500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kathryn', 'Palmer', 'KathrynPalmer@college.edu', '1988-07-16', 'F', '2015-01-03', 2, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Charles', 'Long', 'CharlesLong@college.edu', '1992-03-09', 'M', '2013-12-02', 4, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Lawrence', 'Parker', 'LawrenceParker@college.edu', '1989-01-07', 'M', '2013-01-13', 6, 2500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ralph', 'Simmons', 'RalphSimmons@college.edu', '1987-01-18', 'M', '2013-06-16', 1, 1500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jonathan', 'Rivera', 'JonathanRivera@college.edu', '1985-09-25', 'M', '2015-11-27', 3, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ruby', 'Richardson', 'RubyRichardson@college.edu', '1994-06-19', 'F', '2013-12-22', 1, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jennifer', 'Young', 'JenniferYoung@college.edu', '1991-03-03', 'F', '2013-05-14', 4, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jason', 'James', 'JasonJames@college.edu', '1989-11-11', 'M', '2016-01-10', 7, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Christine', 'Lynch', 'ChristineLynch@college.edu', '1994-09-17', 'F', '2013-08-22', 2, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('George', 'Anderson', 'GeorgeAnderson@college.edu', '1985-12-30', 'M', '2012-12-25', 5, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Daniel', 'Edwards', 'DanielEdwards@college.edu', '1990-01-05', 'M', '2014-07-27', 4, 2500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Joe', 'Clark', 'JoeClark@college.edu', '1990-10-23', 'M', '2014-11-18', 5, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ralph', 'Thompson', 'RalphThompson@college.edu', '1991-10-29', 'M', '2012-10-25', 7, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Craig', 'Burns', 'CraigBurns@college.edu', '1995-07-25', 'M', '2014-08-02', 4, 4500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jonathan', 'Watson', 'JonathanWatson@college.edu', '1996-08-02', 'M', '2012-08-21', 4, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Andrea', 'Rivera', 'AndreaRivera@college.edu', '1991-12-18', 'F', '2014-01-29', 2, 3500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Christine', 'Austin', 'ChristineAustin@college.edu', '1990-02-11', 'F', '2015-09-09', 1, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Daniel', 'Gordon', 'DanielGordon@college.edu', '1995-08-05', 'M', '2014-06-15', 2, 2500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Maria', 'George', 'MariaGeorge@college.edu', '1990-01-26', 'F', '2014-05-04', 3, 3500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Julie', 'Kelley', 'JulieKelley@college.edu', '1998-02-07', 'F', '2012-05-10', 1, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Albert', 'Ray', 'AlbertRay@college.edu', '1997-03-07', 'M', '2013-08-02', 5, 500);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Theresa', 'Hunt', 'TheresaHunt@college.edu', '1988-04-27', 'F', '2012-11-27', 3, 2500);
-------------------------------------------------------------------------------------------
--
--  Section
--
-------------------------------------------------------------------------------------------
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 2:00', 25, 10, 6, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 25, 8, 4, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 18, 4, 2, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 20, 15, 10, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 22, 14, 3, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 25, 2, 25, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 2:00', 18, 9, 22, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 2:00', 18, 1, 23, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 18, 18, 5, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 2:00', 22, 4, 23, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 2:00', 18, 10, 17, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 22, 5, 1, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 22, 17, 8, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 22, 2, 10, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 25, 12, 1, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 20, 10, 14, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 22, 3, 25, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 25, 12, 19, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 2:00', 25, 14, 9, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 2:00', 25, 15, 10, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 22, 11, 9, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 22, 10, 7, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 18, 8, 23, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 22, 3, 1, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 18, 5, 4, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 25, 9, 8, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 25, 2, 8, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 25, 10, 18, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 20, 9, 20, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 25, 9, 3, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 2:00', 20, 2, 6, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 2:00', 25, 6, 25, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 25, 17, 19, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 18, 15, 19, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 20, 11, 8, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 18, 11, 24, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 18, 12, 3, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 22, 5, 21, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 20, 5, 13, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 18, 5, 6, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 2:00', 20, 2, 2, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 25, 4, 20, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 2:00', 20, 4, 22, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 25, 18, 23, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 22, 14, 7, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 20, 18, 1, 1);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 25, 7, 21, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('TTH 10:00', 25, 18, 20, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 9:50', 20, 7, 25, 2);
insert into Section (Name, Capacity, CourseID, TaughtbyID, SemesterID) values ('MWF 1:50', 18, 14, 23, 2);




-------------------------------------------------------------------------------------------
--
--  registration
--
-------------------------------------------------------------------------------------------
INSERT INTO registration (StudentID, SectionID, Grade) 
VALUES (85, 1, 3.8),
	(92, 18, 1.2),
   (87, 13, 2.6),
   (34, 6, 3.9),
   (33, 15, 2.2),
   (85, 2, 1.2),
   (40, 4, 3.8),
   (90, 12, 2.2),
   (91, 4, 2.6),
   (42, 20, 2.0),
   (14, 8, 1.7),
   (83, 2, 2.4),
   (32, 2, 2.3),
   (18, 13, 3.9),
   (98, 14, 3.7),
   (64, 1, 3.7),
   (88, 10, 3.9),
   (75, 18, 1.7),
   (51, 15, 1.6),
   (37, 19, 2.6),
   (15, 19, 3.5),
   (88, 20, 2.4),
   (86, 1, 2.4),
   (38, 3, 1.9),
   (5, 8, 3.3),
   (73, 18, 2.6),
   (48, 19, 3.9),
   (51, 7, 3.9),
   (24, 18, 3.4),
   (71, 2, 2.3),
   (42, 2, 1.7),
   (42, 11, 2.1),
   (37, 9, 2.3),
   (59, 13, 3.6),
   (72, 3, 3.4),
   (25, 3, 3.8),
   (76, 4, 3.9),
   (85, 6, 3.4),
   (14, 14, 1.3),
   (17, 19, 1.6),
   (77, 9, 3.6),
   (77, 1, 3.8),
   (72, 9, 1.3),
   (12, 2, 2.1),
   (6, 8, 2.4),
   (43, 10, 3.1),
   (11, 18, 2.4),
   (17, 9, 3.8),
   (15, 1, 1.3),
   (89, 5, 3.8),
   (12, 5, 1.5),
   (76, 17, 2.4),
   (47, 20, 1.0),
   (51, 6, 3.9),
   (78, 4, 2.0),
   (62, 3, 1.3),
   (34, 9, 3.1),
   (89, 4, 2.1),
   (68, 7, 3.0),
   (17, 7, 3.8),
   (1, 3, 2.0),
   (33, 20, 3.2),
   (89, 11, 2.4),
   (48, 15, 3.2),
   (25, 17, 1.9),
   (56, 17, 3.8),
   (59, 2, 2.5),
   (41, 6, 2.0),
   (35, 5, 1.6),
   (36, 11, 1.9),
   (38, 20, 3.9),
   (6, 1, 3.5),
   (18, 15, 3.6),
   (80, 17, 2.6),
   (1, 11, 3.8),
   (66, 10, 3.6),
   (83, 12, 2.4),
   (50, 6, 3.8),
   (11, 12, 3.7),
   (29, 13, 3.7),
   (7, 20, 2.4),
   (56, 3, 3.0),
   (58, 5, 3.2),
   (9, 3, 3.1),
   (10, 11, 3.3),
   (63, 1, 3.8),
   (82, 9, 3.8),
   (60, 2, 2.5),
   (96, 17, 3.7),
   (43, 19, 3.9),
   (53, 10, 3.9),
   (98, 7, 3.5),
   (54, 18, 1.1),
   (94, 15, 1.9),
   (78, 5, 2.6),
   (72, 5, 3.5),
   (77, 4, 3.9),
   (60, 3, 1.0),
   (86, 19, 2.6),
   (54, 9, 1.2),
   (74, 13, 2.5),
   (52, 10, 3.1),
   (70, 12, 3.5),
   (42, 7, 1.6),
   (81, 5, 1.9),
   (47, 6, 3.8),
   (90, 6, 3.7),
   (80, 3, 1.1),
   (57, 12, 3.0),
   (76, 19, 1.6),
   (42, 8, 1.7),
   (73, 10, 1.1),
   (78, 13, 1.3),
   (11, 15, 2.3),
   (14, 9, 3.9),
   (9, 2, 3.5),
   (52, 6, 3.7),
   (44, 6, 2.1),
   (1, 4, 3.9),
   (74, 4, 3.8),
   (92, 20, 3.3),
   (49, 1, 1.3),
   (14, 18, 3.8),
   (57, 13, 3.1),
   (83, 13, 3.7),
   (2, 2, 3.4),
   (74, 5, 3.9),
   (44, 5, 3.6),
   (58, 18, 2.1),
   (45, 8, 1.1),
   (86, 5, 3.2),
   (20, 3, 3.7),
   (18, 8, 1.9),
   (73, 14, 3.7),
   (70, 14, 3.8),
   (71, 4, 1.1),
   (65, 2, 3.8),
   (81, 2, 2.4),
   (34, 15, 2.2),
   (97, 12, 2.4),
   (71, 7, 1.3),
   (48, 20, 2.2),
   (25, 6, 3.4),
   (42, 14, 2.6),
   (13, 19, 1.7),
   (24, 11, 1.5),
   (77, 5, 2.6),
   (2, 14, 2.3),
   (64, 13, 3.1),
   (69, 17, 2.2),
   (65, 19, 2.3),
   (14, 19, 3.6),
   (38, 6, 3.9),
   (44, 7, 1.1),
   (71, 17, 3.7),
   (30, 15, 3.0),
   (70, 15, 3.8),
   (42, 1, 2.5),
   (45, 4, 1.1),
   (22, 14, 3.9),
   (89, 8, 2.3),
   (5, 7, 1.3),
   (93, 13, 1.7),
   (81, 10, 3.2),
   (93, 15, 3.7),
   (69, 12, 3.1),
   (59, 11, 3.9),
   (52, 18, 1.9),
   (34, 11, 3.1),
   (50, 12, 1.1),
   (96, 18, 3.9),
   (50, 20, 3.8),
   (23, 10, 1.9),
   (47, 17, 1.5),
   (39, 6, 1.9),
   (21, 19, 3.8),
   (37, 2, 1.2),
   (17, 3, 3.7),
   (41, 2, 2.1),
   (92, 2, 2.0),
   (40, 20, 2.1),
   (6, 11, 3.7),
   (11, 2, 3.3),
   (87, 9, 3.9),
   (59, 6, 1.0),
   (12, 3, 3.9),
   (26, 6, 3.9),
   (58, 11, 2.5),
   (17, 14, 3.2),
   (92, 19, 1.1),
   (33, 7, 1.7),
   (14, 11, 1.2),
   (54, 19, 2.0),
   (97, 5, 1.7),
   (31, 19, 1.1),
   (86, 11, 3.7),
   (15, 11, 3.9),
   (91, 3, 1.7),
   (70, 7, 1.1),
   (17, 15, 3.7),
   (20, 16, 3.8),
   (87, 18, 3.9),
   (9, 1, 3.6),
   (81, 11, 3.8),
   (53, 6, 3.8),
   (61, 1, 3.8),
   (76, 7, 2.4),
   (30, 10, 3.1),
   (97, 15, 1.6),
   (85, 8, 3.2),
   (15, 2, 3.7),
   (24, 15, 1.5),
   (22, 8, 3.3),
   (79, 15, 3.9),
   (50, 15, 3.9),
   (54, 14, 3.1),
   (49, 5, 2.5),
   (63, 2, 1.6),
   (41, 17, 3.9),
   (48, 2, 4.0),
   (17, 12, 2.0),
   (2, 12, 3.4),
   (34, 14, 3.7),
   (46, 19, 1.5),
   (33, 3, 3.4),
   (24, 20, 2.3),
   (84, 14, 3.7),
   (5, 2, 3.2),
   (15, 5, 3.7),
   (42, 6, 3.8),
   (22, 16, 3.8),
   (38, 14, 1.3),
   (93, 1, 2.4),
   (22, 12, 3.7),
   (88, 11, 2.6),
   (95, 15, 3.5),
   (39, 5, 3.5),
   (21, 20, 3.1),
   (71, 1, 2.4),
   (54, 13, 2.3),
   (56, 18, 3.4),
   (66, 8, 3.6),
   (4, 16, 2.0),
   (52, 4, 1.0),
   (1, 5, 2.4),
   (16, 19, 3.9),
   (34, 8, 2.4),
   (13, 3, 1.3),
   (84, 19, 3.4),
   (43, 16, 3.9),
   (100, 7, 3.8),
   (34, 18, 1.6),
   (21, 18, 2.2),
   (11, 13, 3.1),
   (15, 7, 1.5),
   (51, 8, 2.2),
   (92, 17, 2.2),
   (91, 19, 3.9),
   (48, 4, 3.7),
   (92, 1, 1.6),
   (61, 8, 1.2),
   (3, 20, 3.4),
   (25, 13, 1.2),
   (92, 4, 1.3),
   (39, 3, 3.0),
   (52, 13, 2.3),
   (73, 19, 3.7),
   (8, 17, 3.5),
   (2, 5, 2.4),
   (76, 14, 2.4),
   (57, 7, 3.8),
   (33, 1, 2.3),
   (79, 18, 2.4),
   (13, 18, 3.9),
   (25, 18, 3.7),
   (54, 8, 3.4),
   (9, 15, 2.4),
   (79, 8, 3.8),
   (72, 20, 2.3),
   (7, 3, 2.2),
   (52, 7, 3.0),
   (12, 11, 1.7),
   (36, 5, 3.7),
   (90, 9, 2.0),
   (60, 5, 1.1),
   (25, 12, 1.5),
   (46, 1, 3.0),
   (89, 18, 3.5),
   (94, 10, 3.2),
   (34, 2, 3.8),
   (45, 9, 3.2),
   (54, 3, 2.4),
   (11, 20, 3.5),
   (17, 2, 3.7),
   (36, 14, 2.1),
   (29, 9, 2.4),
   (38, 10, 2.6),
   (49, 20, 3.9),
   (13, 12, 3.6),
   (58, 8, 1.5),
   (4, 12, 3.1),
   (68, 4, 3.6),
   (4, 4, 3.7),
   (25, 19, 3.3),
   (55, 4, 3.8),
   (15, 17, 3.8),
   (62, 17, 3.9),
   (36, 17, 2.5),
   (42, 12, 1.7),
   (82, 15, 3.2),
   (49, 11, 2.1),
   (28, 4, 3.8),
   (57, 1, 3.0),
   (31, 17, 1.1),
   (56, 11, 1.0),
   (63, 12, 3.2),
   (14, 2, 2.0),
   (21, 12, 3.7),
   (21, 4, 3.8),
   (45, 14, 3.9),
   (55, 8, 3.8),
   (31, 1, 3.6),
   (35, 10, 3.5),
   (41, 13, 3.3),
   (57, 5, 1.7),
   (33, 5, 3.8),
   (36, 15, 2.4),
   (75, 2, 3.6),
   (67, 13, 3.8),
   (76, 8, 3.8),
   (55, 18, 2.1),
   (76, 18, 2.6),
   (65, 7, 3.0),
   (86, 4, 2.4),
   (25, 4, 3.7),
   (95, 2, 3.7),
   (13, 8, 2.3),
   (20, 9, 3.2),
   (68, 18, 1.5),
   (80, 12, 1.7),
   (9, 6, 2.6),
   (22, 1, 3.0),
   (76, 2, 3.5),
   (60, 20, 1.6),
   (2, 9, 2.5),
   (53, 18, 1.1),
   (60, 14, 2.2),
   (75, 12, 3.9),
   (70, 17, 3.3),
   (82, 11, 1.3),
   (55, 11, 3.7),
   (92, 5, 3.9),
   (37, 5, 2.4),
   (33, 4, 1.9),
   (69, 10, 3.6),
   (45, 5, 2.4),
   (81, 8, 2.4),
   (54, 12, 2.2),
   (85, 10, 3.5),
   (100, 19, 1.7),
   (26, 10, 3.8),
   (7, 7, 1.2),
   (9, 7, 3.7),
   (10, 10, 3.8),
   (45, 13, 1.7),
   (33, 11, 2.0),
   (92, 10, 3.8),
   (49, 15, 3.7),
   (79, 9, 3.4),
   (33, 13, 3.2),
   (4, 5, 3.7),
   (16, 5, 3.8),
   (43, 13, 2.4),
   (32, 13, 1.3),
   (26, 9, 1.3),
   (42, 4, 3.3),
   (15, 15, 3.3),
   (72, 14, 3.1),
   (99, 2, 2.0),
   (91, 2, 2.4),
   (52, 12, 1.7),
   (53, 17, 1.7),
   (98, 13, 3.7),
   (94, 7, 3.9),
   (25, 5, 3.5),
   (63, 14, 3.6),
   (16, 6, 3.6),
   (86, 13, 2.1),
   (77, 3, 1.5),
   (55, 2, 1.6),
   (5, 13, 2.3),
   (42, 17, 1.5),
   (23, 7, 1.9),
   (69, 9, 3.6),
   (77, 11, 3.7),
   (55, 19, 1.6),
   (8, 9, 1.6),
   (51, 1, 3.4),
   (101, 10, 0);


insert into Membership (ClubID, StudentID, DateJoined) values (2, 18, '2016-12-10');
insert into Membership (ClubID, StudentID, DateJoined) values (3, 39, '2016-09-02');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 51, '2015-03-27');
insert into Membership (ClubID, StudentID, DateJoined) values (3, 47, '2017-03-05');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 78, '2015-05-18');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 94, '2015-08-17');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 80, '2015-02-03');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 10, '2015-04-12');
insert into Membership (ClubID, StudentID, DateJoined) values (3, 89, '2016-07-17');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 33, '2016-10-19');
insert into Membership (ClubID, StudentID, DateJoined) values (2, 27, '2015-02-10');
insert into Membership (ClubID, StudentID, DateJoined) values (4, 27, '2015-05-15');
insert into Membership (ClubID, StudentID, DateJoined) values (2, 7, '2015-07-23');
insert into Membership (ClubID, StudentID, DateJoined) values (4, 24, '2016-01-13');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 24, '2017-01-07');
insert into Membership (ClubID, StudentID, DateJoined) values (3, 75, '2016-07-06');
insert into Membership (ClubID, StudentID, DateJoined) values (2, 2, '2016-01-16');
insert into Membership (ClubID, StudentID, DateJoined) values (2, 32, '2015-09-25');
insert into Membership (ClubID, StudentID, DateJoined) values (1, 7, '2015-08-27');
insert into Membership (ClubID, StudentID, DateJoined) values (4, 43, '2015-04-12');
insert into Membership (ClubID, StudentID, DateJoined) values (2, 42, '2017-03-17');
insert into Membership (ClubID, StudentID, DateJoined) values (1, 74, '2015-12-26');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 11, '2015-06-28');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 53, '2016-11-17');
insert into Membership (ClubID, StudentID, DateJoined) values (4, 72, '2016-08-10');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 13, '2016-11-30');
insert into Membership (ClubID, StudentID, DateJoined) values (3, 4, '2016-09-06');
insert into Membership (ClubID, StudentID, DateJoined) values (1, 13, '2015-05-28');
insert into Membership (ClubID, StudentID, DateJoined) values (3, 53, '2016-02-08');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 5, '2017-02-26');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 46, '2016-06-25');
insert into Membership (ClubID, StudentID, DateJoined) values (2, 90, '2015-04-08');
insert into Membership (ClubID, StudentID, DateJoined) values (3, 49, '2016-01-07');
insert into Membership (ClubID, StudentID, DateJoined) values (4, 39, '2016-09-05');
insert into Membership (ClubID, StudentID, DateJoined) values (3, 64, '2017-01-18');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 95, '2015-06-14');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 36, '2015-07-07');
insert into Membership (ClubID, StudentID, DateJoined) values (3, 72, '2016-05-05');
insert into Membership (ClubID, StudentID, DateJoined) values (2, 45, '2015-06-28');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 45, '2017-03-28');
insert into Membership (ClubID, StudentID, DateJoined) values (1, 20, '2016-07-02');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 93, '2017-03-13');
insert into Membership (ClubID, StudentID, DateJoined) values (2, 46, '2015-02-16');
insert into Membership (ClubID, StudentID, DateJoined) values (2, 94, '2015-04-19');
insert into Membership (ClubID, StudentID, DateJoined) values (4, 59, '2016-11-24');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 97, '2017-01-10');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 76, '2015-09-04');
insert into Membership (ClubID, StudentID, DateJoined) values (3, 7, '2016-06-08');
insert into Membership (ClubID, StudentID, DateJoined) values (2, 40, '2015-03-08');
insert into Membership (ClubID, StudentID, DateJoined) values (5, 43, '2015-10-20');



INSERT INTO DBVersion (Name) VALUES(NOW()) ;












