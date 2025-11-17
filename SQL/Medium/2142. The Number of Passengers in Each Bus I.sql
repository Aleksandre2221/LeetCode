

         -- Approach 1. Using - CTE -- 
WITH passenger_bus AS (
    SELECT p.passenger_id,
        MIN(b.bus_id) bus_id
    FROM passengers p
    JOIN buses b ON p.arrival_time <= b.arrival_time
    GROUP BY p.passenger_id
)
SELECT b.bus_id,
    COUNT(pb.passenger_id) passenger_count
FROM buses b
LEFT JOIN passenger_bus pb ON b.bus_id = pb.bus_id
GROUP BY b.bus_id;
