USE sql_store;

-- INNER JOIN
SELECT order_id, orders.customer_id, first_name, last_name
FROM orders
JOIN customers 
	ON orders.customer_id = customers.customer_id;
    
-- orders is repeating multiple times we can simplify this by using alias
SELECT order_id, o.customer_id, first_name, last_name
FROM orders o 
JOIN customers c
	ON o.customer_id = c.customer_id;
    
-- exercise
-- order_items join with products table for each order return both product id as well as name, quantity and unit_price. use alias to simplify
SELECT order_id, p.product_id, quantity_in_stock, oi.unit_price
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id;
    
    
-- JOINING ACROSS DATABASES:
-- join order_items (db: sql_store) with products (db: sql_inventory)
SELECT *
FROM order_items oi
JOIN sql_inventory.products p -- prefix only the tables that are not part of the current database
	ON oi.product_id = p.product_id;
    

-- SELF join
USE sql_hr;

SELECT 
	e.employee_id,
    e.first_name,
    m.first_name AS MANAGER
FROM employees e
JOIN employees m 
	ON e.reports_to = m.employee_id;
    
-- JOINING MULTIPLE TABLES
USE sql_store;

SELECT o.order_id , o.order_date, c.ofirst_name, c.last_name, OS.name AS status
FROM orders o
JOIN customers c 
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
-- exercise
-- join clients table with payments table
USE sql_invoicing;

SELECT p.date, p.invoice_id, p.amount, c.name, pm.name
FROM payments p
JOIN clients c 
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;
    
    
    
-- COMPOUND JOIN CONDITIONS
-- compound primary key - contains more than one column
USE sql_store;

SELECT *
FROM order_items oi
JOIN order_item_notes oin 
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;
    

-- IMPLICIT JOIN SYNTAX
SELECT *
FROM orders o,customers c
WHERE o.customer_id = c.customer_id;


-- OUTER JOINS

-- TWO TYPES: left and right join
SELECT 
	c.customer_id,
    c.first_name
FROM customers c
JOIN orders o -- in this case we will only get customers who have placed an order
	ON c.customer_id = o.customer_id;
    
-- LEFT JOIN: all records from left table are returned
SELECT 
	c.customer_id,
    c.first_name
FROM customers c
LEFT JOIN orders o  -- we get all customers whether they have placed an order or not
	ON c.customer_id = o.customer_id;

-- RIGHT JOIN: all records from right table are returned
SELECT 
	c.customer_id,
    c.first_name
FROM orders o
RIGHT JOIN customers c
	ON c.customer_id = o.customer_id;
    
-- exercise
-- RESULT: product_id, name, quantity(from order_items table). JOIN products table with order items table. Write an outer join
USE sql_store;
SELECT p.product_id, p.name, oi.quantity
FROM products p
LEFT JOIN order_items oi 
	ON p.product_id= oi.product_id;

-- OUTER JOINS BETWEEN TABLES
SELECT c.customer_id, c.first_name, o.order_id, sh.name AS shipper
FROM customers c
LEFT JOIN orders o 
	ON c.customer_id= o.customer_id
JOIN shippers sh 
	ON o.shipper_id = sh.shipper_id
ORDER by c.customer_id;

-- exercise
-- order_date, order_id, first_name, shipper, status
SELECT 
	o.order_id,
    o.order_date,
    c.first_name AS customer,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c 
	ON o.order_id = c.customer_id
LEFT JOIN shippers sh 
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os 
	ON o.status = os.order_status_id; 
    
-- SELF OUTER JOIN
use sql_hr;
SELECT 
	e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
LEFT JOIN employees m 
	ON e.reports_to = m.employee_id;
    
-- USING CLAUSE
use sql_store;
SELECT 
	o.order_id,
    c.first_name,
    sh.name
FROM orders o
JOIN customers c 
	-- ON o.customer_id = c.customer_id
    USING(customer_id)
LEFT JOIN shippers sh 
	USING(shipper_id);

-- exercise: return date, client, amount, name using sql_invoicing db
USE sql_invoicing;
SELECT p.date, c.name AS client, p.amount, pm.name AS payment_method
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm ON p.payment_method = pm.payment_method_id;

-- NATURAL JOINS: very easy to code. Can produce unexpected results. Cuz the db engine guesses the join. join them based on the common columns
USE sql_store;

SELECT * 
FROM orders o
NATURAL JOIN customers c;

-- CROSS JOINS: join every record from the first table with every record in the second table
SELECT *
FROM customers
CROSS JOIN products p;
-- every record in customers table will be combined with every record in the products table

-- implicit syntax for cross join
SELECT *
FROM customers c, products p;

-- exercise:
-- do a cross join between shippers and products
-- using the implicit syntax
-- and then using the explicit syntax

SELECT s.name AS shipper, p.name AS product
FROM shippers s , products p
ORDER BY s.name;

SELECT *
FROM shippers s
CROSS JOIN products p;

-- With joins we can combine columns with multiple tables



