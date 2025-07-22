# SQL-ECOMMERCE-PROJECT


This project analyzes SQL e-commerce sales data.

Project Description
This project focuses on analyzing e-commerce sales data using SQL. It involves setting up a database schema, populating it with sample data, and executing various queries to derive insights into sales performance, customer behavior, and product trends. The primary goal is to demonstrate SQL capabilities for data extraction, transformation, and reporting in an e-commerce context.

Database Schema
The database sqlecommercesales consists of five tables:

customers: Stores customer information.

customer_id (INT, PRIMARY KEY)

name (VARCHAR(100))

email (VARCHAR(100))

join_date (DATE)

products: Contains details about the products sold.

product_id (INT, PRIMARY KEY)

name (VARCHAR(100))

category (VARCHAR(50))

cost_price (DECIMAL(10,2))

selling_price (DECIMAL(10,2))

orders: Records order information.

order_id (INT, PRIMARY KEY)

customer_id (INT, FOREIGN KEY to customers)

order_date (DATE)

order_status (VARCHAR(20))

order_items: Links products to orders, detailing quantities and discounts.

order_item_id (INT, PRIMARY KEY)

order_id (INT, FOREIGN KEY to orders)

product_id (INT, FOREIGN KEY to products)

quantity (INT)

discount (DECIMAL(5,2))

returns: Tracks returned orders.

return_id (INT, PRIMARY KEY)

order_id (INT, FOREIGN KEY to orders)

return_date (DATE)

Key Queries and Analysis
The project includes SQL queries to answer critical business questions, such as:

## Total Revenue, Quantity & Orders: Calculates the total number of completed orders, the total quantity of products sold, and the total revenue generated from completed orders.

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM((p.selling_price - oi.discount) * oi.quantity) AS total_revenue
FROM
    orders o
JOIN
    order_items oi ON o.order_id = oi.order_id
JOIN
    products p ON oi.product_id = p.product_id
WHERE
    o.order_status = 'Completed';

## Monthly Revenue Trend: Shows the revenue trend over time, grouped by month, for completed orders.

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    SUM((p.selling_price - oi.discount) * oi.quantity) AS monthly_revenue
FROM
    orders o
JOIN
    order_items oi ON o.order_id = oi.order_id
JOIN
    products p ON oi.product_id = p.product_id
WHERE
    o.order_status = 'Completed'
GROUP BY
    order_month
ORDER BY
    order_month;

## Best-Selling Products by Revenue: Identifies the top 10 products based on the revenue generated from completed sales.

SELECT
    p.name AS product_name,
    SUM((p.selling_price - oi.discount) * oi.quantity) AS total_revenue
FROM
    order_items oi
JOIN
    products p ON oi.product_id = p.product_id
JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    o.order_status = 'Completed'
GROUP BY
    p.name
ORDER BY
    total_revenue DESC
LIMIT 10;


This project analyzes SQL e-commerce sales data. Below is a README description and project description suitable for a GitHub repository.

SQL E-commerce Sales Analysis
Project Description
This project focuses on analyzing e-commerce sales data using SQL. It involves setting up a database schema, populating it with sample data, and executing various queries to derive insights into sales performance, customer behavior, and product trends. The primary goal is to demonstrate SQL capabilities for data extraction, transformation, and reporting in an e-commerce context.

Database Schema
The database sqlecommercesales consists of five tables:

customers: Stores customer information.

customer_id (INT, PRIMARY KEY)

name (VARCHAR(100))

email (VARCHAR(100))

join_date (DATE)

products: Contains details about the products sold.

product_id (INT, PRIMARY KEY)

name (VARCHAR(100))

category (VARCHAR(50))

cost_price (DECIMAL(10,2))

selling_price (DECIMAL(10,2))

orders: Records order information.

order_id (INT, PRIMARY KEY)

customer_id (INT, FOREIGN KEY to customers)

order_date (DATE)

order_status (VARCHAR(20))

order_items: Links products to orders, detailing quantities and discounts.

order_item_id (INT, PRIMARY KEY)

order_id (INT, FOREIGN KEY to orders)

product_id (INT, FOREIGN KEY to products)

quantity (INT)

discount (DECIMAL(5,2))

returns: Tracks returned orders.

return_id (INT, PRIMARY KEY)

order_id (INT, FOREIGN KEY to orders)

return_date (DATE)

Key Queries and Analysis
The project includes SQL queries to answer critical business questions, such as:

Total Revenue, Quantity & Orders: Calculates the total number of completed orders, the total quantity of products sold, and the total revenue generated from completed orders.

SQL

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM((p.selling_price - oi.discount) * oi.quantity) AS total_revenue
FROM
    orders o
JOIN
    order_items oi ON o.order_id = oi.order_id
JOIN
    products p ON oi.product_id = p.product_id
WHERE
    o.order_status = 'Completed';
Monthly Revenue Trend: Shows the revenue trend over time, grouped by month, for completed orders.

SQL

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    SUM((p.selling_price - oi.discount) * oi.quantity) AS monthly_revenue
FROM
    orders o
JOIN
    order_items oi ON o.order_id = oi.order_id
JOIN
    products p ON oi.product_id = p.product_id
WHERE
    o.order_status = 'Completed'
GROUP BY
    order_month
ORDER BY
    order_month;
Best-Selling Products by Revenue: Identifies the top 10 products based on the revenue generated from completed sales.

SQL

SELECT
    p.name AS product_name,
    SUM((p.selling_price - oi.discount) * oi.quantity) AS total_revenue
FROM
    order_items oi
JOIN
    products p ON oi.product_id = p.product_id
JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    o.order_status = 'Completed'
GROUP BY
    p.name
ORDER BY
    total_revenue DESC
LIMIT 10;

## How to Use
Create the Database: Execute the create database sqlecommercesales; statement.

Create Tables: Run the CREATE TABLE statements for customers, products, orders, order_items, and returns to set up the schema.

Insert Data: Execute the INSERT INTO statements for all tables to populate them with sample data.

Run Queries: Execute the provided SELECT queries to perform analysis on the sales data.

Technologies Used
SQL (demonstrated with MySQL syntax for DATE_FORMAT)

Thank you
