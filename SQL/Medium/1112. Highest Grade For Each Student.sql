

         -- Approach 1. Using - CTE with - RANK() --  
WITH ranking AS (
    SELECT *, 
        RANK() OVER(PARTITION BY student_id ORDER BY grade DESC, course_id) rnk
    FROM enrollments 
)
SELECT student_id, course_id, grade 
FROM ranking 
WHERE rnk = 1
ORDER BY student_id;




