

         -- Approach 1. Using - CASE...WHEN - with Window Functions - LEAD() / LAG() and - WHERE condition -- 
SELECT * 
FROM (
  SELECT 
      CASE 
          WHEN free = 1 
            AND (LEAD(FREE) OVER(ORDER BY seat_id) = 1 
              OR LAG(FREE) OVER(ORDER BY seat_id) = 1)
          THEN seat_id 
      END seat_id
  FROM cinema)
WHERE seat_id IS NOT NULL;  




         -- Approach 2. Without - CASE...WHEN - Using only - Window Functions - LEAD() / LAG() and - WHERE condition -- 
SELECT seat_id 
FROM (
  SELECT *,
		LEAD(FREE) OVER(ORDER BY seat_id) next_free, 
  		LAG(FREE) OVER(ORDER BY seat_id) prev_free
  FROM cinema) sub
WHERE free = 1 AND (next_free = 1 OR prev_free = 1);
