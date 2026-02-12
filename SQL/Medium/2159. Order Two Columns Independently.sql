

-- Risolved: 3 times



         -- Approach 1. Using two - CTE with Window Function - ROW_NUMBER() -- 
WITH 
	f_col AS (
      SELECT first_col, 
      	ROW_NUMBER() OVER(ORDER BY first_col) rn 
      FROM data
	), 
    s_col AS (
      SELECT second_col, 
      	ROW_NUMBER() OVER(ORDER BY second_col DESC) rn
      FROM DATA
)
SELECT first_col, second_col 
FROM f_col 
JOIN s_col USING (rn);
