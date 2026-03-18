-- SCD1

-- BEFORE
SELECT * FROM ecommerce_dw.customer_dim;

-- Simulate changes in source
UPDATE ecommerce_source.customers SET city = 'Boston'       WHERE customer_id = 1;
UPDATE ecommerce_source.customers SET city = 'Seattle'      WHERE customer_id = 2;
UPDATE ecommerce_source.customers SET city = 'Miami'        WHERE customer_id = 3;
UPDATE ecommerce_source.customers SET city = 'Atlanta'      WHERE customer_id = 4;
UPDATE ecommerce_source.customers SET city = 'Las Vegas'    WHERE customer_id = 5;
UPDATE ecommerce_source.customers SET name = 'Frank M.'     WHERE customer_id = 6;
UPDATE ecommerce_source.customers SET city = 'Orlando'      WHERE customer_id = 7;
UPDATE ecommerce_source.customers SET city = 'Portland'     WHERE customer_id = 8;
UPDATE ecommerce_source.customers SET name = 'Isla T.'      WHERE customer_id = 9;
UPDATE ecommerce_source.customers SET city = 'Sacramento'   WHERE customer_id = 10;

-- SCD1 overwrite
UPDATE ecommerce_dw.customer_dim cdw
JOIN ecommerce_source.customers src
  ON cdw.customer_id = src.customer_id
SET
  cdw.name = src.name,
  cdw.city = src.city
WHERE
  cdw.name <> src.name
  OR cdw.city <> src.city;

-- AFTER
SELECT * FROM ecommerce_dw.customer_dim;

-- -----------------------------------------------------------------------------------
-- BEFORE
SELECT * FROM ecommerce_dw.product_dim;

-- Simulate changes in source
UPDATE ecommerce_source.products SET category = 'Wellness'       WHERE product_id = 6;
UPDATE ecommerce_source.products SET category = 'Computing'      WHERE product_id = 9;
UPDATE ecommerce_source.products SET product_name = 'H2O Bottle' WHERE product_id = 10;
UPDATE ecommerce_source.products SET category = 'Home Appliance' WHERE product_id = 11;
UPDATE ecommerce_source.products SET category = 'Lighting'       WHERE product_id = 12;
UPDATE ecommerce_source.products SET category = 'Fashion'        WHERE product_id = 13;
UPDATE ecommerce_source.products SET product_name = 'JS Guide'   WHERE product_id = 14;
UPDATE ecommerce_source.products SET category = 'Gaming'         WHERE product_id = 15;
UPDATE ecommerce_source.products SET category = 'Fitness'        WHERE product_id = 16;
UPDATE ecommerce_source.products SET category = 'Home Appliance' WHERE product_id = 17;

-- SCD1 overwrite
UPDATE ecommerce_dw.product_dim pdw
JOIN ecommerce_source.products src
  ON pdw.product_id = src.product_id
SET
  pdw.product_name = src.product_name,
  pdw.category     = src.category
WHERE
  pdw.product_name <> src.product_name
  OR pdw.category  <> src.category;

-- AFTER
SELECT * FROM ecommerce_dw.product_dim;

-- -------------------------------------------------------------------------
-- BEFORE
SELECT * FROM ecommerce_dw.date_dim;

-- Simulate changes — recalculate month and year from date
UPDATE ecommerce_dw.date_dim
SET
  month = MONTH(date),
  year  = YEAR(date)
WHERE
  month <> MONTH(date)
  OR year <> YEAR(date);

-- AFTER
SELECT * FROM ecommerce_dw.date_dim;
-- ----------------------------------------------------------------------------------

-- BEFORE
SELECT * FROM ecommerce_dw.sales_fact LIMIT 10;

-- Simulate changes — recalculate revenue based on updated product prices
UPDATE ecommerce_source.products SET price = 1399.99 WHERE product_id = 1;
UPDATE ecommerce_source.products SET price = 34.99   WHERE product_id = 2;
UPDATE ecommerce_source.products SET price = 99.99   WHERE product_id = 3;
UPDATE ecommerce_source.products SET price = 89.99   WHERE product_id = 4;
UPDATE ecommerce_source.products SET price = 44.99   WHERE product_id = 5;

-- SCD1 overwrite — recalculate revenue with new prices
UPDATE ecommerce_dw.sales_fact sf
JOIN ecommerce_source.order_items oi
  ON sf.product_id = oi.product_id
JOIN ecommerce_source.products p
  ON sf.product_id = p.product_id
SET sf.revenue = oi.quantity * p.price
WHERE sf.revenue <> oi.quantity * p.price;

-- AFTER
SELECT * FROM ecommerce_dw.sales_fact LIMIT 10;








