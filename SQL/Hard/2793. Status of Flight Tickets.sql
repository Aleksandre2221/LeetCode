


         -- Approach 1. Using - CTE -- 
WITH row_num AS (
  SELECT *, 
      capacity - ROW_NUMBER() OVER(PARTITION BY flight_id ORDER BY booking_time) rn
  FROM flights f  
  JOIN passengers p USING (flight_id)
)
SELECT passenger_id, 
	CASE 
    	WHEN rn >= 0 THEN 'Confirmed'
      ELSE 'Waitlist'
	END status
FROM row_num
ORDER BY passenger_id;
