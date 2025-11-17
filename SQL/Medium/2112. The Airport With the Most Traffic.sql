

         -- Approach 1. Using two - CTE -- 
WITH 
	all_airports AS (
  		SELECT departure_airport airport_id, flights_count FROM flights
  		UNION ALL  
  		SELECT arrival_airport, flights_count FROM flights
	),
    total_flights AS (
      SELECT airport_id, SUM(flights_count) total 
      FROM all_airports
      GROUP BY airport_id
)
SELECT airport_id
FROM total_flights tf 
WHERE total = (SELECT MAX(total) FROM total_flights);
