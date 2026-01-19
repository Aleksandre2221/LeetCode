

         -- Approach 1. Using multiple - CTE -- 
WITH 
	row_num AS (
		SELECT *, ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary) rn  
		FROM salaries 
	),
  median_rn AS (
	  SELECT company, 
      CASE 
    		  WHEN MAX(rn) % 2 != 0 THEN (MAX(rn) / 2) + 1 
        	WHEN MAX(rn) % 2 = 0 THEN MAX(rn) / 2
		  END median_id
	  FROM row_num
    GROUP BY company 
  
    UNION ALL
      
	  SELECT company, 
    	CASE WHEN MAX(rn) % 2 = 0 THEN (MAX(rn) / 2) + 1 END 
    FROM row_num 
    GROUP BY company
)
SELECT rn.id, rn.company, rn.salary
FROM median_rn mrn 
JOIN row_num rn ON rn.rn = mrn.median_id AND rn.company = mrn.company;


           -- Approach 2. Using one - CTE -- 
WITH row_num AS (
	SELECT *, 
		ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary) rn,
    COUNT(*) OVER(PARTITION BY company) n
	FROM salaries 
)
SELECT id, company, salary
FROM row_num 
WHERE rn BETWEEN (n/2) AND (n/2) + 1;







