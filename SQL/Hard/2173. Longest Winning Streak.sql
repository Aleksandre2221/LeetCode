


           -- Approach 1. Using multiple - CTE -- 
WITH 
  seq AS (
    SELECT *, 
	  ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY match_day) match_seq, 
      ROW_NUMBER() OVER(PARTITION BY player_id, result ORDER BY match_day) result_seq
    FROM matches
  ),
  diff AS (
    SELECT *, match_seq - result_seq diff
    FROM seq
    WHERE result = 'Win'
  ), 
  grps AS (
    SELECT player_id, COUNT(player_id) cons_cnt
    FROM diff 
    GROUP BY player_id, diff
)
SELECT m.player_id, 
	COALESCE(MAX(g.cons_cnt), 0) longest_streak 
FROM matches m 
LEFT JOIN grps g USING (player_id) 
GROUP BY m.player_id;
