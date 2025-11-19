

         -- Approach 1. Using two - CTE -- 
WITH 
  row_num AS (
    SELECT *, ROW_NUMBER() OVER() rn 
    FROM coffeeshop
  ),
  groupped AS (
    SELECT *, 
      SUM(CASE WHEN drink IS NULL THEN 0 ELSE 1 END) OVER(ORDER BY rn) gr
    FROM row_num
)
SELECT id, 
  MAX(drink) OVER(PARTITION BY gr ORDER BY rn) drink 
FROM groupped;
