

-- Risolved: 2 times 


         -- Approach 1. Using - CTE with - UNION ALL -- (MySQL / PostgreSQL)
WITH unpivot AS (
  SELECT year, wimbledon player_id FROM championships
  UNION ALL 
  SELECT YEAR, fr_open FROM championships
  UNION ALL 
  SELECT year, us_open FROM championships 
  UNION ALL 
  SELECT year, au_open FROM championships
) 
SELECT p.player_id, p.player_name, COUNT(*) grand_slams_count 
FROM unpivot u 
JOIN players p ON p.player_id = u.player_id
GROUP BY p.player_id, p.player_name;




         -- Approach 2. Using - CROSS APPLY -- (SQL Server / Oracle)
SELECT p.player_id, p.player_name, COUNT(*) grand_slams_count
FROM championships c
CROSS APPLY (
  VALUES (c.wimbledon), (c.fr_open), (c.us_open), (c.au_open)
) v(player_id)
JOIN players p ON p.player_id = v.player_id
GROUP BY p.player_id, p.player_name;




         -- Approach 3. Using - CTE with - UNPIVOT -- (SQL Server / Oracle)
WITH all_wins AS (
  SELECT year, player_id
  FROM championships
  UNPIVOT (player_id FOR tournament IN (wimbledon, fr_open, us_open, au_open)) u
)
SELECT p.player_id, p.player_name, COUNT(*) grand_slams_count
FROM all_wins w
JOIN players p ON p.player_id = w.player_id
GROUP BY p.player_id, p.player_name;








