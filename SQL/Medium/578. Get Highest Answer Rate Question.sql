



         -- Approach 1. Using - GROUP BY and - FILTER -- 
SELECT question_id, 
    COUNT(*) FILTER(WHERE answer_id IS NOT NULL)::numeric
      / COUNT(*) AS answer_rate
FROM survey_log
GROUP BY question_id
ORDER BY answer_rate DESC
LIMIT 1;



         -- Approach 2. Using - GROUP BY with - HAVING -- 
SELECT question_id, 
    COUNT(*) FILTER(WHERE answer_id IS NOT NULL)::numeric
      / COUNT(*) AS answer_rate
FROM survey_log
GROUP BY question_id
ORDER BY answer_rate DESC
LIMIT 1;



         -- Approach 3. Using - CASE...WHEN - within - SUM -- 
SELECT question_id, 
    (SUM(CASE WHEN answer_id IS NOT NULL THEN 1 ELSE 0 END)::numeric 
      / COUNT(*)) AS answer_rate
FROM survey_log
GROUP BY question_id
ORDER BY answer_rate DESC
LIMIT 1;



         -- Approach 4. Using - CASE...WHEN - within - AVG -- 
SELECT question_id,
       AVG(CASE WHEN answer_id IS NOT NULL THEN 1 ELSE 0 END) AS answer_rate
FROM survey_log
GROUP BY question_id
ORDER BY answer_rate DESC
LIMIT 1;




