

-- Risolved: 2 times 


         -- Approach 1. Using two - CTE and - LEFT JOIN -- 
WITH 
	all_bins AS (
      SELECT UNNEST(STRING_TO_ARRAY('[0-5>, [5-10>, [10-15>, 15 or more', ', ')) bin
     ),
	bins AS (
      SELECT *, 
        CASE	
            WHEN duration::numeric / 60 < 5 THEN '[0-5>'
            WHEN duration::numeric / 60 >= 5 AND duration::numeric / 60 < 10 THEN '[5-10>'
            WHEN duration::numeric / 60 >= 10 AND duration::numeric / 60 < 15 THEN '[10-15>'
            ELSE '15 or more'
        END bin 
    FROM sessions
)
SELECT ab.bin,  COUNT(b.bin)total total 
FROM all_bins ab 
LEFT JOIN bins b ON ab.bin = b.bin
GROUP BY ab.bin;



         -- Approach 2. Using - UNION -- 
SELECT '[0-5>' AS bin, COUNT(*) total FROM Sessions WHERE duration < 300
UNION
SELECT '[5-10>' AS bin, COUNT(*) total FROM Sessions WHERE 300 <= duration AND duration < 600
UNION
SELECT '[10-15>' AS bin, COUNT(*) total FROM Sessions WHERE 600 <= duration AND duration < 900
UNION
SELECT '15 or more' AS bin, COUNT(*) total FROM Sessions WHERE 900 <= duration;







