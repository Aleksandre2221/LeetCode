

         -- Approach 1. Using two - CTE -- 
WITH 
    bidir AS (
        SELECT departure_airport AS airport_id, flights_count FROM flights
        UNION ALL 
        SELECT arrival_airport, flights_count FROM flights
    ),
    ranking AS (
        SELECT airport_id, 
            RANK() OVER(ORDER BY SUM(flights_count) DESC) rnk 
        FROM bidir
        GROUP BY airport_id
)
SELECT airport_id
FROM ranking 
WHERE rnk = 1;
