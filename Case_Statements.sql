# What is CASE?
-- its like if-else statements in sql
-- It lets you return different values based on different conditions.



## Syntax
-- CASE
--     WHEN condition1 THEN result1
--     WHEN condition2 THEN result2
--     ...
--     ELSE default_result
-- END



# Simple Example

## Table: Employee
--   id   name    salary
--   1    Aman    25000
--   2    Riya    55000
--   3    Karan   90000


SELECT name,
       salary,
       CASE
            WHEN salary < 30000 THEN 'Low'
            WHEN salary BETWEEN 30000 AND 70000 THEN 'Medium'
            ELSE 'High'
       END AS Salary_Category
FROM Employee;


-- output:
--   Name    Salary   Category
--   Aman    25000    Low
--   Riya    55000    Medium
--   Karan   90000    High





# Execution Order
-- SQL checks conditions top to bottom
-- The first TRUE condition is returned
-- Remaining conditions are ignored.

-- ELSE is optional. Without ELSE, SQL returns NULL if no condition matches.

-- CASE
-- WHEN marks>=90 THEN 'A'
-- END;





# CASE inside SELECT
SELECT name,
CASE
WHEN age>=18 THEN 'Adult'
ELSE 'Minor'
END AS Status
FROM Student;






# CASE inside ORDER BY
SELECT *
FROM Employee
ORDER BY
CASE
WHEN department='HR' THEN 1
WHEN department='IT' THEN 2
ELSE 3
END;







# CASE inside GROUP BY
SELECT
CASE
WHEN salary>=50000 THEN 'High'
ELSE 'Low'
END AS Category,
COUNT(*) AS Employees
FROM Employee
GROUP BY
CASE
WHEN salary>=50000 THEN 'High'
ELSE 'Low'
END;



# CASE inside SUM()
SELECT
SUM(CASE WHEN gender='Male' THEN 1 ELSE 0 END) AS Male_Count,
SUM(CASE WHEN gender='Female' THEN 1 ELSE 0 END) AS Female_Count
FROM Employee;




# CASE inside COUNT()
SELECT
COUNT(CASE WHEN salary>50000 THEN 1 END)
AS High_Salary
FROM Employee;




# Conditional Aggregation- Most asked interview topic.
SELECT
department,
SUM(CASE WHEN salary>=50000 THEN salary ELSE 0 END) AS HighSalary,
COUNT(CASE WHEN salary>=50000 THEN 1 END) AS HighSalaryEmployees
FROM Employee
GROUP BY department;


# Multiple Conditions
SELECT name,
CASE
WHEN age>=18 AND marks>=40 THEN 'Pass'
WHEN age<18 THEN 'Minor'
ELSE 'Fail'
END
FROM Student;





# Nested CASE
SELECT
CASE
WHEN salary>=50000 THEN
    CASE
        WHEN experience>=5 THEN 'Senior'
        ELSE 'Mid'
    END
ELSE 'Junior'
END
FROM Employee;



# CASE with NULL
SELECT name,
CASE
WHEN manager_id IS NULL THEN 'No Manager'
ELSE 'Has Manager'
END
FROM Employee;





# Real Interview Questions

## 1. Grade Students
SELECT name,
CASE
WHEN marks>=90 THEN 'A'
WHEN marks>=75 THEN 'B'
WHEN marks>=60 THEN 'C'
ELSE 'F'
END AS Grade
FROM Student;



## 2. Weekend / Weekday
SELECT order_date,
CASE
WHEN DAYNAME(order_date) IN ('Saturday','Sunday')
THEN 'Weekend'
ELSE 'Weekday'
END
FROM Orders;



## 3. Bonus
SELECT name,
salary,
CASE
WHEN salary>=80000 THEN salary*0.20
WHEN salary>=50000 THEN salary*0.10
ELSE salary*0.05
END AS Bonus
FROM Employee;



## 4. Profit or Loss
SELECT product,
CASE
WHEN profit>0 THEN 'Profit'
WHEN profit<0 THEN 'Loss'
ELSE 'No Profit No Loss'
END
FROM Sales;




## 5. Age Group
SELECT name,
CASE
WHEN age<13 THEN 'Child'
WHEN age<20 THEN 'Teen'
WHEN age<60 THEN 'Adult'
ELSE 'Senior Citizen'
END
FROM People;




# Mistakes
-- Forgetting END
-- Using = instead of comparison operators incorrectly
-- Writing ELSE WHEN



-- Correct:
-- CASE
-- WHEN ...
-- THEN ...
-- ELSE ...
-- END

