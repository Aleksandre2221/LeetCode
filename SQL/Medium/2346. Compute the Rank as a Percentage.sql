

         -- Approach 1. The Shortest Solution -- 
SELECT student_id, department_id,
    COALESCE(
        ROUND(
            	(RANK() OVER (PARTITION BY department_id ORDER BY mark DESC) - 1) * 100 
                  / (COUNT(*) OVER (PARTITION BY department_id) - 1)
            , 2
        ), 0
    ) percentage
FROM students;



        -- Approach 2. Using - CTE with Window Functions -- (more datailed) -- 
WITH ranking AS (
  SELECT *, 
      DENSE_RANK() OVER(PARTITION BY department_id ORDER BY mark DESC) rnk, 
      COUNT(*) OVER(PARTITION BY department_id) cnt  
  FROM students
) 
SELECT student_id, department_id, 
   MAX(ROUND((rnk - 1) * 100.0 / (cnt - 1), 2)) percentage
FROM ranking 
GROUP BY student_id, department_id;



