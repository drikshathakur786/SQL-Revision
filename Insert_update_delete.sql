-- Inserting a single row
INSERT INTO customers( 
	first_name,
    last_name,
    birth_date,
    address,
    city,
    state)
VALUES (
    'John', 
    'Smith', 
    '1990-01-01',
    'address',
    'city',
    'CA'
);

-- Inserting multiple rows
INSERT INTO shippers(name)
VALUES('Johnny'),
		('Kate'),
        ('ELsa');

-- exercise: Insert 3 rows in the products table
INSERT INTO products(name, quantity_in_stock, unit_price)
VALUES ('butter', '50', '1.45'),
		('cake', '10', '2.3');
        
-- Inserting hierarchical rows: inserting data into multiple tables
INSERT INTO orders(customer_id, order_date, status)
VALUES (1, '2019-01-01',  1);

-- order insert done. mysql will generate an id for that order
-- we need to access that id in order to insert the items. use the built in function- LAST_INSERT_ID();

INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 2.95),
	(LAST_INSERT_ID(), 2, 3, 3.95);

SELECT LAST_INSERT_ID(); -- 11


-- Creating a copy of a table: how to copy data from one table to another
CREATE TABLE orders_archive AS
SELECT * FROM orders;

INSERT INTO orders_archive
SELECT *
FROM orders
WHERE order_date < '2019-01-01';

-- exercise:
-- invoice table copy invoice_archive. 
-- instead of client_id we want client_name. so we have to join this with clients table then use that query as a sub query in create table statement.
-- only copy the invoices that do have a payment ( do have a payment date)
USE sql_invoicing; 


CREATE TABLE invoice_archive AS
SELECT i.invoice_id,
	i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
FROM invoices i
JOIN clients c USING(client_id)
WHERE payment_date is NOT NULL;

-- Updating a single row
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,  -- 50%
    payment_date = due_date
WHERE invoice_id = 3;


-- UPDATING multiple rows
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,  -- 50%
    payment_date = due_date
WHERE client_id IN (3,4);

-- exercise: write a sql statement to give any customers born before 1990 50 extra points
USE sql_store;
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';


-- USING SUBQUERIES IN UPDATE
use sql_invoicing;
SELECT client_id
FROM clients
WHERE name = 'Myworks';


UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,  -- 50%
    payment_date = due_date
WHERE client_id IN
	(SELECT client_id
	FROM clients
	WHERE state IN ('CA', 'NY'));
    
    
-- exercise: in sql_store. orders table. some orders dont have a comment. update comments for orders for customers>3000 points as GOLD
use sql_store;

UPDATE orders
SET 
	comments = 'Gold customers'
WHERE customer_id IN (
	SELECT customer_id
	FROM customers 
	WHERE points>3000); 
    

-- DELETING rows
DELETE FROM invoices
WHERE invoice_id = (
	SELECT *
	FROM clients
	WHERE name = 'Myworks');