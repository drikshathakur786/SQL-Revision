
SELECT v.customer_id, COUNT(*) as count_no_trans
FROM Visits v
LEFT JOIN Transactions t ON
v.visit_id = t.visit_id
WHERE transaction_id IS NULL
GROUP BY v.customer_id; # grouping by no transaction visits

# count(*) counts how many rows are there