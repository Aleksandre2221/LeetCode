

-- Risolved: 3 times 


        -- Approach 1. Using - CTE with Window Function - ROW_NUMBER() -- 
WITH row_num AS (
  SELECT log_id, 
        log_id - ROW_NUMBER() OVER(ORDER BY log_id) rn
  FROM log 
)
SELECT 
    MIN(log_id) start_date, 
    MAX(log_id) end_date
FROM row_num
GROUP BY rn
ORDER BY start_date;
