


         -- Approach 1. Using - CONCAT function -- 
WITH left_side AS (
  SELECT power,
      CONCAT(
        CASE 
          WHEN factor > 0 THEN '+'
        END, 
        factor::text,
        CASE 
          WHEN power = 1 THEN 'X'
          WHEN power = 0 THEN ''
          ELSE CONCAT('X^', power)
        END
      )ls
  FROM terms
)
SELECT CONCAT(STRING_AGG(ls, '' ORDER BY POWER DESC), '=0') equation 
FROM left_side
