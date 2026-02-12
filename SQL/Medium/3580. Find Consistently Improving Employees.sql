

-- Risolved: 3 times


		-- Approach 1. Using - CTE with - ROW_NUMBER() -- 
WITH row_num AS (
	SELECT *, 
      ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) rn 
    FROM performance_reviews
)
SELECT e.employee_id, e.name, 
	MAX(CASE WHEN rn.rn = 1 THEN rn.rating END) - MAX(CASE WHEN rn.rn = 3 THEN rn.rating END) improvement_score
FROM row_num rn 
JOIN employees e USING (employee_id)
WHERE rn <= 3 
GROUP BY e.employee_id, e.name
HAVING COUNT(rn.review_id) = 3 
	AND MAX(CASE WHEN rn.rn = 1 THEN rn.rating END) > MAX(CASE WHEN rn.rn = 2 THEN rn.rating END)
    AND MAX(CASE WHEN rn.rn = 2 THEN rn.rating END) > MAX(CASE WHEN rn.rn = 3 THEN rn.rating END)
ORDER BY improvement_score DESC, name;



         -- Approach 2. Using - array and indexing (Only PostgreSQL) -- 
SELECT employee_id, name, 
	ratings[1] - ratings[3] improvement_score
FROM employees 
JOIN 
	(
    	SELECT employee_id, 
      		ARRAY_AGG(rating ORDER BY review_date DESC) ratings
    	FROM performance_reviews
    	GROUP BY employee_id
    	HAVING COUNT(*) >= 3
) USING(employee_id)
WHERE ratings[1] > ratings[2] AND ratings[2] > ratings[3]
ORDER BY improvement_score DESC, name;




