-- CORE LAYER 

USE ecommerce_dw;

-- Clear existing data
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE sales_fact;
TRUNCATE TABLE customer_dim;
TRUNCATE TABLE product_dim;
TRUNCATE TABLE date_dim;
SET FOREIGN_KEY_CHECKS = 1;

-- Load customer_dim from transform layer
INSERT INTO customer_dim (customer_id, name, city)
SELECT DISTINCT customer_id, customer_name, customer_city
FROM ecommerce_transform.transformed_sales;

-- Load product_dim from transform layer
INSERT INTO product_dim (product_id, product_name, category)
SELECT DISTINCT product_id, product_name, category
FROM ecommerce_transform.transformed_sales;

-- Load date_dim from transform layer
INSERT INTO date_dim (date, month, year)
SELECT DISTINCT order_date, month, year
FROM ecommerce_transform.transformed_sales;

-- Load sales_fact from transform layer
INSERT INTO sales_fact (customer_id, product_id, date_id, quantity, revenue)
SELECT
  ts.customer_id,
  ts.product_id,
  d.date_id,
  ts.quantity,
  ts.revenue
FROM ecommerce_transform.transformed_sales ts
JOIN ecommerce_dw.date_dim d
  ON ts.order_date = d.date;

-- Verify final load
SELECT 'customer_dim' AS layer, COUNT(*) AS rows FROM customer_dim UNION ALL
SELECT 'product_dim'  AS layer, COUNT(*) AS rows FROM product_dim  UNION ALL
SELECT 'date_dim'     AS layer, COUNT(*) AS rows FROM date_dim     UNION ALL
SELECT 'sales_fact'   AS layer, COUNT(*) AS rows FROM sales_fact;
```

---











