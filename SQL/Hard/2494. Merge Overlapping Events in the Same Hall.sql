


         -- Approach 1. Using multiple - CTE -- 
WITH 
	ordered_events AS (
    SELECT *, 
        ROW_NUMBER() OVER(PARTITION BY hall_id ORDER BY start_day) rn 
    FROM hallevents 
	), 
  flags AS (
    SELECT *, 
        CASE  
            WHEN start_day <= COALESCE(LAG(end_day) OVER(PARTITION BY hall_id ORDER BY start_day), start_day)
            THEN 0 
            ELSE 1 
        END is_new_group
	  FROM ordered_events
	),
  grps AS (
    SELECT *, 
      	 SUM(is_new_group) OVER(PARTITION BY hall_id ORDER BY start_day) grp_id
    FROM flags
)
SELECT hall_id, 
	MIN(start_day) start_day, 
  MAX(end_day) end_day
FROM grps
GROUP BY hall_id, grp_id;
