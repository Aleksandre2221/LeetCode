

         -- Approach 1. Using - CTE with Window Functions - ROW_NUMBER() -- 
WITH ranking AS (
  SELECT t.team_id, t.name,
      ROW_NUMBER() OVER(ORDER BY t.points DESC) rn1,
      ROW_NUMBER() OVER(ORDER BY t.points + p.points_change DESC) rn2 
  FROM teampoints t  
  JOIN pointschange p ON t.team_id = p.team_id
)
SELECT team_id, name, 
  rn2 - rn1 rank_diff   
FROM ranking; 


         -- Approach 2. in one query -- 
SELECT 
    tp.team_id,
    tp.name, 
    (ROW_NUMBER() OVER(ORDER BY points DESC, tp.name) 
     - ROW_NUMBER() OVER(ORDER BY (tp.points + pc.points_change) DESC, tp.name)) rank_diff
FROM teampoints tp 
JOIN pointschange pc USING (team_id);
