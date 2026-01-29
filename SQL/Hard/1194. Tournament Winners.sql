


         -- Approach 1. Using two - CTE -- 
WITH 
	union_all AS (
      SELECT first_player AS player_id, first_score AS score FROM matches
      UNION ALL 
      SELECT second_player, second_score FROM matches
	),
    ranking AS (
    SELECT p.group_id, p.player_id,  
      	ROW_NUMBER() OVER(PARTITION BY p.group_id ORDER BY SUM(ua.score) DESC, p.player_id) rnk
    FROM union_all ua 
    JOIN players p USING (player_id)
    GROUP BY p.group_id, p.player_id
)
SELECT group_id, player_id 
FROM ranking  
WHERE rnk = 1;
