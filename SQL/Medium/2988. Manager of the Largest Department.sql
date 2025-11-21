

         -- Approach 1. Using - CTE -- 
WITH cnt AS (
  SELECT dep_id, COUNT(*) cnt
  FROM employees 
  GROUP BY dep_id
)
SELECT cnt.dep_id, e.emp_name 
FROM cnt 
JOIN employees e ON e.dep_id = cnt.dep_id
WHERE cnt.cnt = (SELECT MAX(cnt) FROM cnt)
	AND e.position = 'Manager';
