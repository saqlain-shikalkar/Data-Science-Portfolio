Built a complete Inventory Management System using MySQL, 
implementing CRUD operations, joins, subqueries, 
stored procedures, triggers, and analytical queries for real-time business insights




CREATE TABLE inventory (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    stock INT,
    price DECIMAL(10,2),
    supplier VARCHAR(100)
);

SELECT * FROM inventory;

SELECT SUM(stock * price) AS total_inventory_value
FROM inventory;


INSERT INTO inventory (product_name, category, stock, price, supplier)
VALUES 
('Laptop', 'Electronics', 25, 55000, 'Dell'),
('Mouse', 'Accessories', 120, 500, 'Logitech'),
('Keyboard', 'Accessories', 80, 1200, 'HP'),
('Monitor', 'Electronics', 40, 15000, 'Samsung'),
('Printer', 'Electronics', 15, 18000, 'Canon');

SELECT * FROM inventory WHERE stock < 20;

SELECT * FROM inventory WHERE category = 'Electronics';
SELECT * FROM inventory WHERE price > 10000;
SELECT * FROM inventory WHERE price > 10000;

🔹 5️⃣ UPDATE QUERIES
🔸 Update stock
UPDATE inventory
SET stock = stock - 5
WHERE product_name = 'Laptop';

Update price
UPDATE inventory
SET price = 16000
WHERE product_name = 'Monitor';

6️⃣ DELETE QUERIES
🔸 Delete one product
DELETE FROM inventory WHERE product_name = 'Mouse';

Delete low stock items
DELETE FROM inventory WHERE stock < 5;
7️⃣ AGGREGATE FUNCTIONS (IMPORTANT)
🔸 Total products
SELECT COUNT(*) AS total_products FROM inventory;
🔸 Total stock quantity
SELECT SUM(stock) AS total_stock FROM inventory;
🔸 Average price
SELECT AVG(price) AS avg_price FROM inventory;
🔸 Max & Min price
SELECT MAX(price) AS highest_price, MIN(price) AS lowest_price FROM inventory;
________________________________________
🔹 8️⃣ GROUP BY (Very Important)
SELECT category, COUNT(*) AS total_items
FROM inventory
GROUP BY category;
SELECT category, SUM(stock) AS total_stock
FROM inventory
GROUP BY category;
________________________________________
🔹 9️⃣ ORDER BY
SELECT * FROM inventory ORDER BY price DESC;
________________________________________
🔹 10️⃣ LIMIT & OFFSET
SELECT * FROM inventory LIMIT 5;
SELECT * FROM inventory LIMIT 5 OFFSET 5;
________________________________________
🔹 11️⃣ LIKE SEARCH
SELECT * FROM inventory WHERE product_name LIKE '%Lap%';
12️⃣ JOIN EXAMPLE (Advanced)
Create supplier table:
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100),
    contact VARCHAR(20)
);
Join query:
SELECT i.product_name, i.price, s.supplier_name
FROM inventory i
JOIN suppliers s
ON i.supplier = s.supplier_name;

🔹 9️⃣ AGGREGATE FUNCTIONS
SELECT COUNT(*) FROM inventory;
SELECT SUM(salary) FROM inventory;
SELECT AVG(salary) FROM inventory;
SELECT MAX(salary), MIN(salary) FROM inventory;

SELECT * FROM inventory LIMIT 10;


INSERT INTO inventory (product_name, category, stock, price, supplier) VALUES
('Laptop Pro 14', 'Electronics', 45, 85000, 'Dell'),
('Wireless Mouse', 'Electronics', 120, 799, 'Logitech'),
('Keyboard Mechanical', 'Electronics', 80, 2999, 'Redragon'),
('Monitor 24 Inch', 'Electronics', 35, 12500, 'Samsung'),
('USB-C Cable', 'Accessories', 200, 399, 'Anker'),
('Power Bank 20000mAh', 'Accessories', 90, 1999, 'Mi'),
('Office Chair', 'Furniture', 25, 6500, 'Godrej'),
('Study Table', 'Furniture', 18, 8500, 'Ikea'),
('Notebook A4', 'Stationery', 300, 120, 'Classmate'),
('Pen Blue', 'Stationery', 500, 10, 'Reynolds'),

