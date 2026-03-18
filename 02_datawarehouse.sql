-- DATA WAREHOUSE 
-- Create warehouse database
CREATE DATABASE ecommerce_dw;
USE ecommerce_dw;

-- Dimension: customer_dim
CREATE TABLE customer_dim (
  customer_id INT PRIMARY KEY,
  name        VARCHAR(100),
  city        VARCHAR(100)
);

-- Dimension: product_dim
CREATE TABLE product_dim (
  product_id   INT PRIMARY KEY,
  product_name VARCHAR(100),
  category     VARCHAR(50)
);

-- Dimension: date_dim
CREATE TABLE date_dim (
  date_id INT PRIMARY KEY AUTO_INCREMENT,
  date    DATE,
  month   INT,
  year    INT
);

-- Fact: sales_fact
CREATE TABLE sales_fact (
  sale_id     INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  product_id  INT,
  date_id     INT,
  quantity    INT,
  revenue     DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customer_dim(customer_id),
  FOREIGN KEY (product_id)  REFERENCES product_dim(product_id),
  FOREIGN KEY (date_id)     REFERENCES date_dim(date_id)
);








