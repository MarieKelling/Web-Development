-- StarterCreate.sql

-- Creates all the tables in the Starter database.

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Starter
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS Starter ;

-- -----------------------------------------------------
-- Schema Starter
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS Starter DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE Starter ;
 


-- -----------------------------------------------------
-- Table Major
-- -----------------------------------------------------
DROP TABLE IF EXISTS Major ;

CREATE TABLE IF NOT EXISTS Major (
  ID INT NOT NULL AUTO_INCREMENT COMMENT '',
  Name VARCHAR(45) NOT NULL COMMENT '',
  Status BOOLEAN NOT NULL DEFAULT TRUE,
 PRIMARY KEY (ID)  COMMENT '')
ENGINE = InnoDB
 COMMENT 'The various majors offered by the Starter' ;
 
 CREATE UNIQUE INDEX Name_UNIQUE ON Major (Name ASC)  COMMENT '';

-- -----------------------------------------------------
-- Table Student
-- -----------------------------------------------------
DROP TABLE IF EXISTS Student ;

CREATE TABLE IF NOT EXISTS Student (
  ID INT NOT NULL AUTO_INCREMENT COMMENT '',
  LastName VARCHAR(45) NOT NULL COMMENT '',
  FirstName VARCHAR(45) NOT NULL COMMENT '',
  Email VARCHAR(45) NOT NULL COMMENT '',
  Sex CHAR(1) NOT NULL COMMENT '',
  DateOfBirth DATE NOT NULL COMMENT '',
  EnrolledDate DATE NOT NULL COMMENT '',
  MajorID INT  DEFAULT NULL COMMENT '',
  Scholarship DECIMAL(9,2) NOT NULL DEFAULT 0  COMMENT '',
  PRIMARY KEY (ID)  COMMENT '',
  CONSTRAINT fk_Course_Major1
    FOREIGN KEY (MajorID)
    REFERENCES Major (ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) 
ENGINE = InnoDB
 COMMENT 'Records each student in the Starter' ;

CREATE UNIQUE INDEX Student_ID_UNIQUE ON Student (ID ASC)  COMMENT '';

CREATE UNIQUE INDEX Email_UNIQUE ON Student (Email ASC)  COMMENT '';
 


-- -----------------------------------------------------
-- End of Tables
-- -----------------------------------------------------

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


 

-------------------------------------------------------------------------------------------
--
--  Load data into the table
--
-------------------------------------------------------------------------------------------


USE Starter ;

 
-------------------------------------------------------------------------------------------
--
--  Major
--
-------------------------------------------------------------------------------------------
INSERT INTO Major (Name)	VALUES ('Computer Science');
INSERT INTO Major (Name)	VALUES ('Information Systems');
INSERT INTO Major (Name)	VALUES ('Mathematics');
INSERT INTO Major (Name)	VALUES ('Biology');
INSERT INTO Major (Name)	VALUES ('Nursing');
INSERT INTO Major (Name)	VALUES ('Criminal Justice');
INSERT INTO Major (Name)	VALUES ('Anthropology');
INSERT INTO Major (Name)	VALUES ('Zoology');

  
-------------------------------------------------------------------------------------------
--
--  Student
--
-------------------------------------------------------------------------------------------
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Sandra', 'Morales', 'SandraMorales@college.edu', '1996-04-17', 'F', '2014-02-09', 1, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jesse', 'Hudson', 'JesseHudson@college.edu', '1997-02-16', 'M', '2013-08-16', 6, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Robin', 'Warren', 'RobinWarren@college.edu', '1988-12-07', 'F', '2015-07-11', 5, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Adam', 'Ward', 'AdamWard@college.edu', '1996-02-10', 'M', '2013-12-13', 1, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kathryn', 'Kelly', 'KathrynKelly@college.edu', '1990-12-11', 'F', '2013-02-21', 2, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kevin', 'Alexander', 'KevinAlexander@college.edu', '1997-05-19', 'M', '2015-03-28', 2, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jerry', 'Reynolds', 'JerryReynolds@college.edu', '1986-01-10', 'M', '2014-11-22', 7, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ralph', 'Pierce', 'RalphPierce@college.edu', '1988-11-08', 'M', '2012-10-05', 1, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jack', 'Ray', 'JackRay@college.edu', '1997-10-20', 'M', '2015-11-01', 3, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Diana', 'Lopez', 'DianaLopez@college.edu', '1985-10-26', 'F', '2015-12-08', 4, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ryan', 'Griffin', 'RyanGriffin@college.edu', '1991-02-16', 'M', '2013-12-02', 6, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kathleen', 'Roberts', 'KathleenRoberts@college.edu', '1992-11-20', 'F', '2013-10-31', 2, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Antonio', 'Gardner', 'AntonioGardner@college.edu', '1990-01-09', 'M', '2014-11-17', 1, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Steve', 'Martinez', 'SteveMartinez@college.edu', '1987-10-17', 'M', '2015-08-12', 2, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Phyllis', 'Patterson', 'PhyllisPatterson@college.edu', '1992-05-14', 'F', '2016-02-03', 2, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kimberly', 'Reyes', 'KimberlyReyes@college.edu', '1997-09-25', 'F', '2015-11-03', 6, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jennifer', 'Gonzales', 'JenniferGonzales@college.edu', '1991-01-08', 'F', '2013-03-11', 6, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Patricia', 'Ford', 'PatriciaFord@college.edu', '1991-05-25', 'F', '2015-07-27', 3, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jean', 'Baker', 'JeanBaker@college.edu', '1998-03-01', 'F', '2012-05-12', 2, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Patricia', 'Meyer', 'PatriciaMeyer@college.edu', '1998-02-17', 'F', '2015-04-13', 4, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Roy', 'Dunn', 'RoyDunn@college.edu', '1996-02-02', 'M', '2014-02-27', 4, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ann', 'Anderson', 'AnnAnderson@college.edu', '1991-01-24', 'F', '2014-10-05', 1, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Juan', 'Simmons', 'JuanSimmons@college.edu', '1990-10-08', 'M', '2015-06-01', 3, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Evelyn', 'Ross', 'EvelynRoss@college.edu', '1998-03-06', 'F', '2013-08-24', 7, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Aaron', 'Vasquez', 'AaronVasquez@college.edu', '1987-04-12', 'M', '2014-10-27', 2, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Katherine', 'Hart', 'KatherineHart@college.edu', '1995-05-19', 'F', '2013-03-19', 4, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Betty', 'Black', 'BettyBlack@college.edu', '1995-06-29', 'F', '2012-06-18', 6, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Andrea', 'Oliver', 'AndreaOliver@college.edu', '1996-11-02', 'F', '2016-01-25', 4, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jennifer', 'Perez', 'JenniferPerez@college.edu', '1995-12-09', 'F', '2014-07-02', 3, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Raymond', 'Mason', 'RaymondMason@college.edu', '1988-09-28', 'M', '2012-06-21', 5, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ryan', 'Crawford', 'RyanCrawford@college.edu', '1996-04-11', 'M', '2015-02-12', 2, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ashley', 'Adams', 'AshleyAdams@college.edu', '1986-12-05', 'F', '2013-01-13', 3, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ruth', 'Daniels', 'RuthDaniels@college.edu', '1993-09-14', 'F', '2012-05-16', 1, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Larry', 'Jacobs', 'LarryJacobs@college.edu', '1991-06-05', 'M', '2014-11-28', 1, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Rose', 'Smith', 'RoseSmith@college.edu', '1985-12-20', 'F', '2015-07-16', 1, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Judith', 'Cox', 'JudithCox@college.edu', '1992-07-23', 'F', '2013-05-12', 6, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ann', 'Perry', 'AnnPerry@college.edu', '1991-02-07', 'F', '2013-10-23', 5, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Tina', 'Romero', 'TinaRomero@college.edu', '1990-02-08', 'F', '2013-02-01', 4, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kathleen', 'Jenkins', 'KathleenJenkins@college.edu', '1994-03-30', 'F', '2013-02-09', 5, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Joan', 'Mitchell', 'JoanMitchell@college.edu', '1991-04-25', 'F', '2013-04-08', 7, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Mark', 'George', 'MarkGeorge@college.edu', '1992-10-25', 'M', '2012-06-05', 2, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Carolyn', 'Williamson', 'CarolynWilliamson@college.edu', '1991-12-17', 'F', '2014-07-03', 4, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Tammy', 'Ford', 'TammyFord@college.edu', '1993-01-06', 'F', '2013-02-24', 7, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Clarence', 'Clark', 'ClarenceClark@college.edu', '1997-06-21', 'M', '2015-05-16', 3, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Joshua', 'Collins', 'JoshuaCollins@college.edu', '1991-04-24', 'M', '2016-04-06', 3, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Alan', 'Welch', 'AlanWelch@college.edu', '1987-03-29', 'M', '2013-09-29', 5, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Russell', 'Hunter', 'RussellHunter@college.edu', '1990-12-02', 'M', '2015-04-07', 2, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Antonio', 'Bryant', 'AntonioBryant@college.edu', '1994-10-29', 'M', '2012-08-29', 3, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Irene', 'Pierce', 'IrenePierce@college.edu', '1990-10-15', 'F', '2012-11-06', 5, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Stephanie', 'Young', 'StephanieYoung@college.edu', '1992-10-19', 'F', '2012-05-28', 1, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Martha', 'Shaw', 'MarthaShaw@college.edu', '1994-09-10', 'F', '2015-04-06', 7, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Philip', 'Reynolds', 'PhilipReynolds@college.edu', '1992-01-10', 'M', '2015-12-13', 7, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Benjamin', 'Taylor', 'BenjaminTaylor@college.edu', '1989-08-13', 'M', '2012-09-06', 3, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Wanda', 'Austin', 'WandaAustin@college.edu', '1986-03-11', 'F', '2015-05-13', 1, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Angela', 'Ray', 'AngelaRay@college.edu', '1988-01-01', 'F', '2015-09-14', 5, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Denise', 'Peterson', 'DenisePeterson@college.edu', '1985-09-05', 'F', '2014-04-14', 4, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Debra', 'Carter', 'DebraCarter@college.edu', '1990-09-21', 'F', '2012-11-26', 5, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Nicole', 'Stone', 'NicoleStone@college.edu', '1986-09-01', 'F', '2015-06-11', 3, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Gloria', 'Austin', 'GloriaAustin@college.edu', '1991-09-08', 'F', '2013-03-12', 3, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jack', 'Phillips', 'JackPhillips@college.edu', '1989-12-25', 'M', '2015-03-04', 6, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Judy', 'Edwards', 'JudyEdwards@college.edu', '1997-07-29', 'F', '2014-11-29', 4, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Janice', 'Brown', 'JaniceBrown@college.edu', '1998-01-30', 'F', '2014-02-24', 2, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Marilyn', 'Bryant', 'MarilynBryant@college.edu', '1989-03-28', 'F', '2015-12-20', 1, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('John', 'Sims', 'JohnSims@college.edu', '1995-05-27', 'M', '2016-04-08', 5, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kathleen', 'Hunt', 'KathleenHunt@college.edu', '1994-06-20', 'F', '2014-06-19', 2, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Tammy', 'Bell', 'TammyBell@college.edu', '1991-10-26', 'F', '2013-08-26', 3, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Gloria', 'Fernandez', 'GloriaFernandez@college.edu', '1992-11-22', 'F', '2015-07-11', 1, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Juan', 'Schmidt', 'JuanSchmidt@college.edu', '1988-09-22', 'M', '2013-09-19', 3, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jack', 'White', 'JackWhite@college.edu', '1992-03-13', 'M', '2012-08-15', 3, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Peter', 'Fernandez', 'PeterFernandez@college.edu', '1988-09-30', 'M', '2016-03-30', 4, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Gloria', 'James', 'GloriaJames@college.edu', '1986-11-24', 'F', '2015-03-11', 3, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Craig', 'Porter', 'CraigPorter@college.edu', '1989-07-01', 'M', '2016-04-01', 5, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ryan', 'Evans', 'RyanEvans@college.edu', '1997-06-29', 'M', '2013-02-23', 5, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Carol', 'Lane', 'CarolLane@college.edu', '1989-09-24', 'F', '2013-08-21', 4, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Walter', 'Wallace', 'WalterWallace@college.edu', '1993-07-18', 'M', '2014-09-05', 6, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Dorothy', 'Stone', 'DorothyStone@college.edu', '1989-06-02', 'F', '2013-04-17', 1, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Cynthia', 'Cruz', 'CynthiaCruz@college.edu', '1988-05-02', 'F', '2013-12-02', 7, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Catherine', 'Mitchell', 'CatherineMitchell@college.edu', '1989-02-27', 'F', '2016-01-21', 4, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Carol', 'Sanders', 'CarolSanders@college.edu', '1987-01-14', 'F', '2012-07-19', 2, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Stephanie', 'Long', 'StephanieLong@college.edu', '1991-10-27', 'F', '2014-07-21', 5, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Bobby', 'Jacobs', 'BobbyJacobs@college.edu', '1991-02-19', 'M', '2015-10-26', 2, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Mark', 'Hanson', 'MarkHanson@college.edu', '1993-12-14', 'M', '2014-02-25', 4, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Marilyn', 'Oliver', 'MarilynOliver@college.edu', '1995-11-25', 'F', '2013-09-16', 7, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Clarence', 'Taylor', 'ClarenceTaylor@college.edu', '1988-03-22', 'M', '2014-01-19', 5, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Melissa', 'Peters', 'MelissaPeters@college.edu', '1988-04-05', 'F', '2015-01-23', 1, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Judy', 'Ruiz', 'JudyRuiz@college.edu', '1991-07-20', 'F', '2014-02-22', 4, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Amy', 'Howell', 'AmyHowell@college.edu', '1986-10-23', 'F', '2014-07-08', 4, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Kathy', 'Taylor', 'KathyTaylor@college.edu', '1995-12-28', 'F', '2015-12-15', 1, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Ruby', 'Collins', 'RubyCollins@college.edu', '1993-08-18', 'F', '2015-12-15', 1, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Maria', 'Cruz', 'MariaCruz@college.edu', '1994-04-15', 'F', '2012-11-18', 2, 5000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Martin', 'Boyd', 'MartinBoyd@college.edu', '1995-09-18', 'M', '2014-11-08', 6, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Diana', 'Bell', 'DianaBell@college.edu', '1986-12-22', 'F', '2012-09-24', 2, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Andrew', 'Perkins', 'AndrewPerkins@college.edu', '1987-04-27', 'M', '2013-08-23', 3, 2000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Beverly', 'Ferguson', 'BeverlyFerguson@college.edu', '1987-12-01', 'F', '2012-12-27', 6, 3000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Joyce', 'Welch', 'JoyceWelch@college.edu', '1996-11-24', 'F', '2015-03-24', 2, 4000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Joshua', 'Stewart', 'JoshuaStewart@college.edu', '1993-03-28', 'M', '2013-08-09', 2, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Jonathan', 'Fisher', 'JonathanFisher@college.edu', '1986-11-24', 'M', '2014-03-07', 2, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Virginia', 'Wilson', 'VirginiaWilson@college.edu', '1990-11-28', 'F', '2015-10-01', 6, 0);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Patrick', 'Lewis', 'PatrickLewis@college.edu', '1995-10-27', 'M', '2014-11-14', 4, 1000);
insert into student (FirstName, LastName, EMail, DateOfBirth, Sex, EnrolledDate, MajorID, Scholarship) values ('Alice', 'Simpson', 'AliceSimpson@college.edu', '1989-05-11', 'F', '2013-11-06', 3, 5000);
