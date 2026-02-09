


         -- Approach 1. Using - RECURSIVE CTE -- 
WITH RECURSIVE all_sub_ids AS (
	SELECT task_id, 1 AS subtask_id, subtasks_count  
    FROM tasks 
  	UNION ALL 
    SELECT task_id, subtask_id + 1, subtasks_count 
  	FROM all_sub_ids 
  	WHERE subtask_id + 1 <= subtasks_count
)
SELECT task_id, subtask_id  
FROM all_sub_ids asi
WHERE NOT EXISTS (
  SELECT 1 
  FROM executed e  
  WHERE e.task_id = asi.task_id
    AND e.subtask_id = asi.subtask_id
);
