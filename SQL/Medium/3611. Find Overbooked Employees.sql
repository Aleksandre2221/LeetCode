

-- Risolved: 2 times


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



          -- Approach 2. Using - CTE with - TO_CHAR -- 
WITH valid_empl AS (
  SELECT e.employee_id, e.employee_name, e.department, 
      TO_CHAR(m.meeting_date, 'IW')
  FROM meetings m
  JOIN employees e USING (employee_id)
  GROUP BY e.employee_id, e.employee_name, e.department, TO_CHAR(m.meeting_date, 'IW') 
  HAVING SUM(m.duration_hours) > 20.0 
)
SELECT employee_id, employee_name, department, 
   COUNT(*) meeting_heavy_weeks  
FROM valid_empl 
GROUP BY employee_id, employee_name, department 
HAVING COUNT(*) >= 2
ORDER BY meeting_heavy_weeks DESC, employee_name;


