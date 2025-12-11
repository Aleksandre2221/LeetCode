

         -- Approach 1. Using - CTE with - DATE_TRUNC -- 
WITH hours_cnt AS (
  SELECT e.employee_id, e.employee_name, e.department, 
      DATE_TRUNC('week', meeting_date) week,
      SUM(m.duration_hours) total_hours
  FROM meetings m 
  JOIN employees e ON e.employee_id = m.employee_id
  GROUP BY e.employee_id, e.employee_name, e.department, DATE_TRUNC('week', meeting_date)
  HAVING SUM(m.duration_hours) > 20 
)
SELECT employee_id, employee_name, department,
  COUNT(week) meeting_heavy_weeks 
FROM hours_cnt
GROUP BY employee_id, employee_name, department
HAVING COUNT(week) > 1 
ORDER BY meeting_heavy_weeks DESC, employee_name;
