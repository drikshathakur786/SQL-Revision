-- LC 1068
SELECT product_name, year, price
FROM Sales s
LEFT JOIN Product p ON
p.product_id = s.product_id;
