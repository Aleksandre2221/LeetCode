

         -- Approach 1. Using - JOIN / LEFT JOI / HAVING -- 
SELECT s.student_id
FROM students s
JOIN courses c ON s.major = c.major
LEFT JOIN enrollments e ON e.student_id = s.student_id
     AND e.course_id = c.course_id
GROUP BY s.student_id
HAVING SUM(CASE WHEN e.grade = 'A' THEN 1 ELSE 0 END) = COUNT(c.major);
