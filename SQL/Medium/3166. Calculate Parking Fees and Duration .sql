

         -- Approach 1. Using - CTE with a Window Function - RANK() -- 
WITH 
    calc AS (
      SELECT car_id, 
          SUM(fee_paid) total_fee_paid, 
          ROUND(
              SUM(fee_paid) / (EXTRACT(EPOCH FROM SUM(exit_time - entry_time)) / 3600)
          , 2) avg_hourly_fee 
      FROM parkingtransactions 
      GROUP BY car_id
    ), 
    slot_time AS (
      SELECT car_id, lot_id,
      	 RANK() OVER(PARTITION BY car_id ORDER BY SUM(exit_time - entry_time) DESC) rnk
      FROM parkingtransactions 
      GROUP BY car_id, lot_id
)
SELECT c.car_id, c.total_fee_paid, c.avg_hourly_fee, st.lot_id most_time_lot   
FROM calc c 
JOIN slot_time st USING (car_id) 
WHERE st.rnk = 1
ORDER BY car_id; 
