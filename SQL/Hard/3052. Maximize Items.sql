


         -- Approach 1. Using multuple - CTE -- 
WITH 
	prime AS (
      SELECT item_type,
      	 COUNT(DISTINCT item_id) * FLOOR(500000 / SUM(square_footage)) item_count, 
      	 SUM(square_footage) * FLOOR(500000 / SUM(square_footage)) total_occupied,
      	 500000 - SUM(square_footage) * FLOOR(500000 / SUM(square_footage)) remaining
      FROM inventory 
      WHERE item_type = 'prime_eligible'
      GROUP BY item_type
	), 
    not_prime AS (
      SELECT item_type,
      	 FLOOR((SELECT remaining FROM prime) / SUM(square_footage)) * COUNT(DISTINCT item_id) item_count
      FROM inventory 
      WHERE item_type = 'not_prime'
      GROUP BY item_type
)
SELECT item_type, item_count FROM prime
UNION ALL 
SELECT item_type, item_count FROM not_prime



