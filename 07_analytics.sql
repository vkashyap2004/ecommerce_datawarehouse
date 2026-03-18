-- 1. Total Revenue
SELECT SUM(revenue) AS total_revenue
FROM ecommerce_dw.sales_fact;

-- 2. Top Selling Products
SELECT
  p.product_name,
  p.category,
  SUM(sf.quantity)  AS total_units_sold,
  SUM(sf.revenue)   AS total_revenue
FROM ecommerce_dw.sales_fact sf
JOIN ecommerce_dw.product_dim p
  ON sf.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_units_sold DESC;

-- 3. Best Customers
SELECT
  c.name,
  c.city,
  SUM(sf.revenue)  AS total_spent
FROM ecommerce_dw.sales_fact sf
JOIN ecommerce_dw.customer_dim c
  ON sf.customer_id = c.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_spent DESC;

-- 4. Monthly Revenue Trend
SELECT
  d.year,
  d.month,
  SUM(sf.revenue)  AS monthly_revenue
FROM ecommerce_dw.sales_fact sf
JOIN ecommerce_dw.date_dim d
  ON sf.date_id = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- 5. Product Ranking (Window Function)
SELECT
  p.product_name,
  p.category,
  SUM(sf.quantity)                              AS total_sales,
  RANK() OVER (ORDER BY SUM(sf.quantity) DESC)  AS sales_rank
FROM ecommerce_dw.sales_fact sf
JOIN ecommerce_dw.product_dim p
  ON sf.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category;

-- 6. Category Performance
SELECT
  p.category,
  SUM(sf.quantity)          AS units_sold,
  SUM(sf.revenue)           AS total_revenue,
  ROUND(AVG(sf.revenue), 2) AS avg_order_value
FROM ecommerce_dw.sales_fact sf
JOIN ecommerce_dw.product_dim p
  ON sf.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 7. Most Popular Product per Category
SELECT
  category,
  product_name,
  total_units_sold
FROM (
  SELECT
    p.category,
    p.product_name,
    SUM(sf.quantity) AS total_units_sold,
    RANK() OVER (PARTITION BY p.category ORDER BY SUM(sf.quantity) DESC) AS rnk
  FROM ecommerce_dw.sales_fact sf
  JOIN ecommerce_dw.product_dim p
    ON sf.product_id = p.product_id
  GROUP BY p.category, p.product_id, p.product_name
) ranked
WHERE rnk = 1
ORDER BY total_units_sold DESC;












