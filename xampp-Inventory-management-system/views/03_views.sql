🔹 13️⃣ VIEW (For Dashboard)
CREATE VIEW inventory_summary AS
SELECT category, SUM(stock) AS total_stock, SUM(price) AS total_value
FROM inventory
GROUP BY category;

🧠 19. VIEW
CREATE VIEW inventory_summary AS
SELECT category, COUNT(*) AS total_items
FROM inventory
GROUP BY category;