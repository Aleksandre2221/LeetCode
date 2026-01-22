

         -- Approach 1. Using - CTE for Anti-Join -- 
WITH most_recent AS (
  SELECT id, max(month) "month" 
  FROM employee 
  GROUP BY id 
  ORDER BY 1, 2
)
SELECT e.id, e.month, 
	SUM(e.salary) OVER(PARTITION BY e.id ORDER BY e.month) salary 
FROM employee e  
JOIN most_recent mr ON e.id = mr.id AND e.month <> mr.month
ORDER BY id, month DESC; 


         -- Approach 2. Using - NOT IN condition -- 
SELECT id, month, 
  SUM(salary) OVER(PARTITION BY id ORDER BY month) salary
FROM employee
WHERE (id, month) NOT IN (
  SELECT id, MAX(month)
  FROM employee 
  GROUP BY id
)
ORDER BY id, month DESC;
