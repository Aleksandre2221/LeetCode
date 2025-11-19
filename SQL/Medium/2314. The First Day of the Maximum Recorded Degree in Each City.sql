

         -- Approach 1. Using - CTE with a Window Function - ROW_NUMBER() -- 
WITH row_num AS (
  SELECT *, 
    ROW_NUMBER() OVER(PARTITION BY city_id ORDER BY degree DESC, DAY ) rn
  FROM weather
)
SELECT city_id city, day, degree 
FROM row_num 
WHERE rn = 1;



         -- Approach 2. Using Window Functions - FIRST_VALUE() -- 
SELECT DISTINCT
    city_id city,
    FIRST_VALUE(day) OVER (PARTITION BY city_id ORDER BY degree DESC, day) AS day,
    FIRST_VALUE(degree) OVER (PARTITION BY city_id ORDER BY degree DESC, day) AS degree
FROM weather;
