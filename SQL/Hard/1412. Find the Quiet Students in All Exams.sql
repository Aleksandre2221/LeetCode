


         -- Approach 1. Using - 
WITH 
	max_min AS (
      SELECT exam_id,
        	MAX(score) AS max_score,
  		    MIN(score) AS min_score
      FROM exam
      GROUP BY exam_id
  	),
  	invalid_students AS (
      SELECT DISTINCT e.student_id
      FROM exam e
      JOIN max_min mm ON e.exam_id = mm.exam_id
      	AND (e.score = mm.max_score OR e.score = mm.min_score)
)
SELECT s.student_id, s.student_name
FROM student s
WHERE EXISTS (
    SELECT 1
    FROM exam e
    WHERE e.student_id = s.student_id
)
AND NOT EXISTS (
    SELECT 1
    FROM invalid_students i
    WHERE i.student_id = s.student_id
);
