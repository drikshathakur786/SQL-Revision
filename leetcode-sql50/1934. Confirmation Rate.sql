SELECT su.user_id, 
ROUND(
    IFNULL(
        AVG(con.action='confirmed'),0),
        2 -- round off till two decimal places
    ) AS confirmation_rate
FROM Signups su
LEFT JOIN Confirmations con
ON su.user_id = con.user_id
GROUP BY su.user_id; 