

         -- Approach 1. Using - Subquery and - LEFT JOIN -- 
SELECT d.driver_id, COUNT(r.passenger_id) cnt
FROM (
  	SELECT DISTINCT driver_id 
  	FROM rides
) d 
LEFT JOIN rides r ON d.driver_id = r.passenger_id 
GROUP BY d.driver_id;



         -- Approach 2. Using - CTE and - LEFT JOIN -- 
WITH drivers AS (
  SELECT DISTINCT driver_id FROM rides
)
SELECT d.driver_id, COUNT(r.passenger_id) cnt
FROM drivers d 
LEFT JOIN rides r ON d.driver_id = r.passenger_id 
GROUP BY d.driver_id;
