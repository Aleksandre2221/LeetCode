


         -- Approach 1. Using multiple - CTE -- 
WITH 
	rolling_sum AS (
    SELECT *, 
        SUM(salary) OVER(PARTITION BY experience ORDER BY salary) rolling_sum
    FROM candidates
	),
  seniors AS (
    SELECT employee_id, rolling_sum
    FROM rolling_sum
    WHERE experience = 'Senior' 
      	AND rolling_sum <= 70000
  ), 
  juniors AS (
    SELECT employee_id 
    FROM rolling_sum
    WHERE experience = 'Junior' 
        AND rolling_sum <= (SELECT 70000 - COALESCE(MAX(rolling_sum), 0) FROM seniors)    
)
SELECT employee_id FROM juniors
UNION ALL 
SELECT employee_id FROM seniors;
