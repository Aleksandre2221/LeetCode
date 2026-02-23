


         -- Approach 1. Using multiple - CTE -- 
WITH 
	mand_coureses AS (
      SELECT s.student_id
      FROM students s  
      JOIN courses c ON s.major = c.major AND c.mandatory = 'yes'
      LEFT JOIN enrollments e ON e.student_id = s.student_id AND e.course_id = c.course_id
      GROUP BY s.student_id
      HAVING COUNT(c.course_id) = COUNT(e.course_id)
      	AND SUM(CASE WHEN e.grade = 'A' THEN 1 END) = COUNT(e.course_id)
	), 
    elect_courses AS (
	  SELECT s.student_id
      FROM students s  
      JOIN courses c ON s.major = c.major AND c.mandatory = 'no'
      LEFT JOIN enrollments e ON e.student_id = s.student_id AND e.course_id = c.course_id
      GROUP BY s.student_id 
      HAVING COUNT(e.course_id) >= 2
        AND SUM(CASE WHEN e.grade IN ('A', 'B') THEN 1 END) = COUNT(e.course_id)
	),
    global_gpa AS (
      SELECT student_id 
      FROM enrollments 
      GROUP BY student_id 
      HAVING AVG(gpa) >= 2.5 
)     
SELECT mc.student_id
FROM mand_coureses mc  
JOIN elect_courses ec USING (student_id)
JOIN global_gpa gg USING (student_id)
ORDER BY mc.student_id;
