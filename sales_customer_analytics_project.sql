-- =========================================
-- SALES AND CUSTOMER ANALYTICS PROJECT
-- =========================================

-- Create Database
CREATE DATABASE sales_analytics;

-- Use Database
USE sales_analytics;

-- =========================================
-- CREATE TABLES
-- =========================================

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =========================================
-- INSERT SAMPLE DATA
-- =========================================

-- Insert Customers
INSERT INTO customers VALUES
(1, 'Rahul Sharma', 'Pune', '2024-01-10'),
(2, 'Sneha Patil', 'Mumbai', '2024-02-15'),
(3, 'Amit Verma', 'Delhi', '2024-03-01'),
(4, 'Priya Singh', 'Bangalore', '2024-03-20'),
(5, 'Karan Mehta', 'Chennai', '2024-04-05');

-- Insert Products
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Smartphone', 'Electronics', 25000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Keyboard', 'Accessories', 1500),
(105, 'Mouse', 'Accessories', 800);

-- Insert Orders
INSERT INTO orders VALUES
(1001, 1, 101, 1, '2024-04-01'),
(1002, 2, 102, 2, '2024-04-02'),
(1003, 3, 103, 3, '2024-04-03'),
(1004, 4, 104, 2, '2024-04-04'),
(1005, 5, 105, 5, '2024-04-05'),
(1006, 1, 103, 1, '2024-04-06'),
(1007, 2, 101, 1, '2024-04-07');

-- =========================================
-- ANALYTICAL SQL QUERIES
-- =========================================

-- 1. View All Customers
SELECT * FROM customers;

-- 2. View All Products
SELECT * FROM products;

-- 3. View All Orders
SELECT * FROM orders;

-- 4. Total Sales Revenue
SELECT 
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
ON o.product_id = p.product_id;

-- 5. Top Customers by Spending
SELECT 
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- 6. Best Selling Products
SELECT 
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;

-- 7. Monthly Sales Report
SELECT 
    MONTH(order_date) AS month,
    SUM(o.quantity * p.price) AS monthly_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY MONTH(order_date)
ORDER BY month;

-- 8. Customer Order Count
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

-- 9. Average Product Price by Category
SELECT 
    category,
    AVG(price) AS average_price
FROM products
GROUP BY category;

-- 10. Customers Who Spent More Than 30000
SELECT 
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY c.customer_name
HAVING total_spent > 30000;

-- =========================================
-- END OF PROJECT
-- =========================================
