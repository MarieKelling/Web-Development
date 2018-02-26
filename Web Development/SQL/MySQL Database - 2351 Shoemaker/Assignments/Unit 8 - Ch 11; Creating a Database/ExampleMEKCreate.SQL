-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ExampleMEK
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ExampleMEK` ;

-- -----------------------------------------------------
-- Schema ExampleMEK
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ExampleMEK` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `ExampleMEK` ;

-- -----------------------------------------------------
-- Table `State`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `State` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `State` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Abbreviation` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Supplier` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Supplier` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Street` VARCHAR(45) NOT NULL,
  `Phone` INT NOT NULL,
  `HireDate` DATE NOT NULL,
  `State_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `State_ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_Supplier_State1_idx` (`State_ID` ASC),
  CONSTRAINT `fk_Supplier_State1`
    FOREIGN KEY (`State_ID`)
    REFERENCES `State` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Part`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Part` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Part` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Number` INT NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Supplies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Supplies` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Supplies` (
  `Supplier_ID` INT NOT NULL,
  `Part_ID` INT NOT NULL,
  `Cost` DECIMAL NOT NULL,
  PRIMARY KEY (`Supplier_ID`, `Part_ID`),
  INDEX `fk_Supplier_has_Part_Part1_idx` (`Part_ID` ASC),
  INDEX `fk_Supplier_has_Part_Supplier_idx` (`Supplier_ID` ASC),
  CONSTRAINT `fk_Supplier_has_Part_Supplier`
    FOREIGN KEY (`Supplier_ID`)
    REFERENCES `Supplier` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supplier_has_Part_Part1`
    FOREIGN KEY (`Part_ID`)
    REFERENCES `Part` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