('Printer Laser', 'Electronics', 20, 14500, 'HP'),
('Scanner', 'Electronics', 15, 9800, 'Canon'),
('Router WiFi', 'Electronics', 40, 2200, 'TP-Link'),
('External HDD 1TB', 'Electronics', 30, 5500, 'Seagate'),
('SSD 512GB', 'Electronics', 28, 6200, 'Samsung'),
('Smartphone X', 'Electronics', 50, 32000, 'Samsung'),
('Tablet 10 inch', 'Electronics', 22, 28000, 'Lenovo'),
('Desk Lamp', 'Furniture', 40, 1200, 'Philips'),
('Whiteboard', 'Furniture', 10, 3500, 'Camlin'),
('Office Sofa', 'Furniture', 5, 22000, 'Durian'),

('Marker Pen', 'Stationery', 400, 30, 'Camlin'),
('Stapler', 'Stationery', 150, 120, 'Kangaro'),
('File Folder', 'Stationery', 250, 60, 'Solo'),
('Paper Ream', 'Stationery', 180, 350, 'JK Paper'),
('Calculator', 'Electronics', 70, 650, 'Casio'),

('Projector', 'Electronics', 10, 42000, 'Epson'),
('Conference Mic', 'Electronics', 12, 7800, 'Boya'),
('Headphones', 'Electronics', 65, 2500, 'Boat'),
('Webcam HD', 'Electronics', 55, 1800, 'Logitech'),
('Smart Watch', 'Electronics', 45, 4500, 'Noise'),

('Chair Cushion', 'Furniture', 60, 900, 'AmazonBasics'),
('Bookshelf', 'Furniture', 12, 7600, 'Ikea'),
('Drawer Cabinet', 'Furniture', 8, 10500, 'Godrej'),
('Wall Clock', 'Furniture', 35, 900, 'Ajanta'),
('Water Bottle', 'Accessories', 150, 450, 'Milton'),

('Laptop Bag', 'Accessories', 85, 1600, 'American Tourister'),
('HDMI Cable', 'Accessories', 120, 350, 'Belkin'),
('Mouse Pad', 'Accessories', 200, 150, 'Cosmic Byte'),
('USB Hub', 'Accessories', 90, 950, 'TP-Link'),
('Power Strip', 'Accessories', 110, 1200, 'GM'),

('Cleaning Spray', 'Office Supplies', 140, 220, 'Colin'),
('Tissue Box', 'Office Supplies', 200, 90, 'Origami'),
('Hand Sanitizer', 'Office Supplies', 180, 110, 'Dettol'),
('Trash Bin', 'Office Supplies', 60, 650, 'Cello'),
('Mop Set', 'Office Supplies', 45, 1250, 'Gala'),

('Label Printer', 'Electronics', 15, 9200, 'Brother'),
('Barcode Scanner', 'Electronics', 18, 6700, 'Honeywell'),
('POS Machine', 'Electronics', 10, 28500, 'Epson'),
('Cash Drawer', 'Electronics', 14, 4800, 'TVS'),

('Filing Cabinet', 'Furniture', 9, 14500, 'Godrej'),
('Desk Organizer', 'Stationery', 160, 220, 'AmazonBasics'),
('Sticky Notes', 'Stationery', 300, 90, '3M'),
('Paper Clips', 'Stationery', 500, 40, 'Kangaro'),
('Envelope Pack', 'Stationery', 280, 150, 'JK'),

('Tablet Stand', 'Accessories', 95, 780, 'Portronics'),
('Phone Holder', 'Accessories', 110, 650, 'Spigen'),
('Bluetooth Speaker', 'Electronics', 55, 3200, 'JBL'),
('UPS Backup', 'Electronics', 12, 9500, 'APC'),
('Network Switch', 'Electronics', 18, 5600, 'D-Link'),

('Server Rack', 'Electronics', 5, 45000, 'NetRack'),
('Ethernet Cable', 'Accessories', 200, 180, 'D-Link'),
('SSD 1TB', 'Electronics', 20, 9800, 'WD'),
('Graphics Card', 'Electronics', 8, 42000, 'NVIDIA'),
('CPU Processor', 'Electronics', 10, 29000, 'Intel'),

