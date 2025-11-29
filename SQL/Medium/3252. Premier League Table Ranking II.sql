

         -- Approach 1. Using - CTE with Window Functions - RANK() and NTILE() -- 
WITH team_info AS (
  SELECT team_id, team_name, 
      wins * 3 + draws points,
      RANK() OVER(ORDER BY wins * 3 + draws DESC) position, 
      NTILE(3) OVER (ORDER BY wins * 3 + draws DESC) AS grp
  FROM teamstats 
)
SELECT *, 
    CASE  
      WHEN grp = 1 THEN 'Top' 
      WHEN grp = 2 THEN 'Middle' 
      ELSE 'Bottom' 
    END tier
FROM team_info 
ORDER BY points DESC;
