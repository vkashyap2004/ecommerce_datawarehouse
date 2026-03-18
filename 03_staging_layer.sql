-- STAGING LAYER 
CREATE DATABASE ecommerce_staging;
USE ecommerce_staging;

-- Raw copy of customers
CREATE TABLE stg_customers AS
  SELECT * FROM ecommerce_source.customers;

-- Raw copy of products
CREATE TABLE stg_products AS
  SELECT * FROM ecommerce_source.products;

-- Raw copy of orders
CREATE TABLE stg_orders AS
  SELECT * FROM ecommerce_source.orders;

-- Raw copy of order_items
CREATE TABLE stg_order_items AS
  SELECT * FROM ecommerce_source.order_items;

-- Verify
SELECT 'stg_customers'   AS table_name, COUNT(*) AS rows FROM stg_customers   UNION ALL
SELECT 'stg_products'    AS table_name, COUNT(*) AS rows FROM stg_products    UNION ALL
SELECT 'stg_orders'      AS table_name, COUNT(*) AS rows FROM stg_orders      UNION ALL
SELECT 'stg_order_items' AS table_name, COUNT(*) AS rows FROM stg_order_items;









