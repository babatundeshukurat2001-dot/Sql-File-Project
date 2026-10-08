CREATE DATABASE  eccommerce_db;

CREATE TABLE users (
id SERIAL PRIMARY KEY,
email VARCHAR(100) UNIQUE,
fullname VARCHAR(100) NOT NULL,
phone VARCHAR(15)
);

CREATE TABLE products (
id SERIAL PRIMARY KEY,
product_price double NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_brand VARCHAR(50),
product_expiring_date DATE
);

CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    price DECIMAL (50),
    quantity_sold INT(50)
    );




 






 

