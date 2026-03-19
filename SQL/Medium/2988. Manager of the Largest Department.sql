

         -- Approach 1. Using - CTE -- 
WITH ranking AS (
    SELECT dep_id, 
        RANK() OVER(ORDER BY COUNT(*) DESC) rnk
    FROM employees 
    GROUP BY dep_id
)
SELECT 
    e.emp_name manager_name, 
    dep_id
FROM ranking r 
JOIN employees e USING (dep_id)
WHERE r.rnk = 1 AND e.position = 'Manager'
ORDER BY dep_id;
