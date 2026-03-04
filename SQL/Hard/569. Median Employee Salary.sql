

-- Risolved: 2 times


         -- Approach 1. Using multiple - CTE -- 
WITH 
	row_num AS (
		SELECT *, 
			ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary) rn  
		FROM employee 
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








