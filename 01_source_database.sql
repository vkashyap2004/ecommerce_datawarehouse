-- ---------------------------------------------------STAGE 1---------------------------------------------------------- 
  
-- Create database
CREATE DATABASE ecommerce_source;
USE ecommerce_source;

-- Customers
CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  name        VARCHAR(100),
  city        VARCHAR(100)
);

-- Products
CREATE TABLE products (
  product_id   INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(100),
  category     VARCHAR(50),
  price        DECIMAL(10,2)
);

-- Orders
CREATE TABLE orders (
  order_id    INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  order_date  DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Items
CREATE TABLE order_items (
  order_id   INT,
  product_id INT,
  quantity   INT,
  FOREIGN KEY (order_id)   REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ================================================
-- CUSTOMERS (20 records)
-- ================================================
INSERT INTO customers (name, city) VALUES
  ('Alice Johnson',   'New York'),
  ('Bob Smith',       'Los Angeles'),
  ('Carol White',     'Chicago'),
  ('David Brown',     'Houston'),
  ('Emma Davis',      'Phoenix'),
  ('Frank Miller',    'Philadelphia'),
  ('Grace Wilson',    'San Antonio'),
  ('Henry Moore',     'San Diego'),
  ('Isla Taylor',     'Dallas'),
  ('Jack Anderson',   'San Jose'),
  ('Karen Thomas',    'Austin'),
  ('Liam Jackson',    'Jacksonville'),
  ('Mia Harris',      'Fort Worth'),
  ('Noah Martin',     'Columbus'),
  ('Olivia Garcia',   'Charlotte'),
  ('Paul Martinez',   'Indianapolis'),
  ('Quinn Robinson',  'Seattle'),
  ('Rachel Clark',    'Denver'),
  ('Samuel Lewis',    'Washington'),
  ('Tina Walker',     'Nashville');

-- ================================================
-- PRODUCTS (20 records)
-- ================================================
INSERT INTO products (product_name, category, price) VALUES
  ('Laptop Pro 15',        'Electronics',  1299.99),
  ('Wireless Mouse',       'Electronics',    29.99),
  ('Running Shoes',        'Apparel',         89.99),
  ('Coffee Maker',         'Kitchen',         79.99),
  ('Python Cookbook',      'Books',           39.99),
  ('Yoga Mat',             'Sports',          25.99),
  ('Bluetooth Speaker',    'Electronics',     59.99),
  ('Winter Jacket',        'Apparel',        149.99),
  ('Mechanical Keyboard',  'Electronics',     99.99),
  ('Water Bottle',         'Sports',          19.99),
  ('Air Fryer',            'Kitchen',        109.99),
  ('Desk Lamp',            'Home',            34.99),
  ('Sunglasses',           'Apparel',         49.99),
  ('JavaScript Guide',     'Books',           44.99),
  ('Gaming Headset',       'Electronics',     79.99),
  ('Resistance Bands',     'Sports',          15.99),
  ('Blender',              'Kitchen',         59.99),
  ('Backpack',             'Apparel',         69.99),
  ('Smart Watch',          'Electronics',    199.99),
  ('Cooking Pan Set',      'Kitchen',         89.99);

-- ================================================
-- ORDERS (40 records)
-- ================================================
INSERT INTO orders (customer_id, order_date) VALUES
  (1,  '2025-01-05'),
  (2,  '2025-01-10'),
  (3,  '2025-01-15'),
  (1,  '2025-02-01'),
  (4,  '2025-02-14'),
  (5,  '2025-02-20'),
  (2,  '2025-03-03'),
  (3,  '2025-03-18'),
  (1,  '2025-03-25'),
  (6,  '2025-01-08'),
  (7,  '2025-01-20'),
  (8,  '2025-02-05'),
  (9,  '2025-02-18'),
  (10, '2025-02-25'),
  (11, '2025-03-01'),
  (12, '2025-03-10'),
  (13, '2025-03-15'),
  (14, '2025-03-20'),
  (15, '2025-04-01'),
  (16, '2025-04-05'),
  (17, '2025-04-10'),
  (18, '2025-04-14'),
  (19, '2025-04-18'),
  (20, '2025-04-22'),
  (1,  '2025-04-25'),
  (2,  '2025-05-01'),
  (3,  '2025-05-05'),
  (4,  '2025-05-10'),
  (5,  '2025-05-15'),
  (6,  '2025-05-20'),
  (7,  '2025-06-01'),
  (8,  '2025-06-05'),
  (9,  '2025-06-10'),
  (10, '2025-06-15'),
  (11, '2025-06-20'),
  (12, '2025-07-01'),
  (13, '2025-07-05'),
  (14, '2025-07-10'),
  (15, '2025-07-15'),
  (16, '2025-07-20');

-- ================================================
-- ORDER ITEMS (60 records)
-- ================================================
INSERT INTO order_items (order_id, product_id, quantity) VALUES
  (1,  1,  1),
  (1,  2,  2),
  (2,  3,  1),
  (2,  7,  1),
  (3,  4,  2),
  (4,  5,  3),
  (4,  6,  1),
  (5,  1,  1),
  (5,  8,  1),
  (6,  2,  4),
  (7,  3,  2),
  (7,  4,  1),
  (8,  7,  3),
  (9,  5,  2),
  (9,  6,  2),
  (10, 9,  1),
  (10, 10, 3),
  (11, 11, 1),
  (11, 12, 2),
  (12, 13, 1),
  (12, 14, 2),
  (13, 15, 1),
  (13, 16, 4),
  (14, 17, 1),
  (14, 18, 1),
  (15, 19, 1),
  (15, 20, 2),
  (16, 1,  1),
  (16, 9,  1),
  (17, 2,  3),
  (17, 10, 2),
  (18, 3,  1),
  (18, 13, 2),
  (19, 4,  1),
  (19, 11, 1),
  (20, 5,  2),
  (20, 14, 1),
  (21, 6,  3),
  (21, 16, 2),
  (22, 7,  1),
  (22, 15, 1),
  (23, 8,  1),
  (23, 18, 2),
  (24, 9,  1),
  (24, 19, 1),
  (25, 10, 4),
  (25, 20, 1),
  (26, 11, 2),
  (26, 12, 1),
  (27, 13, 3),
  (27, 17, 1),
  (28, 14, 2),
  (28, 6,  2),
  (29, 15, 1),
  (29, 3,  2),
  (30, 16, 3),
  (30, 7,  1),
  (31, 17, 1),
  (31, 1,  1),
  (32, 18, 2);

USE ecommerce_source;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;


SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
