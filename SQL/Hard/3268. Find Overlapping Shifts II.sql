


         -- Approach 1. Using two - CTE -- 
WITH 
	delta AS (
    SELECT employee_id, start_time AS shift_t, 1 AS d FROM employeeshifts
    UNION ALL
    SELECT employee_id, end_time AS shift_t, -1 AS d FROM employeeshifts
  ),
	grps AS (
    SELECT employee_id, shift_t,
        SUM(d) OVER (PARTITION BY employee_id ORDER BY shift_t, d DESC) overlapping_shifts,
        LEAD(shift_t) OVER (PARTITION BY employee_id ORDER BY shift_t, d DESC) next_shift
    FROM delta
)
SELECT 
  employee_id,
  MAX(overlapping_shifts) max_overlapping_shifts,
  SUM(
    CASE 
        WHEN overlapping_shifts > 1 AND next_shift > shift_t 
        THEN EXTRACT(EPOCH FROM (next_shift - shift_t)) / 60 
        ELSE 0 
    END
  ) total_overlap_duration
FROM grps
WHERE next_shift IS NOT NULL
GROUP BY employee_id
ORDER BY employee_id;
