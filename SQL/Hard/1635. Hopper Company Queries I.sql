


         -- Approach 1. Using multiple - CTE -- 
WITH RECURSIVE 
	valid_dates AS (
      SELECT '2020-01-01'::date AS "date"  
      UNION ALL  
      SELECT ("date" + INTERVAL '1 month')::date 
      FROM valid_dates  
      WHERE "date" + INTERVAL '1 month' <= '2020-12-31'::date
	), 
  active_drivers AS (
      SELECT vd.date, 
      	  COUNT(d.driver_id) active_drivers
      FROM valid_dates vd 
      LEFT JOIN drivers d ON d.join_date < (vd.date + INTERVAL '1 month')
      GROUP BY vd.date
  ),
  accepted_rides AS (
      SELECT DATE_TRUNC('month', r.requested_at) "date", 
      	  COUNT(ar.ride_id) accepted_rides 
      FROM rides r
      JOIN acceptedrides ar ON ar.ride_id = r.ride_id
      WHERE r.requested_at BETWEEN '2020-01-01'::date AND '2020-12-31'::date
      GROUP BY DATE_TRUNC('month', r.requested_at)
)
SELECT 
	  EXTRACT(MONTH FROM vd.date) "month", 
    COALESCE(ad.active_drivers, 0) active_drivers,
    COALESCE(ar.accepted_rides, 0) accepted_rides
FROM valid_dates vd 
LEFT JOIN active_drivers ad USING(date)
LEFT JOIN accepted_rides ar USING(date)
ORDER BY month;
