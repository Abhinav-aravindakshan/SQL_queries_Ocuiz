--Create Database
CREATE DATABASE my_app;

--Use Database 
USE DATABASE my_app

-- Create Users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL,
    stock INT
);

-- Create Transactions table
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Transaction Details table
CREATE TABLE transaction_details (
    transaction_id INT REFERENCES transactions(transaction_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    PRIMARY KEY (transaction_id, product_id)
);

INSERT INTO users (name, email) VALUES 
    ('John', 'john@gmail.com'),
    ('Jane', 'jane@gmail.com'),
    ('Alex', 'alex@gmail.com'),
    ('Emily', 'emily@gmail.com'),
    ('Mathew', 'mathew@gmail.com');

INSERT INTO products (name, category, price, stock) VALUES
    ('Laptop', 'Electronics', 1200.50, 30),
    ('Mobile', 'Electronics', 800.00, 50),
    ('Television', 'Electronics', 500.75, 25),
    ('Shoes', 'Clothing', 60.99, 100),
    ('T-shirt', 'Clothing', 20.50, 200),
    ('Mug', 'Home & Kitchen', 15.99, 150),
    ('Chair', 'Furniture', 100.00, 40),
    ('Desk', 'Furniture', 150.00, 30),
    ('Washing Machine', 'Appliances', 450.00, 20),
    ('Blender', 'Appliances', 50.00, 80);

INSERT INTO transactions (user_id, date) VALUES
    (1, '2024-01-05'),
    (2, '2024-01-09'),
    (3, '2024-01-14');

INSERT INTO transaction_details (transaction_id, product_id, quantity) VALUES
    (1, 1, 2),
    (1, 2, 1),
    (2, 3, 1),
    (2, 5, 3),
    (3, 6, 2);

