

-- Risolved: 3 times


         -- Approach 1. Using - CTE with - FIRST_VALUE() and - LAST_VALUE() -- 
-- Write your PostgreSQL query statement below
WITH grps AS(
    SELECT DISTINCT student_id, subject, 
    FIRST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date) first_score,
    LAST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) latest_score,
    COUNT(student_id) OVER(PARTITION BY student_id, subject) exam_cnt
    FROM Scores
)
SELECT student_id, subject, first_score, latest_score
FROM grps
WHERE latest_score > first_value AND  exam_cnt > 1
ORDER BY student_id, subject;

         

         -- Approach 2. Using - FILTER (Only Postgres) -- 
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



         -- Approach 3. Using - CTE with Window Functions --
WITH first_last_date AS (
  SELECT *,
    MIN(exam_date) OVER(PARTITION BY student_id, subject) fd,
    MAX(exam_date) OVER(PARTITION BY student_id, subject) ld
  FROM scores
)
SELECT student_id, subject, 
    MAX(CASE WHEN exam_date = fd THEN score END) first_score,
    MIN(CASE WHEN exam_date = ld THEN score END) latest_score
FROM first_last_date 
GROUP BY student_id, subject
HAVING MAX(CASE WHEN exam_date = ld THEN score END) - MAX(CASE WHEN exam_date = fd THEN score END) > 0



