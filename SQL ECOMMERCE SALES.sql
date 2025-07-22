create database sqlecommercesales;

-- Create 'customers' table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE
);

-- Create 'products' table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2)
);

-- Create 'orders' table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create 'order_items' table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    discount DECIMAL(5,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create 'returns' table
CREATE TABLE returns (
    return_id INT PRIMARY KEY,
    order_id INT,
    return_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Insert data into 'customers'
INSERT INTO customers (customer_id, name, email, join_date) VALUES
(1, 'Alice Johnson', 'alice@example.com', '2023-01-15'),
(2, 'Bob Smith', 'bob@example.com', '2023-02-20'),
(3, 'Charlie Lee', 'charlie@example.com', '2023-03-05');

-- Insert data into 'products'
INSERT INTO products (product_id, name, category, cost_price, selling_price) VALUES
(1, 'Wireless Mouse', 'Electronics', 10.00, 15.00),
(2, 'Bluetooth Speaker', 'Electronics', 20.00, 30.00),
(3, 'Running Shoes', 'Footwear', 25.00, 40.00);

-- Insert data into 'orders'
INSERT INTO orders (order_id, customer_id, order_date, order_status) VALUES
(101, 1, '2023-04-01', 'Completed'),
(102, 2, '2023-04-03', 'Completed'),
(103, 3, '2023-04-05', 'Returned');

-- Insert data into 'order_items'
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, discount) VALUES
(1001, 101, 1, 2, 0.00),
(1002, 101, 2, 1, 5.00),
(1003, 102, 3, 1, 0.00),
(1004, 103, 2, 1, 0.00);

-- Insert data into 'returns'
INSERT INTO returns (return_id, order_id, return_date) VALUES
(1, 103, '2023-04-10');

-- Query 1: Total Revenue, Quantity & Orders
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
    
-- Query 2: Monthly Revenue Trend
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

-- Query 3: Best-Selling Products by Revenue
DESCRIBE products;
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

