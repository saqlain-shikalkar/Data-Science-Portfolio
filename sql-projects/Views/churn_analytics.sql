CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `churn_analytics` AS select `s`.`contract` AS `Contract`,count(0) AS `total_customers`,sum((case when (`cs`.`Churn` = 'Yes') then 1 else 0 end)) AS `churned_customers`,round(((100.0 * sum((case when (`cs`.`Churn` = 'Yes') then 1 else 0 end))) / count(0)),2) AS `churn_percentage` from ((`customers` `c` left join `subscriptions` `s` on((`c`.`customerID` = `s`.`customerID`))) left join `churn_status` `cs` on((`c`.`customerID` = `cs`.`customerID`))) group by `s`.`contract`;

CREATE OR REPLACE VIEW churn_analytics AS
SELECT
    s.Contract,
    COUNT(c.customerID) AS total_customers,
    SUM(CASE WHEN cs.Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        (SUM(CASE WHEN cs.Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) /
        COUNT(c.customerId), 2
    ) AS churn_percentage,
    AVG(b.MonthlyCharges) AS avg_monthly_charges
FROM customers c
LEFT JOIN subscriptions s ON c.customerId = s.customerID
LEFT JOIN churn_status cs ON c.customerId = cs.customerID
LEFT JOIN billing b ON c.customerId = b.customerID
GROUP BY s.Contract;


CREATE OR REPLACE VIEW churn_analytics AS
SELECT
    s.Contract,
    COUNT(c.customerID) AS total_customers,
    SUM(CASE WHEN cs.Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        (SUM(CASE WHEN cs.Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0)
        / COUNT(c.customerId), 2
    ) AS churn_percentage
FROM customers c
LEFT JOIN subscriptions s ON c.customerId = s.customerID
LEFT JOIN churn_status cs ON c.customerID = cs.customerId
GROUP BY s.Contract;


CREATE OR REPLACE VIEW churn_analytics AS
SELECT
    s.Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN cs.Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN cs.Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_percentage
FROM customers c
LEFT JOIN subscriptions s ON c.customerId = s.customerID
LEFT JOIN churn_status cs ON c.customerId = cs.customerID
GROUP BY s.Contract;


SELECT * FROM churn_analytics LIMIT 5;
SELECT * FROM churn_analytics;