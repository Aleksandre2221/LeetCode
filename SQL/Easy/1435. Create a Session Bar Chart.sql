

-- Risolved: 3 times 


         -- Approach 1. Using two - CTE and - LEFT JOIN -- 
WITH 
	all_bins AS (
      SELECT UNNEST(STRING_TO_ARRAY('[0-5>, [5-10>, [10-15>, 15 or more', ', ')) bin
     ),
	bins AS (
      SELECT *, 
        CASE	
            WHEN duration / 60.0 >= 15 THEN '15 or more'
            WHEN duration / 60.0 >= 10 THEN '[10-15>'
            WHEN duration / 60.0 >= 5  THEN '[5-10>'
            ELSE '[0-5>'
        END bin 
    FROM sessions
)
SELECT ab.bin,  COUNT(b.bin) total  
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



		 -- Approach 3. Using multiple CTE -- 
WITH 
	all_bins AS (
      SELECT '[0-5>' bin 
      UNION ALL
      SELECT '[5-10>' 
      UNION ALL
      SELECT '[10-15>' 
      UNION ALL
      SELECT '15 or more'
  	),
  	ex_bins AS (
      SELECT session_id,
          CASE
              WHEN duration / 60.0 >= 15 THEN '15 or more'
              WHEN duration / 60.0 >= 10 THEN '[10-15>'
              WHEN duration / 60.0 >= 5 THEN '[5-10>'
              ELSE '[0-5>'
          END AS bin
      FROM sessions
)
SELECT ab.bin, 
	COUNT(eb.session_id) total
FROM all_bins ab
LEFT JOIN ex_bins eb USING (bin)
GROUP BY ab.bin;



