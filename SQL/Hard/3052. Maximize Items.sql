


         -- Approach 1. Using multuple - CTE -- 
WITH 
  summary AS (
    SELECT item_type, 
        SUM(square_footage) total_sq, 
        COUNT(*) item_count
    FROM inventory
    GROUP BY item_type
  ),
	prime AS (
    SELECT item_type,
        (FLOOR(500000 / total_sq) * item_count) item_count,
        (500000 % total_sq) remaining_sq
    FROM summary
    WHERE item_type = 'prime_eligible'
  ),
	not_prime AS (
	  SELECT item_type,
    	  FLOOR((SELECT remaining_sq FROM prime) / total_sq) * item_count AS item_count
    FROM summary
    WHERE item_type = 'not_prime'
)
SELECT item_type, item_count FROM prime
UNION ALL
SELECT item_type, item_count FROM not_prime ORDER BY item_count DESC;



