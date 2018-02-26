-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BrendasMEK
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BrendasMEK` ;

-- -----------------------------------------------------
-- Schema BrendasMEK
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BrendasMEK` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `BrendasMEK` ;

-- -----------------------------------------------------
-- Table `Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Customer` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Customer` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Employee` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Employee` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Street` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `ZipCode` VARCHAR(45) NOT NULL,
  `County` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  `BirthDate` DATE NOT NULL,
  `SSN` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sale` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Sale` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Sale_Customer_idx` (`CustomerID` ASC),
  INDEX `fk_Sale_Employees1_idx` (`EmployeeID` ASC),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  CONSTRAINT `fk_Sale_Customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `Customer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_Employees1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `Employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Vendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Vendor` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Vendor` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `VendorType` VARCHAR(45) NOT NULL,
  `Street` VARCHAR(45) NOT NULL,
  `ZipCode` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Orders` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Orders` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `EmployeeID` INT NOT NULL,
  `VendorID` INT NOT NULL,
  `OrderDate` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_Order_Employee1_idx` (`EmployeeID` ASC),
  INDEX `fk_Order_Vendor1_idx` (`VendorID` ASC),
  CONSTRAINT `fk_Order_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `Employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Vendor1`
    FOREIGN KEY (`VendorID`)
    REFERENCES `Vendor` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Shop`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shop` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Shop` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Address` VARCHAR(45) NOT NULL,
  `County` VARCHAR(45) NOT NULL,
  `ZipCode` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Recipe` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Recipe` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Product` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Product` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `RecipeID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_Product_Recipe1_idx` (`RecipeID` ASC),
  CONSTRAINT `fk_Product_Recipe1`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `Recipe` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `SaleLineItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SaleLineItem` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `SaleLineItem` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `SaleID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `UnitOfMeasure` VARCHAR(45) NOT NULL,
  `Price` DECIMAL NOT NULL,
  INDEX `fk_SaleLineItem_Sale1_idx` (`SaleID` ASC),
  INDEX `fk_SaleLineItem_Products1_idx` (`ProductID` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  CONSTRAINT `fk_SaleLineItem_Sale1`
    FOREIGN KEY (`SaleID`)
    REFERENCES `Sale` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SaleLineItem_Products1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Product` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ingredient` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Ingredient` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Quantity` INT NOT NULL,
  `UnitOfMeasure` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `OrderLineItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OrderLineItem` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `OrderLineItem` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `IngredientID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  INDEX `fk_OrderLineItem_Orders1_idx` (`OrderID` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_OrderLineItem_Ingredient1_idx` (`IngredientID` ASC),
  CONSTRAINT `fk_OrderLineItem_Orders1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `Orders` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderLineItem_Ingredient1`
    FOREIGN KEY (`IngredientID`)
    REFERENCES `Ingredient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `IngredientRecipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IngredientRecipe` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `IngredientRecipe` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `RecipeID` INT NOT NULL,
  `IngredientID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `UnitOfMeasure` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_IngredientRecipe_Recipes1_idx` (`RecipeID` ASC),
  INDEX `fk_IngredientRecipe_Ingredients1_idx` (`IngredientID` ASC),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  CONSTRAINT `fk_IngredientRecipe_Recipes1`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `Recipe` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IngredientRecipe_Ingredients1`
    FOREIGN KEY (`IngredientID`)
    REFERENCES `Ingredient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `EmployeeShop`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EmployeeShop` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `EmployeeShop` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ShopID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  PRIMARY KEY (`ID`, `ShopID`, `EmployeeID`),
  INDEX `fk_Employee_has_Shop_Shop1_idx` (`ShopID` ASC),
  INDEX `fk_Employee_has_Shop_Employee1_idx` (`EmployeeID` ASC),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  CONSTRAINT `fk_Employee_has_Shop_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `Employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_has_Shop_Shop1`
    FOREIGN KEY (`ShopID`)
    REFERENCES `Shop` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
