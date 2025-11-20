

         -- Approach 1. Using - LEAST / GREATEST -- 
SELECT p.flight_id, 
	LEAST(COUNT(*), MAX(f.capacity)) booked_cnt,
	GREATEST(COUNT(*) - MAX(f.capacity), 0) waitlist_cnt 
FROM passengers p
JOIN flights f ON f.flight_id = p.flight_id
GROUP BY p.flight_id
ORDER BY flight_id;



         -- Approach 2. Using - CASE...WHEN conditions -- 
SELECT p.flight_id,
    CASE 
        WHEN COUNT(*) <= f.capacity THEN COUNT(*) 
        ELSE f.capacity 
    END booked_cnt,
    CASE 
        WHEN COUNT(*) > f.capacity THEN COUNT(*) - f.capacity
        ELSE 0
    END waitlist_cnt
FROM passengers p
JOIN flights f ON p.flight_id = f.flight_id
GROUP BY p.flight_id, f.capacity
ORDER BY flight_id;
