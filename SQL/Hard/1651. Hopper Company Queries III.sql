


         -- Approach 1. Using - Recursive CTE -- 
WITH RECURSIVE months AS (
  SELECT '2020-01-01'::date as "month" 
  UNION ALL  
  SELECT ("month" + INTERVAL '1 month')::date 
  FROM months  
  WHERE "month" + INTERVAL '1 month' <= '2020-10-01'::date
) 
SELECT m.month,
    ROUND(COALESCE(SUM(a.ride_distance), 0) / 3, 2) average_ride_distance,
    ROUND(COALESCE(SUM(a.ride_duration), 0) / 3, 2) average_ride_duration
FROM months m
LEFT JOIN rides r
    ON EXTRACT(YEAR FROM r.requested_at) = 2020
    AND EXTRACT(MONTH FROM r.requested_at) BETWEEN EXTRACT(MONTH FROM m.month) AND EXTRACT(MONTH FROM m.month) + 2
LEFT JOIN acceptedrides a 
    ON a.ride_id = r.ride_id
GROUP BY m.month
ORDER BY m.month;
