

         -- Approach 1. Using - CTE -- 
WITH calculations AS (
  SELECT d.driver_id, d.driver_name,
      ROUND(AVG(CASE WHEN EXTRACT(MONTH FROM trip_date) BETWEEN 1 AND 6 THEN t.distance_km / t.fuel_consumed END), 2) first_half_avg,
      ROUND(AVG(CASE WHEN EXTRACT(MONTH FROM trip_date) BETWEEN 7 AND 12 THEN t.distance_km / t.fuel_consumed END), 2) second_half_avg,
      ROUND(AVG(CASE WHEN EXTRACT(MONTH FROM trip_date) BETWEEN 7 AND 12 THEN t.distance_km / t.fuel_consumed END) 
          - AVG(CASE WHEN EXTRACT(MONTH FROM trip_date) BETWEEN 1 AND 6 THEN t.distance_km / t.fuel_consumed END), 2) efficiency_improvement 
  FROM trips t
  JOIN drivers d ON d.driver_id = t.driver_id
  GROUP BY d.driver_id, d.driver_name
)
SELECT * 
FROM calculations
WHERE efficiency_improvement > 0
ORDER BY efficiency_improvement DESC, driver_name;
