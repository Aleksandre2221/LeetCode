


         -- Approach 1. Using two - CTE -- 
WITH 
	overlap_duration AS (
      SELECT e1.employee_id, e1.start_time,
          EXTRACT(EPOCH FROM (e1.end_time - e2.start_time)) / 60 overlap_duration 
      FROM employeeshifts e1
      LEFT JOIN employeeShifts e2
          ON (e1.employee_id = e2.employee_id) 
          AND (e1.start_time < e2.start_time)
          AND (e1.end_time BETWEEN e2.start_time AND e2.end_time)
  	), 
    overlap_cnt AS (
      SELECT 
          employee_id, 
          COUNT(overlap_duration) + 1 overlap_cnt, 
          COALESCE(SUM(overlap_duration), 0) total_overlap
      FROM overlap_duration
      GROUP BY employee_id, start_time
)
SELECT 
	employee_id, 
    MAX(overlap_cnt) max_overlapping_shifts, 
    SUM(total_overlap) total_overlap_duration
FROM overlap_cnt
GROUP BY employee_id
ORDER BY employee_id;
