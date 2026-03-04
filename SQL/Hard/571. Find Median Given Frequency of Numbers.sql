

         -- Approach 1. Using - RECURSIVE CTE -- 
WITH 
	RECURSIVE freq AS (
      SELECT num, 1 AS times, frequency 
      FROM numbers 
      UNION ALL 
      SELECT num, times+1, frequency
      FROM freq 
      WHERE times <= frequency-1
    ),
    total_nums AS (
      SELECT num,
      	ROW_NUMBER() OVER(ORDER BY num) rn,
      	COUNT(*) OVER() total_nums 
      FROM freq  
)
SELECT avg(num) median 
FROM total_nums
WHERE rn BETWEEN total_nums / 2.0 AND (total_nums / 2.0) + 1



          -- Approach 2. Using - generate_series (ONLY PostgreSQL) -- 
WITH 
	gn AS (
    SELECT n.num 
    FROM numbers n
    CROSS JOIN generate_series(1, n.frequency)  
	), 
  row_num AS (
    SELECT *, 
      ROW_NUMBER() OVER(ORDER BY num) rn, 
      COUNT(*) OVER() total_num
    FROM gn 
)
SELECT ROUND(AVG(num), 1) median 
FROM row_num 
WHERE rn IN ((total_num+1)/2, (total_num+2)/2);

