

         -- Approach 1. Using - CTE and - LEFT JOIN -- 
WITH inst_date AS (
  SELECT player_id, 
    MIN(event_date) install_dt
  FROM activity 
  GROUP BY player_id 
)
SELECT i.install_dt, 
  COUNT(i.player_id) installs, 
  ROUND(COUNT(a.event_date) * 1.0 / COUNT(i.player_id), 2) Day1_retention
FROM inst_date i  
LEFT JOIN activity a ON a.player_id = i.player_id AND a.event_date = i.install_dt + 1
GROUP BY i.install_dt;
