

         -- Approach 1. Using - Self-Join with multiple conditions -- 
SELECT e1.employee_id, COUNT(*) overlapping_shifts
FROM employeeshifts e1 
JOIN employeeshifts e2 
  ON e1.employee_id = e2.employee_id 
  AND e1.start_time > e2.start_time 
  AND e1.start_time < e2.end_time
GROUP BY e1.employee_id;