('Printer Ink', 'Electronics', 70, 1200, 'HP'),
('Toner Cartridge', 'Electronics', 45, 3800, 'Canon'),
('Monitor Stand', 'Accessories', 55, 2100, 'AmazonBasics'),
('Foot Rest', 'Furniture', 30, 1800, 'Ergo'),
('Keyboard Wireless', 'Electronics', 75, 2200, 'Logitech');


🔑 1. PRIMARY KEY (PK)
A Primary Key uniquely identifies each row.
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);


🔗 2. FOREIGN KEY (FK)
Used to connect two tables.
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
________________________________________
🔀 3. JOINS (VERY IMPORTANT)

INNER JOIN
SELECT c.name, o.order_id
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

LEFT JOIN
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

RIGHT JOIN
SELECT c.name, o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

FULL JOIN (MySQL workaround)
SELECT * FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
UNION
SELECT * FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

🧮 7. GROUP BY + HAVING
SELECT category, COUNT(*) AS total_products
FROM inventory
GROUP BY category;
SELECT category, AVG(price)
FROM inventory
GROUP BY category
HAVING AVG(price) > 2000;
________________________________________
🧾 8. ORDER BY + LIMIT
SELECT * FROM inventory ORDER BY price DESC;
SELECT * FROM inventory ORDER BY price DESC LIMIT 10;
________________________________________
✏️ 9. UPDATE
UPDATE inventory
SET price = price + 500
WHERE category = 'Electronics';
________________________________________
❌ 10. DELETE
DELETE FROM inventory WHERE stock = 0;
________________________________________
💣 11. TRUNCATE (Deletes all rows fast)
TRUNCATE TABLE inventory;
⚠ Cannot rollback.
________________________________________
🧠 12. ALTER TABLE
Add Column
ALTER TABLE inventory ADD discount INT;
Modify Column
ALTER TABLE inventory MODIFY price DECIMAL(12,2);
Drop Column
ALTER TABLE inventory DROP discount;
________________________________________
🧩 13. INDEX (Performance)
CREATE INDEX idx_category ON inventory(category);
________________________________________
🔒 14. CONSTRAINTS
ALTER TABLE inventory
ADD CONSTRAINT chk_price CHECK (price > 0);
________________________________________
🧠 15. SUBQUERIES
SELECT * FROM inventory
WHERE price > (SELECT AVG(price) FROM inventory);


🔔 17. TRIGGER
CREATE TRIGGER before_insert_inventory
BEFORE INSERT ON inventory
FOR EACH ROW
SET NEW.stock = IF(NEW.stock < 0, 0, NEW.stock);
________________________________________
🔄 18. TRANSACTIONS
START TRANSACTION;

UPDATE inventory SET stock = stock - 1 WHERE product_id = 10;

COMMIT;
-- OR
ROLLBACK;
________________________________________

🧩 DATABASE DESIGN
Supplier (1)  ─────<  Inventory (Many)
________________________________________
🔹 STEP 1: Create supplier Table
CREATE TABLE supplier (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50)
);
________________________________________
🔹 STEP 2: Create inventory Table with Foreign Key
CREATE TABLE inventory (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    stock INT,
    price DECIMAL(10,2),
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);
✅ This line creates the relationship:
FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
________________________________________
🔹 STEP 3: Insert Data into Supplier Table
INSERT INTO supplier (supplier_name, contact_email, phone, city)
VALUES
('Logitech', 'contact@logitech.com', '9876543210', 'Mumbai'),
('Dell', 'sales@dell.com', '9876500000', 'Bangalore'),
('HP', 'info@hp.com', '9123456780', 'Pune');
________________________________________
🔹 STEP 4: Insert Data into Inventory Table
INSERT INTO inventory (product_name, category, stock, price, supplier_id)
VALUES
('Wireless Mouse', 'Electronics', 100, 799, 1),
('Keyboard', 'Electronics', 80, 1299, 1),
('Laptop', 'Electronics', 40, 55000, 2),
('Printer', 'Electronics', 25, 12000, 3);
________________________________________
🔹 STEP 5: JOIN Inventory + Supplier
SELECT 
    i.product_id,
    i.product_name,
    i.category,
    i.stock,
    i.price,
    s.supplier_name,
    s.city
FROM inventory i
JOIN supplier s ON i.supplier_id = s.supplier_id;
