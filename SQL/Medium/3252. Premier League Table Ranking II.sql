

         -- Approach 1. Using - CTE -- 
WITH team_pts AS (
    SELECT 
        team_name, 
        (wins*3 + draws) points, 
        RANK() OVER(ORDER BY (wins*3 + draws) DESC) position 
    FROM teamstats 
)
SELECT team_name, points, position,  
    CASE  
        WHEN position < (0.33 * (SELECT MAX(position) FROM team_pts) + 1) THEN 'Tier 1'
        WHEN position < (0.66 * (SELECT MAX(position) FROM team_pts) + 1) THEN 'Tier 2'
        ELSE 'Tier 3'
    END tier 
FROM team_pts 
ORDER BY points DESC, team_name;
