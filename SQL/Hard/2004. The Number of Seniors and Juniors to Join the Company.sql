

         -- Approach 1. Using multiple - CTE -- 
WITH 
	totals AS (
      SELECT *,
          SUM(salary) OVER(PARTITION BY experience ORDER BY salary, employee_id) rolling_sum
      FROM candidates 
	), 
  seniors AS (
    SELECT 
        COUNT(employee_id) cnt,
      	70000 - COALESCE(MAX(rolling_sum), 0) remaining_budget
    FROM totals 
    WHERE experience = 'Senior' 
      AND rolling_sum <= 70000
  ),
  juniors AS (
    SELECT
        COUNT(employee_id) cnt
    FROM totals 
    WHERE experience = 'Junior' 
      AND rolling_sum <= (SELECT remaining_budget FROM seniors)
)
SELECT 'Senior' as experience, (SELECT cnt FROM seniors) accepted_candidates
UNION
SELECT 'Junior' as experience, (SELECT cnt FROM juniors) accepted_candidates;
