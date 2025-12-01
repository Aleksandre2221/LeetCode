

         -- Approach 1. Using - CTE / UNION ALL / LEFT JOIN -- 
WITH 
	points AS (
      SELECT host_team team_id,
          CASE 
              WHEN host_goals > guest_goals THEN 3 
              WHEN host_goals = guest_goals THEN 1
              ELSE 0 
          END pts
      FROM matches
      
    UNION ALL
      
      SELECT guest_team team_id,
          CASE 
              WHEN host_goals < guest_goals THEN 3 
              WHEN host_goals = guest_goals THEN 1
              ELSE 0 
          END pts
	  FROM matches
)
SELECT t.team_id, t.team_name, SUM(COALESCE(pts, 0)) points_num 
FROM teams t 
LEFT JOIN points p ON p.team_id = t.team_id
GROUP BY t.team_id, t.team_name
ORDER BY points_num DESC, team_id;




           -- Approach 2. Using - IN condition within - LEFT JOIN and - SUM with multiple - CASE...WHEN conditions -- 
SELECT t.team_id, t.team_name,
       SUM(
           CASE 
               WHEN t.team_id = m.host_team AND m.host_goals > m.guest_goals THEN 3
               WHEN t.team_id = m.host_team AND m.host_goals = m.guest_goals THEN 1
               WHEN t.team_id = m.guest_team AND m.guest_goals > m.host_goals THEN 3
               WHEN t.team_id = m.guest_team AND m.guest_goals = m.host_goals THEN 1
               ELSE 0
           END
       ) points_num
FROM teams t
LEFT JOIN matches m ON t.team_id IN (m.host_team, m.guest_team)
GROUP BY t.team_id, t.team_name
ORDER BY points_num DESC, t.team_id;











