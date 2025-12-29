🔹 14️⃣ STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE GetLowStock()
BEGIN
    SELECT * FROM inventory WHERE stock < 20;
END //

DELIMITER ;
Call it:
CALL GetLowStock();


⚙️ 16. STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE GetExpensiveProducts()
BEGIN
    SELECT * FROM inventory WHERE price > 50000;
END //

DELIMITER ;
Call it:
CALL GetExpensiveProducts();

