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


CREATE TABLE customer (
    customerID VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen TINYINT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5)
);


INSERT INTO customers (customerID, gender, SeniorCitizen, Partner, Dependents)
SELECT
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents
FROM customerchurn;

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) AS total_customers FROM customer;


SELECT *
FROM customers c
JOIN subscriptions s 
ON c.customerID = s.customerId
LIMIT 10;

SELECT 
    c.customerId,
    ch.churn
FROM customers c
JOIN churn ch 
ON c.customerId = ch.customerId;


SELECT 
    TABLE_NAME,
    ENGINE
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'churn_db';

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



CREATE TABLE billing (
    billing_id INT AUTO_INCREMENT PRIMARY KEY,
    customerID VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    FOREIGN KEY (customerID) REFERENCES customer(customerID)
);


INSERT INTO billing (
    customerID,
    MonthlyCharges,
    TotalCharges,
    PaymentMethod
)
SELECT
    customerID,
    MonthlyCharges,
    TotalCharges,
    PaymentMethod
FROM customerchurn;


SELECT 
    b.Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN c.Churn='Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN c.Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM billing b
JOIN churn_status c ON b.customerID = c.customerID
GROUP BY b.Contract;


SELECT 
    c.customerID,
    b.MonthlyCharges,
    c.Churn
FROM billing b
JOIN churn_status c ON b.customerID = c.customerID
WHERE b.MonthlyCharges > 80 AND c.Churn = 'Yes';


SELECT 
    Contract,
    AVG(MonthlyCharges) AS avg_charge
FROM billing
GROUP BY Contract;



SELECT 
    c.customerId,
    b.MonthlyCharges,
    b.TotalCharges
FROM customers c
JOIN billing b
ON c.customerId = b.customerId;


SELECT 
    c.customerId,
    b.MonthlyCharges,
    ch.churn,
    s.InternetService
FROM customers c
JOIN billing b ON c.customerID = b.customerID
JOIN churn ch ON c.customerID = ch.customerID
JOIN services s ON c.customerID = s.customerId;


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


SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'churn_db'
AND TABLE_NAME = 'churn';

SELECT DATABASE();

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


CREATE TABLE churn_status (
    customerID VARCHAR(20),
    tenure INT,
    Churn VARCHAR(5),
    FOREIGN KEY (customerID) REFERENCES customer(customerID)
);



INSERT INTO churn_status (
    customerID,
    Churn
)
SELECT
    customerID,
    Churn
FROM customerchurn;


SELECT 
    ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM churn_status;


SELECT 
    CASE
        WHEN tenure <= 12 THEN '0-1 year'
        WHEN tenure <= 24 THEN '1-2 years'
        WHEN tenure <= 48 THEN '2-4 years'
        ELSE '4+ years'
    END AS tenure_group,
    COUNT(*) AS customer,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM churn_status
GROUP BY tenure_group;




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


SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customerchurn';


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



CREATE TABLE services (
    customerID VARCHAR(20),
    internet_type VARCHAR(20),
    has_security TINYINT,
    has_streaming TINYINT,
    service_score INT
);



INSERT INTO services (
    customerID,
    internet_type,
    has_security,
    has_streaming,
    service_score
)
SELECT
    customerID,
    InternetService,
    CASE 
        WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 
    END AS has_security,
    CASE 
        WHEN StreamingTV = 'Yes' OR StreamingMovies = 'Yes' THEN 1 ELSE 0 
    END AS has_streaming,
    (
        (CASE WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END) +
        (CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END) +
        (CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END) +
        (CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END) +
        (CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END) +
        (CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END)
    ) AS service_score
FROM customerchurn;



SELECT 
    s.customerID,
    s.InternetService,
    c.Churn
FROM services s
JOIN churn_status c ON s.customerID = c.customerID
WHERE s.InternetService = 'Fiber optic'
AND c.Churn = 'Yes';


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


CREATE TABLE subscriptions (
    subscription_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(20),
    tenure INT,
    contract_type VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customerchurn(customer_id)
);


INSERT INTO subscriptions (
    customerID,
    tenure,
    contract
)
SELECT
    customerID,
    tenure,
    Contract
FROM customerchurn;



SELECT *
FROM customers c
JOIN subscriptions s ON c.customerID = s.customerID;
USE `churn_db` ;




SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    REFERENCED_TABLE_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'churn_db'
AND TABLE_NAME = 'subscriptions';

-- -----------------------------------------------------


SHOW TABLE STATUS WHERE Name IN (
'customer','services','subscriptions','billing','churn_status'
);

-- -----------------------------------------------------
ALTER



ALTER TABLE customer ENGINE=InnoDB;
ALTER TABLE services ENGINE=InnoDB;
ALTER TABLE subscriptions ENGINE=InnoDB;
ALTER TABLE billing ENGINE=InnoDB;
ALTER TABLE churn_status ENGINE=InnoDB;


ALTER TABLE services
MODIFY customerID VARCHAR(20),
ADD CONSTRAINT fk_services_customer
FOREIGN KEY (customerId) REFERENCES customers(customerId);

ALTER TABLE subscriptions
MODIFY customerID VARCHAR(20),
ADD CONSTRAINT fk_subscriptions_customer
FOREIGN KEY (customerId) REFERENCES customers(customerId);

ALTER TABLE billing
MODIFY customerID VARCHAR(20),
ADD CONSTRAINT fk_billing_customer
FOREIGN KEY (customerId) REFERENCES customers(customerId);

ALTER TABLE churn_status
MODIFY customerID VARCHAR(20),
ADD CONSTRAINT fk_churn_customer
FOREIGN KEY (customerId) REFERENCES customers(customerId);



ALTER TABLE customers MODIFY customerID VARCHAR(20);
ALTER TABLE customerchurn MODIFY customerID VARCHAR(20);
ALTER TABLE churn MODIFY customerID VARCHAR(20);
ALTER TABLE services MODIFY customerID VARCHAR(20);
ALTER TABLE billing MODIFY customerID VARCHAR(20);
ALTER TABLE subscriptions MODIFY customerID VARCHAR(20);
ALTER TABLE churn_status MODIFY customerID VARCHAR(20);


SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'churn_db'
AND TABLE_NAME IN ('churn', 'services');



SELECT DATABASE();
DESCRIBE churn;
SHOW KEYS FROM customers WHERE Key_name = 'PRIMARY';
ALTER TABLE churn DROP FOREIGN KEY fk_churn_customer;
ALTER TABLE churn ENGINE=InnoDB;
ALTER TABLE customers ENGINE=InnoDB;
ALTER TABLE churn MODIFY customerID VARCHAR(20);
ALTER TABLE customers MODIFY customerID VARCHAR(20);



ALTER TABLE churn
ADD CONSTRAINT fk_churn_customers
FOREIGN KEY (customerId)
REFERENCES customers(customerId)
ON DELETE CASCADE
ON UPDATE CASCADE;



SELECT * FROM subscriptions LIMIT 5;
SELECT COUNT(*) FROM customerchurn;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM services;
SELECT COUNT(*) FROM billing;
SELECT COUNT(*) FROM churn_status;
SELECT COUNT(*) FROM subscriptions;
SELECT COUNT(*) FROM churn_analytics;
SELECT COUNT(*) FROM churn_summary;



SHOW TABLES;

DESCRIBE customers;
DESCRIBE billing;
DESCRIBE services;
DESCRIBE churn;
DESCRIBE churn_status;
DESCRIBE customerchurn;
DESCRIBE subscriptions;

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
