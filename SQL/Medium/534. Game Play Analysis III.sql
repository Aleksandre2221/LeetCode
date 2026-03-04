

      -- Approach 1. Using Window Function - SUM -- 
SELECT player_id, event_date, 
	SUM(games_played) OVER(PARTITION BY player_id ORDER BY event_date) games_played_so_far
FROM activity


      -- Approach 2. Using - Self-Join -- 
SELECT a1.player_id, a1.event_date, SUM(a2.games_played) games_played_so_far
FROM activity a1
JOIN activity a2 
	ON a1.player_id = a2.player_id AND a1.event_date >= a2.event_date
GROUP BY a1.player_id, a1.event_date
