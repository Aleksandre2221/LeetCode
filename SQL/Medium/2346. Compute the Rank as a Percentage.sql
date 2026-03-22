

         -- Approach 1. The Shortest Solution -- 
SELECT student_id, department_id,
    COALESCE(
        ROUND(
            	(RANK() OVER (PARTITION BY department_id ORDER BY mark DESC) - 1) * 100.0 
                  / NULLIF((COUNT(*) OVER (PARTITION BY department_id) - 1), 0)
            , 2)
        , 0) percentage
FROM students;




