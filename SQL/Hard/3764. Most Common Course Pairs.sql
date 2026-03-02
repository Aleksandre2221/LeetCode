


         -- Approach 1. Using two - CTE -- 
WITH 
	valid_users AS (
    SELECT user_id
    FROM course_completions 
    GROUP BY user_id 
    HAVING COUNT(course_id) >= 5 
      AND AVG(course_rating) >= 4
	),
  all_courses AS (
    SELECT user_id, 
      course_name first_course, 
      LEAD(course_name) OVER(PARTITION BY user_id ORDER BY completion_date) second_course 
    FROM course_completions 
)
SELECT first_course, second_course,
	COUNT(*) transition_count
FROM all_courses 
WHERE second_course IS NOT NULL
	AND user_id IN (SELECT user_id FROM valid_users)
GROUP BY first_course, second_course
ORDER BY transition_count DESC, LOWER(first_course), LOWER(second_course);
