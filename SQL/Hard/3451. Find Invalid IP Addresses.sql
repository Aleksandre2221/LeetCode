


         -- Approach 1. Using multiple - CTE -- 
WITH 
	sep_nums AS (
    SELECT ip, 
      	UNNEST(STRING_TO_ARRAY(ip, '.')) num
    FROM logs
    GROUP BY ip
	), 
  great_nums AS (
    SELECT DISTINCT ip
    FROM sep_nums  
    WHERE num::int > 255
	), 
  lead_zeros AS (
    SELECT DISTINCT ip 
    FROM sep_nums  
    WHERE LEFT(num, 1) = '0'
	), 
  many_octets AS (
    SELECT ip 
    FROM sep_nums  
    GROUP BY ip 
    HAVING COUNT(*) <> 4
	),
  all_invalid AS (
	  SELECT ip FROM great_nums 
    UNION 
		SELECT ip FROM lead_zeros 
    UNION 
    SELECT ip FROM many_octets
)
SELECT l.ip, COUNT(l.ip) invalid_count 
FROM logs l
JOIN all_invalid ai USING (ip)
GROUP BY l.ip 
ORDER BY invalid_count DESC, ip DESC; 
