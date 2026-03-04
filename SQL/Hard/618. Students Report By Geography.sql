


         -- Approach 1. Using - CTE with a Window Funcion - ROW_NUMBER() -- 
WITH row_num AS (
    SELECT *, 
        ROW_NUMBER() OVER(PARTITION BY continent ORDER BY name) rn
    FROM student
)
SELECT 
    MAX(CASE WHEN continent = 'America' THEN name END) "America",
    MAX(CASE WHEN continent = 'Asia' THEN name END) "Asia",
    MAX(CASE WHEN continent = 'Europe' THEN name END) "Europe"
FROM row_num 
GROUP BY rn
ORDER BY "America", "Asia", "Europe";
