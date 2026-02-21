


         -- Approach 1. Using two - CTE -- 
WITH 
	all_events AS (
    SELECT employee_id, start_time AS task_time, 1 AS delta FROM tasks 
    UNION ALL 
    SELECT employee_id, end_time AS task_time, -1 AS delta FROM tasks 
	), 
  cumulative AS (
    SELECT employee_id, task_time,
        SUM(delta) OVER(PARTITION BY employee_id ORDER BY task_time) active_tasks,
      	LEAD(task_time) OVER(PARTITION BY employee_id ORDER BY task_time) next_time 
    FROM all_events
)
SELECT employee_id, 
	  FLOOR(SUM(EXTRACT(EPOCH FROM (next_time - task_time))) / 3600) total_task_hours, 
	  MAX(active_tasks) max_concurrent_tasks 
FROM cumulative
WHERE next_time IS NOT NULL 
	AND active_tasks > 0
GROUP BY employee_id
ORDER BY employee_id;
