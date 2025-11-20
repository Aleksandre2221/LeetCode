

         -- Approahc 1. Using - GROUP BY with - HAVING condition -- 
SELECT e.employee_id 
FROM employees e  
LEFT JOIN logs l ON e.employee_id = l.employee_id
GROUP BY e.employee_id
HAVING COALESCE(SUM(CEIL(EXTRACT(EPOCH FROM (out_time - in_time)) / 60.0)), 0) < (e.needed_hours * 60);



         -- Approach 2. Using - CTE -- 
WITH worked_minutes AS (
    SELECT employee_id,
      SUM(CEIL(EXTRACT(EPOCH FROM (out_time - in_time)) / 60.0)) total_minutes
    FROM logs
    GROUP BY employee_id
)
SELECT e.employee_id
FROM employees e
LEFT JOIN worked_minutes w ON e.employee_id = w.employee_id
WHERE COALESCE(w.total_minutes, 0) < e.needed_hours * 60;
