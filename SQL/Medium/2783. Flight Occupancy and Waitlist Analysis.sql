


         -- Approach 1. Using - CASE...WHEN conditions -- 
SELECT 
	f.flight_id, 
    CASE  
    	WHEN capacity >  COUNT(p.flight_id) AND COUNT(p.flight_id) > 0 THEN COUNT(p.flight_id)
        WHEN capacity <= COUNT(p.flight_id) AND COUNT(p.flight_id) > 0 THEN capacity
        ELSE 0
	END booked_cnt, 
    CASE  
    	WHEN capacity < COUNT(p.flight_id) AND COUNT(p.flight_id) > 0
        THEN COUNT(p.flight_id) - capacity
        ELSE 0
	END waitlist_cnt
FROM flights f  
LEFT JOIN passengers p ON f.flight_id = p.flight_id
GROUP BY f.flight_id, f.capacity
ORDER BY flight_id;
