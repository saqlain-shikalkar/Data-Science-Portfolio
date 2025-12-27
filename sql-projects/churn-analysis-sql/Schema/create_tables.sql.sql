-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema churn_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema churn_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `churn_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `churn_db` ;

-- -----------------------------------------------------
-- Table `churn_db`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `churn_db`.`customers` (
  `customerID` VARCHAR(20) NOT NULL,
  `gender` VARCHAR(10) NULL DEFAULT NULL,
  `SeniorCitizen` TINYINT NULL DEFAULT NULL,
  `Partner` VARCHAR(5) NULL DEFAULT NULL,
  `Dependents` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `churn_db`.`billing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `churn_db`.`billing` (
  `billing_id` INT NOT NULL AUTO_INCREMENT,
  `customerID` VARCHAR(20) NULL DEFAULT NULL,
  `Contract` VARCHAR(20) NULL DEFAULT NULL,
  `PaperlessBilling` VARCHAR(5) NULL DEFAULT NULL,
  `PaymentMethod` VARCHAR(50) NULL DEFAULT NULL,
  `MonthlyCharges` DECIMAL(10,2) NULL DEFAULT NULL,
  `TotalCharges` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`billing_id`),
  CONSTRAINT `fk_billing_customer`
    FOREIGN KEY (`customerID`)
    REFERENCES `churn_db`.`customers` (`customerID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7033
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `churn_db`.`churn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `churn_db`.`churn` (
  `customerID` VARCHAR(20) NULL DEFAULT NULL,
  `gender` TEXT NULL DEFAULT NULL,
  `SeniorCitizen` INT NULL DEFAULT NULL,
  `Partner` TEXT NULL DEFAULT NULL,
  `Dependents` TEXT NULL DEFAULT NULL,
  `tenure` INT NULL DEFAULT NULL,
  `PhoneService` TEXT NULL DEFAULT NULL,
  `MultipleLines` TEXT NULL DEFAULT NULL,
  `InternetService` TEXT NULL DEFAULT NULL,
  `OnlineSecurity` TEXT NULL DEFAULT NULL,
  `OnlineBackup` TEXT NULL DEFAULT NULL,
  `DeviceProtection` TEXT NULL DEFAULT NULL,
  `TechSupport` TEXT NULL DEFAULT NULL,
  `StreamingTV` TEXT NULL DEFAULT NULL,
  `StreamingMovies` TEXT NULL DEFAULT NULL,
  `Contract` TEXT NULL DEFAULT NULL,
  `PaperlessBilling` TEXT NULL DEFAULT NULL,
  `PaymentMethod` TEXT NULL DEFAULT NULL,
  `MonthlyCharges` TEXT NULL DEFAULT NULL,
  `TotalCharges` TEXT NULL DEFAULT NULL,
  `Churn` TEXT NULL DEFAULT NULL,
  INDEX `churn_ibfk_1` (`customerID` ASC) VISIBLE,
  CONSTRAINT `churn_ibfk_1`
    FOREIGN KEY (`customerID`)
    REFERENCES `churn_db`.`customers` (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `churn_db`.`churn_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `churn_db`.`churn_status` (
  `customerID` VARCHAR(20) NULL DEFAULT NULL,
  `tenure` INT NULL DEFAULT NULL,
  `Churn` VARCHAR(5) NULL DEFAULT NULL,
  CONSTRAINT `churn_status_ibfk_1`
    FOREIGN KEY (`customerID`)
    REFERENCES `churn_db`.`customers` (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `churn_db`.`customerchurn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `churn_db`.`customerchurn` (
  `customerID` VARCHAR(20) NULL DEFAULT NULL,
  `gender` TEXT NULL DEFAULT NULL,
  `SeniorCitizen` INT NULL DEFAULT NULL,
  `Partner` TEXT NULL DEFAULT NULL,
  `Dependents` TEXT NULL DEFAULT NULL,
  `tenure` INT NULL DEFAULT NULL,
  `PhoneService` TEXT NULL DEFAULT NULL,
  `MultipleLines` TEXT NULL DEFAULT NULL,
  `InternetService` TEXT NULL DEFAULT NULL,
  `OnlineSecurity` TEXT NULL DEFAULT NULL,
  `OnlineBackup` TEXT NULL DEFAULT NULL,
  `DeviceProtection` TEXT NULL DEFAULT NULL,
  `TechSupport` TEXT NULL DEFAULT NULL,
  `StreamingTV` TEXT NULL DEFAULT NULL,
  `StreamingMovies` TEXT NULL DEFAULT NULL,
  `Contract` TEXT NULL DEFAULT NULL,
  `PaperlessBilling` TEXT NULL DEFAULT NULL,
  `PaymentMethod` TEXT NULL DEFAULT NULL,
  `MonthlyCharges` DOUBLE NULL DEFAULT NULL,
  `TotalCharges` DOUBLE NULL DEFAULT NULL,
  `Churn` TEXT NULL DEFAULT NULL,
  `tenure_group` VARCHAR(20) NULL DEFAULT NULL,
  INDEX `fk_customerchurn_customer` (`customerID` ASC) VISIBLE,
  CONSTRAINT `fk_customerchurn_customer`
    FOREIGN KEY (`customerID`)
    REFERENCES `churn_db`.`customers` (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `churn_db`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `churn_db`.`services` (
  `customerID` VARCHAR(20) NULL DEFAULT NULL,
  `internet_type` VARCHAR(20) NULL DEFAULT NULL,
  `has_security` TINYINT NULL DEFAULT NULL,
  `has_streaming` TINYINT NULL DEFAULT NULL,
  `service_score` INT NULL DEFAULT NULL,
  INDEX `fk_services_customer` (`customerID` ASC) VISIBLE,
  CONSTRAINT `fk_services_customer`
    FOREIGN KEY (`customerID`)
    REFERENCES `churn_db`.`customers` (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `churn_db`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `churn_db`.`subscriptions` (
  `customerID` VARCHAR(20) NULL DEFAULT NULL,
  `tenure` INT NULL DEFAULT NULL,
  `contract` TEXT NULL DEFAULT NULL,
  INDEX `fk_subscriptions_customer` (`customerID` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_customer`
    FOREIGN KEY (`customerID`)
    REFERENCES `churn_db`.`customers` (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `churn_db` ;

-- -----------------------------------------------------
-- Placeholder table for view `churn_db`.`churn_analytics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `churn_db`.`churn_analytics` (`Contract` INT, `total_customers` INT, `churned_customers` INT, `churn_percentage` INT);

-- -----------------------------------------------------
-- Placeholder table for view `churn_db`.`churn_dataset`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `churn_db`.`churn_dataset` (`customerID` INT, `gender` INT, `SeniorCitizen` INT, `tenure` INT, `Contract` INT, `Churn` INT);

-- -----------------------------------------------------
-- Placeholder table for view `churn_db`.`churn_summary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `churn_db`.`churn_summary` (`customerID` INT, `Churn` INT, `Contract` INT);

-- -----------------------------------------------------
-- View `churn_db`.`churn_analytics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `churn_db`.`churn_analytics`;
USE `churn_db`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `churn_db`.`churn_analytics` AS select `s`.`contract` AS `Contract`,count(0) AS `total_customers`,sum((case when (`cs`.`Churn` = 'Yes') then 1 else 0 end)) AS `churned_customers`,round(((100.0 * sum((case when (`cs`.`Churn` = 'Yes') then 1 else 0 end))) / count(0)),2) AS `churn_percentage` from ((`churn_db`.`customers` `c` left join `churn_db`.`subscriptions` `s` on((`c`.`customerID` = `s`.`customerID`))) left join `churn_db`.`churn_status` `cs` on((`c`.`customerID` = `cs`.`customerID`))) group by `s`.`contract`;

-- -----------------------------------------------------
-- View `churn_db`.`churn_dataset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `churn_db`.`churn_dataset`;
USE `churn_db`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `churn_db`.`churn_dataset` AS select `c`.`customerID` AS `customerID`,`c`.`gender` AS `gender`,`c`.`SeniorCitizen` AS `SeniorCitizen`,`s`.`tenure` AS `tenure`,`s`.`contract` AS `Contract`,`cs`.`Churn` AS `Churn` from ((`churn_db`.`customers` `c` left join `churn_db`.`subscriptions` `s` on((`c`.`customerID` = `s`.`customerID`))) left join `churn_db`.`churn_status` `cs` on((`c`.`customerID` = `cs`.`customerID`)));

-- -----------------------------------------------------
-- View `churn_db`.`churn_summary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `churn_db`.`churn_summary`;
USE `churn_db`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `churn_db`.`churn_summary` AS select `c`.`customerID` AS `customerID`,`cs`.`Churn` AS `Churn`,`s`.`contract` AS `Contract` from ((`churn_db`.`customers` `c` left join `churn_db`.`churn_status` `cs` on((`c`.`customerID` = `cs`.`customerID`))) left join `churn_db`.`subscriptions` `s` on((`c`.`customerID` = `s`.`customerID`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
