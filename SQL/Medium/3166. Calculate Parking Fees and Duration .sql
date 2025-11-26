

         -- Approach 1. Using - CTE with a Window Function - RANK() -- 
WITH hours_info AS (
  SELECT *, 
    ROUND(EXTRACT(EPOCH FROM exit_time - entry_time) / 3600.0, 2) parking_time,  
    RANK() OVER(PARTITION BY car_id ORDER BY exit_time - entry_time DESC) rnk
  FROM parkingtransactions
)
SELECT car_id, 
  ROUND(SUM(fee_paid), 2) total_fee_paid,
  ROUND(SUM(fee_paid) / SUM(parking_time), 2) avg_hourly_fee,
  MAX(CASE WHEN rnk = 1 THEN lot_id END) most_time_lot
FROM hours_info
GROUP BY car_id;
