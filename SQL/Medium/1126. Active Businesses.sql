


         -- Approach 1. Using - CTE with - GROUP BY and - AVG -- 
WITH events_avg AS (
    SELECT *, 
        AVG(occurrences) OVER(PARTITION BY event_type) eve_avg
    FROM events 
)
SELECT business_id 
FROM events_avg 
WHERE occurrences > eve_avg
GROUP BY business_id
HAVING COUNT(*) > 1;




