CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `churn_summary` AS select `c`.`customerID` AS `customerID`,`cs`.`Churn` AS `Churn`,`s`.`contract` AS `Contract` from ((`customers` `c` left join `churn_status` `cs` on((`c`.`customerID` = `cs`.`customerID`))) left join `subscriptions` `s` on((`c`.`customerID` = `s`.`customerID`)));

CREATE OR REPLACE VIEW churn_summary AS
SELECT
    c.customerId,
    cs.Churn,
    s.Contract,
    b.MonthlyCharges
FROM customers c
LEFT JOIN churn_status cs ON c.customerId = cs.customerID
LEFT JOIN subscriptions s ON c.customerID = s.customerID
LEFT JOIN billing b ON c.customerId = b.customerID;


CREATE OR REPLACE VIEW churn_summary AS
SELECT
    c.customerID,
    cs.Churn,
    s.Contract
FROM customers c
LEFT JOIN churn_status cs ON c.customerID = cs.customerID
LEFT JOIN subscriptions s ON c.customerId = s.customerID;

CREATE OR REPLACE VIEW churn_summary AS
SELECT
    c.customerID,
    cs.Churn,
    s.Contract
FROM customers c
LEFT JOIN churn_status cs ON c.customerId = cs.customerID
LEFT JOIN subscriptions s ON c.customerId = s.customerID;



SELECT * FROM churn_summary LIMIT 5;
SELECT * FROM churn_summary;
