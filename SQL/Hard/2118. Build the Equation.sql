


         -- Approach 1. Using - CONCAT function -- 
WITH prep AS (
  SELECT power, 
      CONCAT(
          CASE 
              WHEN factor > 0 
              THEN '+'
              ELSE '-' 
          END, 
          ABS(factor),
          CASE 
            	WHEN "power" = 1 THEN 'X' 
            	WHEN "power" > 1 THEN CONCAT('X', '^', power)
            	ELSE ''
          END) terms
  FROM terms
)
SELECT 
    CONCAT(
          STRING_AGG(terms, '' ORDER BY power DESC)
      , ' = 0') equation
FROM prep; 
