

         -- Approach 1. Using two - CTE -- 
WITH 
  row_num AS (
    SELECT *, 
        ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) rn
    FROM performance_reviews 
  ),
  rating_labels AS (
    SELECT *, 
      CASE  
          WHEN rating > LEAD(rating) OVER(PARTITION BY employee_id ORDER BY review_date DESC)
              AND rating < LAG(rating) OVER(PARTITION BY employee_id ORDER BY review_date DESC)
          THEN 0 
          ELSE 1 
      END valid_rating
    FROM row_num  
    WHERE rn <= 3 
)
SELECT e.employee_id, e.name, 
  MAX(rl.rating) - MIN(rl.rating) improvement_score
FROM rating_labels rl
JOIN employees e ON e.employee_id = rl.employee_id
GROUP BY e.employee_id, e.name
HAVING COUNT(valid_rating) = 3 
  AND SUM(valid_rating) = 2
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



		 -- Approach 3. Using one - CTE -- 
WITH is_increasing AS (
	SELECT pr.employee_id, pr.rating,
		CASE  
			WHEN rating - LEAD(rating) OVER(PARTITION BY employee_id ORDER BY review_date DESC) > 0 
      		THEN 1 
      		ELSE 0 
      	END is_increasing,
      	ROW_NUMBER() OVER(PARTITION BY pr.employee_id ORDER BY pr.review_date DESC) rn
	FROM performance_reviews pr
)
SELECT e.employee_id, e.name, 
	MAX(incr.rating) - MIN(incr.rating) improvement_score
FROM is_increasing incr 
JOIN employees e USING (employee_id)
WHERE incr.rn <= 3 
GROUP BY e.employee_id, e.name
HAVING COUNT(*) > 2 
	AND SUM(incr.is_increasing) >= 2 
	AND MAX(incr.rating) - MIN(incr.rating) > 1
ORDER BY improvement_score DESC, name;






