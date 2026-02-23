


         -- Approach 1. Using - RECURSIVE CTE -- 
WITH RECURSIVE 
	hierarchy_lvl AS (
      SELECT *, 0 AS lvl 
      FROM employees 
      WHERE manager_id IS NULL 

      UNION ALL 

      SELECT e.*, hl.lvl + 1   
      FROM hierarchy_lvl hl 
      JOIN employees e ON hl.employee_id = e.manager_id 
    ),
    ceo_sal AS (
      SELECT salary 
      FROM employees 
      WHERE manager_id IS NULL 
)
SELECT 
	  hl.employee_id subordinate_id, 
    hl.employee_name subordinate_name, 
    hl.lvl hierarchy_level, 
    hl.salary - cs.salary salary_difference
FROM hierarchy_lvl hl
CROSS JOIN ceo_sal cs 
WHERE lvl <> 0 
ORDER BY hierarchy_level, subordinate_id;
