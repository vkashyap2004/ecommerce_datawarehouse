-- TRANSFORM LAYER 


CREATE DATABASE ecommerce_transform;
USE ecommerce_transform;

-- Cleaned customers
-- Uppercase city, trim whitespace
CREATE TABLE clean_customers AS
SELECT
  customer_id,
  TRIM(name)          AS name,
  UPPER(TRIM(city))   AS city
FROM ecommerce_staging.stg_customers;

-- Cleaned products
-- Uppercase category, round price
CREATE TABLE clean_products AS
SELECT
  product_id,
  TRIM(product_name)      AS product_name,
  UPPER(TRIM(category))   AS category,
  ROUND(price, 2)         AS price
FROM ecommerce_staging.stg_products;

-- Cleaned orders
CREATE TABLE clean_orders AS
SELECT
  order_id,
  customer_id,
  order_date,
  MONTH(order_date)   AS month,
  YEAR(order_date)    AS year
FROM ecommerce_staging.stg_orders;

-- Final transformed table — joined and revenue calculated
CREATE TABLE transformed_sales AS
SELECT
  o.order_id,
  o.customer_id,
  c.name              AS customer_name,
  c.city              AS customer_city,
  oi.product_id,
  p.product_name,
  p.category,
  o.order_date,
  o.month,
  o.year,
  oi.quantity,
  p.price             AS unit_price,
  (oi.quantity * p.price) AS revenue
FROM ecommerce_transform.clean_orders o
JOIN ecommerce_staging.stg_order_items oi
  ON o.order_id = oi.order_id
JOIN ecommerce_transform.clean_products p
  ON oi.product_id = p.product_id
JOIN ecommerce_transform.clean_customers c
  ON o.customer_id = c.customer_id;

-- Verify
SELECT COUNT(*) AS transformed_rows FROM transformed_sales;
SELECT * FROM transformed_sales LIMIT 5;








