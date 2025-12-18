
-- Risolved: 2 times


         -- Approach 1. Using - FILTER (Only Postgres) -- 
WITH first_last AS (
  SELECT student_id, subject,
    MIN(exam_date) first_date,
    MAX(exam_date) last_date
  FROM scores
  GROUP BY student_id, subject
)
SELECT s.student_id, s.subject,
  MAX(s.score) FILTER (WHERE s.exam_date = fl.first_date) first_score,
  MAX(s.score) FILTER (WHERE s.exam_date = fl.last_date) latest_score
FROM scores s
JOIN first_last fl USING(student_id, subject)
GROUP BY s.student_id, s.subject
HAVING MAX(s.score) FILTER (WHERE s.exam_date = fl.last_date) 
        > MAX(s.score) FILTER (WHERE s.exam_date = fl.first_date);



         -- Approach 2. Withou - FILTER using multiple - CTE -- 
WITH 
  firs_last_date AS (
    SELECT student_id, subject, 
      Min(exam_date) first_date, 
      MAX(exam_date) last_date
    FROM scores 
    GROUP BY student_id, subject
  ),
  first_last_score AS (
    SELECT s.student_id, s.subject, 
      CASE WHEN s.exam_date = fld.first_date THEN score END first_score,
      CASE WHEN s.exam_date = fld.last_date THEN score END latest_score
    FROM scores s 
    JOIN firs_last_date fld ON s.student_id = fld.student_id AND s.subject = fld.subject
    WHERE s.exam_date = fld.first_date OR s.exam_date = fld.last_date 
)
SELECT student_id, subject, 
  MAX(first_score) first_score, 
  MAX(latest_score) latest_score
FROM first_last_score
GROUP BY student_id, subject
HAVING MAX(latest_score) > MAX(first_score)


