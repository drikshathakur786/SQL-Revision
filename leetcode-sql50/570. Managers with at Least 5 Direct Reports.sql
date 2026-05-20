SELECT e.name
FROM employee e
JOIN employee emp
ON e.id=emp.managerId
GROUP BY e.id,e.name -- without this cannot calculate count for each manager separately 
HAVING COUNT(emp.managerId) >= 5;