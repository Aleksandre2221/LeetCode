


         -- Approach 1. Using two - CTE -- 
WITH calculations AS (
    SELECT 
        t1.team_name pass_from, 
        t2.team_name pass_to, 
        time_stamp, 
        CASE 
            WHEN t1.team_name = t2.team_name 
            THEN 1 
            ELSE -1
        END dominance, 
        CASE  
			WHEN time_stamp = '45:00' 
          		OR LEFT(time_stamp, 2)::int < 45 
            THEN 1 
            ELSE 2 
        END half_number
    FROM passes p 
    JOIN teams t1 ON t1.player_id = p.pass_from
    JOIN teams t2 ON t2.player_id = p.pass_to
)
SELECT 
	pass_from team_name, 
    half_number, 
    SUM(dominance) dominance
FROM calculations  
GROUP BY pass_from, half_number
ORDER BY team_name, half_number;
