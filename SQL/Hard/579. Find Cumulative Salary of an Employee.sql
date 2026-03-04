

         -- Approach 1. Using - CTE with Window Functions -- 
WITH calculations AS (
    SELECT id, month, 
        SUM(salary) OVER(PARTITION BY id ORDER BY month RANGE 2 PRECEDING) salary,
        RANK() OVER(PARTITION BY id ORDER BY month DESC) rnk
    FROM employee
 )
 SELECT id, month, salary
 FROM calculations 
 WHERE rnk > 1
 ORDER BY id, month DESC;
