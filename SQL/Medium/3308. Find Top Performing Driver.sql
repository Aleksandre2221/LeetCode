

         -- Approach 1. Using - 
WITH ranking AS (
  SELECT v.fuel_type, d.driver_id,
      ROUND(AVG(rating), 2) rating, 
      SUM(t.distance) distance, 
      MIN(d.accidents) accidents,
      RANK() OVER(
              PARTITION BY v.fuel_type 
              ORDER BY AVG(rating) DESC, SUM(t.distance) DESC, MIN(d.accidents)) rnk
  FROM trips t  
  JOIN vehicles v ON v.vehicle_id = t.vehicle_id
  JOIN drivers d ON d.driver_id = v.driver_id
  GROUP BY v.fuel_type, d.driver_id
)
SELECT fuel_type, driver_id, rating, distance 
FROM ranking 
WHERE rnk = 1;
