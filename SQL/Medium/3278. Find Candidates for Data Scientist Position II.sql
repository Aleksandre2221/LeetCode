

-- Risolved: 4 times


         -- Approach 1. Using three - CTE -- 
WITH 
  candidate_skills AS (
    SELECT p.project_id, c.candidate_id, 
        COUNT(*) skills_cnt,
        SUM(
          CASE 
            WHEN p.importance > c.proficiency THEN -5 
            WHEN p.importance < c.proficiency THEN 10
          END) + 100 score
    FROM projects p 
    JOIN candidates c ON c.skill = p.skill
    GROUP BY p.project_id, c.candidate_id
  ),
  project_skills AS (
    SELECT project_id, COUNT(*) skills_cnt  
    FROM projects
    GROUP BY project_id
  ), 
  matched_skills AS (
    SELECT cs.project_id, cs.candidate_id, cs.score, 
      RANK() OVER(PARTITION BY cs.project_id ORDER BY cs.score DESC, cs.candidate_id) rnk
    FROM candidate_skills cs 
    JOIN project_skills ps ON cs.project_id = ps.project_id 
    WHERE cs.skills_cnt = ps.skills_cnt
)
SELECT project_id, candidate_id, score   
FROM matched_skills  
WHERE rnk = 1
ORDER BY project_id;


         
          -- Approach 2. Using two - CTE -- 
WITH 
   t1 AS (
     SELECT p.project_id, c.candidate_id, 
        COUNT(*) matched_skills, 
        SUM(CASE 
               WHEN c.proficiency > p.importance THEN 10 
               WHEN c.proficiency < p.importance THEN -5 
            END) + 100 score,
        RANK() OVER(
                    PARTITION BY p.project_id 
                    ORDER BY SUM(CASE 
                                 	WHEN c.proficiency > p.importance THEN 10 
                                 	WHEN  c.proficiency < p.importance THEN -5 
                                  END) DESC, c.candidate_id) rnk
     FROM projects p 
     JOIN candidates c ON c.skill = p.skill
     GROUP BY p.project_id, c.candidate_id
    ), 
    t2 AS (
     SELECT project_id, COUNT(*) req_skills 
     FROM projects 
     GROUP BY project_id
)
SELECT t1.project_id, t1.candidate_id, t1.score 
FROM t1 
JOIN t2 USING (project_id)
WHERE t1.matched_skills >= t2.req_skills  AND t1.rnk = 1
ORDER BY project_id;










