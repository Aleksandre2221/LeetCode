


         -- Approach 1. Using - CTE with - a Window Function AVG() -- 
WITH avg_workload AS (
  SELECT *, 
      AVG(workload) OVER(PARTITION BY e.team) AS avg_w
  FROM employees e  
  JOIN project p USING (employee_id)
)
SELECT 
	employee_id, 
  project_id, 
  name AS employee_name, 
  workload AS project_workload 
FROM avg_workload 
WHERE workload > avg_w
ORDER BY employee_id, project_id;
