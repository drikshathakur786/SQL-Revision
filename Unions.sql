-- We can also combine rows with multiple tables

USE sql_store;

SELECT order_id, order_date, 'ACTIVE' as STATUS
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT order_id, order_date, 'Archive' as STATUS
FROM orders
WHERE order_date < '2019-01-01';

-- queries against different tables and combine result into one result set
SELECT first_name
FROM customers
UNION 
SELECT name
FROM shippers; -- in first_name we will see the names of all customers and shippers


-- NOTE: no. of columns each query returns should be equal otherwise ERROR
-- Returns the name given by the first query

-- exercise: return customer_id, first_name, points, type. sort result by first_name. type column doesnot exist calc it using points
SELECT customer_id, first_name, points, 'BRONZE' as type
FROM customers
WHERE points <2000

UNION

SELECT customer_id, first_name, points, 'SILVER' as type
FROM customers
WHERE points BETWEEN 2000 AND 3000 

UNION

SELECT customer_id, first_name, points, 'GOLD' as type
FROM customers
WHERE points>3000
ORDER BY first_name;

