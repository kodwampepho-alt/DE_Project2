create database DE_Project2

-- 1. Create Customers Table
CREATE TABLE customer (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    province VARCHAR(50),
    signup_date DATE
);

-- 2. Create Products Table
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10, 2) NOT NULL
);

-- 3. Create Orders Table (Depends on Customers and Products)
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,
    quantity INT NOT NULL
   );

--- Query 1 (Ever order detailed)
SELECT 
    o.order_id,
    o.order_date,
    c.customer_name,
    p.product_name,
    p.category,
    o.quantity,
    p.unit_price,
    (o.quantity * p.unit_price) AS line_revenue
FROM DE_Project2.DBO.ORDERS o
INNER JOIN DE_Project2.DBO.CUSTOMER c ON o.customer_id = c.customer_id
INNER JOIN DE_Project2.DBO.PRODUCTS p ON o.product_id = p.product_id;

--- Query 2 (Total Revenue per customer)
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.quantity * p.unit_price) AS total_revenue
FROM DE_PROJECT2.DBO.ORDERS o
INNER JOIN DE_PROJECT2.DBO.CUSTOMER c ON o.customer_id = c.customer_id
INNER JOIN DE_PROJECT2.DBO.PRODUCTS p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;

--- Query 3(Total Revenue per product category)
SELECT 
    p.category,
    SUM(o.quantity * p.unit_price) AS total_revenue
FROM DE_PROJECT2.DBO.ORDERS o
INNER JOIN DE_PROJECT2.DBO.PRODUCTS p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

--- Query 4 (Top 5 customers by total spend)
SELECT TOP 5
    c.customer_id,
    c.customer_name,
    SUM(o.quantity * p.unit_price) AS total_spend
FROM DE_PROJECT2.DBO.orders o
INNER JOIN DE_PROJECT2.DBO.CUSTOMER c ON o.customer_id = c.customer_id
INNER JOIN DE_PROJECT2.DBO.PRODUCTS p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spend DESC;