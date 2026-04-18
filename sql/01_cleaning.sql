--ORDERS table
CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	date DATE,
	time TIME
);

--ORDER_DETAILS table
CREATE TABLE order_details(
	order_details INT PRIMARY KEY,
	order_id INT,
	pizza_id VARCHAR(100),
	quantity INT
);

--PIZZAS table
CREATE TABLE pizzas(
	pizza_id VARCHAR(100) PRIMARY KEY,
	pizza_type_id VARCHAR(100),
	size VARCHAR(10),
	price DECIMAL(5,2)
);

--PIZZAS_TYPES table
CREATE TABLE pizza_types(
	pizza_type_id VARCHAR(50) PRIMARY KEY,
	name VARCHAR(100),
	category VARCHAR(50),
	ingredients TEXT
);

--Verifying Data
SELECT COUNT(*) FROM order_details;

--CLEAN THE DATA
SELECT *
FROM order_details
WHERE order_id IS NULL
	OR pizza_id IS NULL
	OR quantity IS NULL;
	
SELECT *
FROM orders
WHERE date IS NULL
	OR time IS NULL;
	
SELECT *
FROM pizza_types
WHERE name IS NULL
	OR category IS NULL
	OR ingredients IS NULL;

SELECT *
FROM pizzas
WHERE pizza_type_id IS NULL
	OR size IS NULL
	OR price IS NULL;
	
--CHECKING FOR DUPLICATES
SELECT 
	order_details,COUNT(*) 
FROM order_details
GROUP BY order_details
HAVING COUNT(*)>1;
	
SELECT order_id,COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*)>1;
	
	
SELECT pizza_id,COUNT(*)
FROM pizzas
GROUP BY pizza_id
HAVING COUNT(*)>1;

--CONFIRM PRICE IS NEVER ZERO
SELECT *
FROM pizzas
WHERE price<=0;

--CHECKING THE DATE RANGE
SELECT 
	MIN(date),
	MAX(date)
FROM orders;

--CHECKING THE QUANTITY NOT 0 OR NEGATIVE VALUES
SELECT * 
FROM order_details
WHERE quantity <= 0;

--CHECKING TIME FORMAT IS CORRECT/NOT
SELECT * 
FROM orders
WHERE time < '00:00:00' OR time > '23:59:59';

--CHECKING THE VALID CATEGORY AND SIZE
SELECT DISTINCT category
FROM pizza_types;

SELECT DISTINCT size
FROM pizzas;

--CHECKING ANY WHITESPACE IN NAME
SELECT name
FROM pizza_types
WHERE name != TRIM(name);


SELECT * FROM order_details LIMIT 10;
SELECT * FROM orders LIMIT 10;
SELECT * FROM pizza_types LIMIT 10;
SELECT * FROM pizzas LIMIT 10;