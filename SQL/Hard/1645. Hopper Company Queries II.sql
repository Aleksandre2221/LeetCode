


         -- Approch 1. Using multiple - CTE -- 
WITH RECURSIVE  
	months AS (
      SELECT '2020-01-01'::date AS month  
      UNION ALL  
      SELECT (month + INTERVAL '1 month')::date 
      FROM months  
      WHERE month + INTERVAL '1 month' <= '2020-12-01'::date
	), 
  available_dr AS (
    SELECT 
        DATE_TRUNC('month', m.month) "month", 
      	COUNT(*) av_dr
    FROM months m 
    LEFT JOIN drivers d ON DATE_TRUNC('month', m.month) >= DATE_TRUNC('month', d.join_date)
    GROUP BY DATE_TRUNC('month', m.month)
	), 
  accepted_rides AS (
    SELECT 
        DATE_TRUNC('month', m.month) "month", 
      	COUNT(ar.ride_id) ac_r
    FROM months m 
    LEFT JOIN rides r ON DATE_TRUNC('month', m.month) = DATE_TRUNC('month', r.requested_at)
    LEFT JOIN acceptedrides ar ON ar.ride_id = r.ride_id
    GROUP BY DATE_TRUNC('month', m.month)
) 
SELECT EXTRACT(MONTH FROM ad.month) "month", 
	ROUND(ar.ac_r * 100.0 / ad.av_dr, 2) working_percentage 
FROM available_dr ad 
JOIN accepted_rides ar ON ad.month = ar.month
ORDER BY month;
