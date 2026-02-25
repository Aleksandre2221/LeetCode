


         -- Approach 1. Using two - CTE -- 
WITH 
	from_to AS (
      SELECT 
          t1.team_name from_team, 
          t2.team_name to_team, 
          p.time_stamp
      FROM passes p 
      JOIN teams t1 ON p.pass_from = t1.player_id 
      JOIN teams t2 ON p.pass_to = t2.player_id
	), 
  calculations AS (
      SELECT *, 
        	CASE  
          		WHEN time_stamp = '45:00' 
          			OR LEFT(time_stamp, 2)::int < 45 
          		THEN 1 
          		ELSE 2 
        	END half_number, 
      	  CASE  
          		WHEN from_team = to_team 
          		THEN 1 
          		ELSE -1 
      	  END passes 
      FROM from_to 
)
SELECT 
	  from_team team_name, 
    half_number, 
    SUM(passes) dominance
FROM calculations 
GROUP BY from_team, half_number 
ORDER BY team_name, half_number;
