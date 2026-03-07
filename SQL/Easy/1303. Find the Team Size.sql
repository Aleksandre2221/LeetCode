

         -- Approach 1. Using Window Function - COUNT() -- 
SELECT employee_id, COUNT(*) OVER(PARTITION BY team_id) team_size   
FROM employee;



         -- Approach 2. Without using Window FUncions, only - Subquery within - JOIN and GROUP BY -- 
SELECT employee_id, team_size   
FROM employee e 
JOIN (
  SELECT team_id, COUNT(*) team_size 
  FROM employees 
  GROUP BY team_id) sub ON sub.team_id = e.team_id;



        -- Approach 3. Using - CTE -- 
WITH cnt AS (
  SELECT team_id, COUNT(*) team_size 
  FROM employee 
  GROUP BY team_id
)
SELECT employee_id, team_size   
FROM employees e
JOIN cnt ON cnt.team_id = e.team_id;




