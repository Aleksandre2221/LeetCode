


         -- Approach 1. Using - CTE with Window Functions - MAX() -- 
WITH max_left_right AS (
  SELECT *,
      MAX(height) OVER(ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) max_l,
      MAX(height) OVER(ORDER BY id DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) max_r
  FROM heights
) 
SELECT SUM(LEAST(max_l, max_r) - height) total_trapped_water  
FROM max_left_right;
