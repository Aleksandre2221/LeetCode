

-- Risolved: 2 times 


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



  
         -- Approach 2. Using - Subquery within - CTE and Window Function - SUM() -- 
WITH t1 AS (
    SELECT log_id, SUM(start_date) OVER (ORDER BY log_id) pid
    FROM (
        SELECT log_id,
            CASE
                WHEN (log_id - LAG(log_id) OVER (ORDER BY log_id)) = 1 THEN 0
                ELSE 1
            END start_date
        FROM log
    ) sub
) 
SELECT 
    MIN(log_id) start_id, 
    MAX(log_id) end_id
FROM t1
GROUP BY pid
ORDER BY start_id;
