

         -- Approach 1. Using - CTE with a Window Function - DENSE_RANK() --
WITH ranking AS (
  SELECT *, DENSE_RANK() OVER(PARTITION BY dept ORDER BY salary DESC) rnk
  FROM employees
)
SELECT emp_id, dept 
FROM ranking 
WHERE rnk = 2
ORDER BY emp_id;
