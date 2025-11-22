

         -- Approach 1. Using - CTE with a Window Function - ROW_NUMBER() -- 
WITH grouped AS (
	SELECT *, id - ROW_NUMBER() OVER() gn
	FROM stadium 
	WHERE people >= 100 
) 
SELECT id, visit_date, people
FROM grouped 
WHERE gn IN (
	SELECT gn 
	FROM grouped  
	GROUP BY gn
	HAVING COUNT(*) >= 3
);
