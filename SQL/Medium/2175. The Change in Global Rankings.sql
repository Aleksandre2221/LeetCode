

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
