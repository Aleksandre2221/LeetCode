


         -- Approach 1. Using two - CTE with - UNION ALL and - FIRST_VALUE() -- 
WITH 
	bidir AS (
      SELECT caller_id, recipient_id, call_time FROM calls 
      UNION ALL  
      SELECT recipient_id, caller_id, call_time FROM calls 
    ), 
    first_last AS (
      SELECT caller_id user_id, 
      	 FIRST_VALUE(recipient_id) OVER(PARTITION BY call_time::date, caller_id ORDER BY call_time) f,
      	 FIRST_VALUE(recipient_id) OVER(PARTITION BY call_time::date, caller_id ORDER BY call_time DESC) l 
	  FROM bidir
)SELECT * FROM first_last
SELECT DISTINCT user_id 
FROM first_last  
WHERE f = l;
