

Risolved: 2 times


         -- Approach 1. Using - Subquery with Window Funcion - DENSE_RANK() -- 
SELECT project_id, employee_id
FROM (
  SELECT project_id, pr.employee_id, 
  	DENSE_RANK() OVER(PARTITION BY pr.project_id ORDER BY em.experience_years DESC) rnk
  FROM project pr 
  JOIN employee em ON pr.employee_id = em.employee_id
)
WHERE rnk = 1;



         -- Approach 2. Using - CTE with Window Funcion - DENSE_RANK() --
WITH ranking AS (
  SELECT pr.project_id, pr.employee_id,
         DENSE_RANK() OVER(PARTITION BY pr.project_id ORDER BY em.experience_years DESC) rnk
  FROM project pr
  JOIN employee em ON pr.employee_id = em.employee_id
)
SELECT project_id, employee_id
FROM ranking
WHERE rnk = 1;

