# Write your MySQL query statement below
SELECT w.id
FROM Weather w
JOIN Weather nw ON DATEDIFF(w.recordDate, nw.recordDate) = 1
WHERE w.temperature > nw.temperature;
