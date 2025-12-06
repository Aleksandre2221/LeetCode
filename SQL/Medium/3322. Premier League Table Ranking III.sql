

         -- Approach 1. Using - GROUP BY and a Window Function - ROW_NUMBER() -- 
SELECT season_id, team_name, 
    SUM(goals_for - goals_against) goal_differce, 
    SUM(wins * 3 + draws) points,
    ROW_NUMBER() OVER(
      		PARTITION BY season_id 
      		ORDER BY SUM(wins * 3 + draws) DESC, MAX(goals_for - goals_against) DESC, team_name) position
FROM seasonstats 
GROUP BY season_id, team_name
ORDER BY season_id, position, team_name;
