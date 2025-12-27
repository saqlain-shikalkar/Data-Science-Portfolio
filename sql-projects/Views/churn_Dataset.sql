CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `churn_dataset` AS select `c`.`customerID` AS `customerID`,`c`.`gender` AS `gender`,`c`.`SeniorCitizen` AS `SeniorCitizen`,`s`.`tenure` AS `tenure`,`s`.`contract` AS `Contract`,`cs`.`Churn` AS `Churn` from ((`customers` `c` left join `subscriptions` `s` on((`c`.`customerID` = `s`.`customerID`))) left join `churn_status` `cs` on((`c`.`customerID` = `cs`.`customerID`)));

CREATE OR REPLACE VIEW churn_dataset AS
SELECT
    c.customerID,
    c.gender,
    c.SeniorCitizen,
    s.tenure,
    s.Contract,
    b.MonthlyCharges,
    b.TotalCharges,
    cs.Churn
FROM customers c
LEFT JOIN subscriptions s ON c.customerId = s.customerId
LEFT JOIN billing b ON c.customerId = b.customerId
LEFT JOIN churn_status cs ON c.customerId = cs.customerId;


CREATE OR REPLACE VIEW churn_dataset AS
SELECT
    c.customerID,
    c.gender,
    c.SeniorCitizen,
    s.tenure,
    s.Contract,
    cs.Churn
FROM customers c
LEFT JOIN subscriptions s ON c.customerID = s.customerID
LEFT JOIN churn_status cs ON c.customerID = cs.customerID;


CREATE OR REPLACE VIEW churn_dataset AS
SELECT
    c.customerID,
    c.gender,
    c.SeniorCitizen,
    s.tenure,
    s.Contract,
    cs.Churn
FROM customers c
LEFT JOIN subscriptions s ON c.customerId = s.customerID
LEFT JOIN churn_status cs ON c.customerId = cs.customerId;



SELECT * FROM churn_dataset LIMIT 5;
SELECT * FROM churn_dataset;