

         -- Approach 1. The Shortest Solution -- 
SELECT student_id, department_id,
    COALESCE(
        ROUND(
            	(rank() OVER (PARTITION BY department_id ORDER BY mark DESC) - 1) * 100 
                  / (count(*) OVER (PARTITION BY department_id) - 1)
            , 1
        ), 0
    ) percentage
FROM students;



        -- Approach 2. Using two - CTE (more datiled) -- 
WITH 
  student_cnt AS (
    SELECT department_id, COUNT(*) cnt
    FROM students 
    GROUP BY department_id
  ), 
  ranking AS (
    SELECT *, RANK() OVER(PARTITION BY department_id ORDER BY mark DESC) rnk
    FROM students 
) 
SELECT r.student_id, r.department_id, 
  ROUND((r.rnk - 1) * 100 / (sc.cnt - 1), 1) percentage 
FROM ranking r
JOIN student_cnt sc ON sc.department_id = r.department_id;



