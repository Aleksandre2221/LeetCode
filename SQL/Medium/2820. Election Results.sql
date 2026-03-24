


         -- Approach 1. Using two - CTE -- 
WITH 
	voter_score AS (
      SELECT voter, 
        1.0 / COUNT(*) score  
      FROM votes 
      GROUP BY voter 
    ),
    ranking AS (
      SELECT v.candidate, 
          RANK() OVER(ORDER BY SUM(vs.score) DESC) rnk
      FROM votes v  
      JOIN voter_score vs USING (voter)
      GROUP BY v.candidate
)
SELECT candidate 
FROM ranking  
WHERE rnk = 1
ORDER BY candidate;
