

         -- Approach 1. Using multiple - RECURSIVE CTE -- 
WITH 
	RECURSIVE rec AS (
      SELECT 1 AS num
      UNION ALL  
      SELECT num + 1 
      FROM rec
      WHERE num < (SELECT MAX(frequency) FROM number_frequency) 
    ),
    row_num AS (
      SELECT n.number, 
      	ROW_NUMBER() OVER(ORDER BY n.number) rn,
      	COUNT(*) OVER() total_num
      FROM number_frequency n 
      LEFT JOIN rec ON n.frequency >= rec.num
	),
  considered_rows AS (
      SELECT *, 
          CASE  
            WHEN total_num % 2 = 0 
        			THEN rn IN (total_num/2, (total_num/2 + 1)) 
            ELSE rn = (total_num + 1) / 2
          END considered
      FROM row_num
)
SELECT ROUND(AVG(number), 1) median 
FROM considered_rows
WHERE considered = TRUE;



          -- Approach 2. Using - generate_series (ONLY PostgreSQL) -- 
WITH 
	gn AS (
    SELECT n.number 
    FROM number_frequency n
    CROSS JOIN generate_series(1, n.frequency)  
	), 
  row_num AS (
    SELECT *, 
      ROW_NUMBER() OVER(ORDER BY number) rn, 
      COUNT(*) OVER() total_num
    FROM gn 
)
SELECT ROUND(AVG(number), 1) median 
FROM row_num 
WHERE rn IN ((total_num+1)/2, (total_num+2)/2);

