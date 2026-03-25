

-- Risolved: 4 times


         -- Approach 1. Using - CTE -- 
WITH ranking AS (
    SELECT p.project_id, c.candidate_id,
        SUM(
            CASE  
                WHEN p.importance < c.proficiency THEN 10 
                WHEN p.importance > c.proficiency THEN -5
                ELSE 0 
            END
        ) + 100 score, 
        RANK() OVER(
                  PARTITION BY p.project_id 
                  ORDER BY 	
                      SUM(
                          CASE  
                              WHEN p.importance < c.proficiency THEN 10 
                              WHEN p.importance > c.proficiency THEN -5
                              ELSE 0 
                          END) + 100 DESC
                       , c.candidate_id
        	         ) rnk
    FROM projects p 
    LEFT JOIN candidates c ON p.skill = c.skill
    GROUP BY p.project_id, c.candidate_id
    HAVING COUNT(DISTINCT p.skill) = (
         SELECT COUNT(DISTINCT skill)
         FROM projects p2
         WHERE p2.project_id = p.project_id)
)
SELECT project_id, candidate_id, score 
FROM ranking  
WHERE rnk = 1
ORDER BY project_id;










