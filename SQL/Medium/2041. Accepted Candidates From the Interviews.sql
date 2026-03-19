

         -- Approach 1. Using - HAVING -- 
SELECT c.candidate_id 
FROM candidates c 
JOIN rounds r USING (interview_id)
GROUP BY c.candidate_id
HAVING MAX(c.years_of_exp) >= 2
    AND SUM(r.score) > 15;
