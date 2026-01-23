


         -- Approach 1. Using - CTE with a Window Funcion - ROW_NUMBER() -- 
WITH row_num AS (
  SELECT *, 
    ROW_NUMBER() OVER(PARTITION BY continent ORDER BY name) rn
  FROM people
)
SELECT 
	MAX(CASE WHEN continent = 'America' THEN name END) america,
  MAX(CASE WHEN continent = 'Asia' THEN name END) asia,
  MAX(CASE WHEN continent = 'Europe' THEN name END) europe
FROM row_num
GROUP BY rn; 
