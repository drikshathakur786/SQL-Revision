-- use sql_store;

-- SELECT *
-- FROM customers
-- where customer_id =1
-- order by first_name; 

SELECT 
	first_name, 
    last_name, 
    points, 
    -- points *10 +10
    (points+ 10)*100 as "discount factor"
FROM customers;

SELECT distinct state
FROM customers;

-- exercise
-- return all the products
-- name
-- unit price
-- new price (unit price * 1.1)

SELECT 
	name, 
    unit_price, 
    (unit_price*1.1) AS 'new price' 
FROM products;


SELECT *
FROM customers

-- points greater than 3000
-- WHERE points>3000;

-- get customers where state = virginia
-- WHERE state = 'VA';

-- get customers outside the state of virginia
-- WHERE state != 'VA';

-- get customers born after january 1, 1990
WHERE birth_date > '1990-01-01';

-- get orders placed this year 
-- SELECT *
-- FROM orders
-- WHERE order_date >= '2019 -01-01';

-- and, or, not operators
SELECT *
FROM CUSTOMERS
-- WHERE birth_date >= '2019-01-01' AND points>1000;

-- changing order by ()
-- WHERE birth_date >= '2019-01-01' OR 
-- (points>1000 AND state='VA');

WHERE NOT(birth_date > '1990-01-01' OR points>1000);


-- Exercise ----
-- from the order_items table, get the items
-- for order #6
-- where the total price greater than 30

-- total price = (unit price * quantity)
SELECT *
FROM order_items
WHERE order_id=6 AND (unit_price*quantity) >30;

-- IN operator
SELECT *
FROM customers
-- WHERE state = 'VA' or state = 'GA' or state = 'Fa'; 

-- WHERE state IN ('va', 'ga', 'fa');

WHERE state NOT IN ('VA', 'GA', 'FA');

-- exercise
-- return products with quantity in stock equal to 49, 38, 72
SELECT *
FROM products
WHERE quantity_in_stock IN ('49','38','72');

-- between operator
SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;

-- exercise
-- return customers born between 1/1/1990 and 1/1/2000
SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-1-1' AND '2000-1-1';

-- LIKE operator
SELECT *
FROM customers
-- WHERE last_name LIKE 'B%';
-- WHERE last_name LIKE '%B%'; 

-- LAST NAME END WITH Y
-- WHERE last_name LIKE '%Y';

-- WHERE last_name LIKE '_____Y';

WHERE last_name LIKE 'B____Y';

-- exercise
-- get the customers whose address contain trail or avenue
SELECT *
FROM customers
WHERE address like "%trail%" or address like "%avenue";

-- phone no. ends with 9
SELECT *
FROM customers
WHERE phone like '%9';

-- REGEX operator:
SELECT * 
FROM customers
-- WHERE last_name LIKE '%field%';

-- WHERE last_name REGEXP 'field';

-- WHERE last_name REGEXP '^FIELD';

-- WHERE last_name REGEXP 'FIELD$';

-- WHERE last_name REGEXP 'FIELD|MAC';

WHERE last_name REGEXP 'field | mac | rose';

-- customers having e in their last name but make sure before letter e we have g or an i
SELECT *
FROM customers
WHERE last_name REGEXP '[GI]E';

-- supply range of characters
SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e';

-- exercise
SELECT *
FROM customers

-- first name are ELKA and AMBUR
-- WHERE first_name REGEXP 'ELKA|AMBUR';

-- last name end with EY or ON
-- WHERE last_name REGEXP 'EY$|ON$';

-- last name must start with MY or contains se
-- WHERE last_name REGEXP '^my|se';

-- last names contain b followed by r or u;
-- WHERE last_name REGEXP 'B[RU]';

WHERE last_name REGEXP 'br|bu';



-- NULL operator : absence of a value

-- CUSTOMERS DONT HAVE A PHONE
SELECT *
FROM customers
WHERE phone is NULL;

-- customers do have a phone
SELECT *
FROM customers
WHERE phone is NOT NULL;

-- get the orders that are not shipped
SELECT *
FROM orders
WHERE shipped_date is NULL;


-- ORDER BY clause:
SELECT *
FROM customers
-- ORDER BY first_name DESC;

-- can sort for multiple columns too
-- ORDER BY state, first_name;

ORDER BY state desc, first_name;

SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY first_name, points;

-- exercise
-- items having id=2, sort them by their total price in descending order
SELECT * , (quantity*unit_price) AS total_price
FROM order_items
WHERE order_id=2
ORDER BY (quantity*unit_price) DESC;

-- LIMIT OPERATOR:
SELECT *
FROM customers
LIMIT 3;

-- PAGE 1: 1-3
-- PAGE 2: 4-6
-- PAGE 3: 7-9
-- retrieve customers on page 3
-- LIMIT 6,3;

-- exercise
-- get the top three loyal customers
SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;











