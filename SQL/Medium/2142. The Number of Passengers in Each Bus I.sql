

-- Risolved: 3 times


          -- Approach 1. Using - CTE with a Window Function - ROW_NUMBER() -- 
WITH assigned_bus AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY p.passenger_id ORDER BY b.arrival_time) AS rn
    FROM passengers p
    JOIN buses b ON p.arrival_time <= b.arrival_time
)
SELECT b.bus_id, COUNT(ab.passenger_id) AS passenger_count
FROM buses b
LEFT JOIN assigned_bus ab ON b.bus_id = ab.bus_id AND ab.rn = 1
GROUP BY b.bus_id
ORDER BY b.bus_id;



         -- Approach 2. Using - CTE -- 
WITH assigned_bus AS (
    SELECT p.passenger_id,
        MIN(b.bus_id) bus_id
    FROM passengers p
    JOIN buses b ON p.arrival_time <= b.arrival_time
    GROUP BY p.passenger_id
)
SELECT b.bus_id,
    COUNT(ab.passenger_id) passenger_count
FROM buses b
LEFT JOIN assigned_bus ab ON b.bus_id = ab.bus_id
GROUP BY b.bus_id
ORDER BY b.bus_id;



         -- Approach 3. Using - CTE with - DISTINCT ON condition - (Postgres ONLY) -- 
WITH assigned_bus AS (
  SELECT DISTINCT ON (p.passenger_id) * 
  FROM buses b 
  JOIN passengers p ON P.arrival_time <= b.arrival_time
)
SELECT b.bus_id, COUNT(ab.passenger_id)  
FROM buses b 
LEFT JOIN assigned_bus ab ON b.bus_id = ab.bus_id
GROUP BY b.bus_id
ORDER BY b.bus_id;





