



         -- Approach 1. Using - GROUP BY and - FILTER -- 
SELECT question_id survey_log 
FROM surveylog
GROUP BY question_id
ORDER BY 
    COUNT(*) FILTER(WHERE answer_id IS NOT NULL)::numeric
    / COUNT(*) DESC
LIMIT 1;


         -- Approach 2. Using - CASE...WHEN - within - AVG -- 
SELECT question_id survey_log
FROM surveylog
GROUP BY question_id
ORDER BY AVG(CASE WHEN answer_id IS NOT NULL THEN 1 ELSE 0 END) DESC
LIMIT 1;




