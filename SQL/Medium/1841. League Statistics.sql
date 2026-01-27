

-- Risolved: 3 times


         -- Approach 1. Using - UNION ALL -- 
WITH all_matches AS (
	SELECT 
		home_team_id AS team_id, 
		home_team_goals AS goals_for, 
		away_team_goals AS goals_against 
	FROM matches
	UNION ALL  
	SELECT away_team_id, away_team_goals, home_team_goals FROM matches
)
SELECT t.team_name, 
	COUNT(am.team_id) matches_played,
    SUM(     
      	CASE  
      		WHEN am.goals_for > am.goals_against THEN 3
      		WHEN am.goals_for = am.goals_against THEN 1
      		ELSE 0 
      	END
    ) points, 
    SUM(am.goals_for) goals_for, 
    SUM(am.goals_against) goals_against, 
    SUM(am.goals_for) - SUM(am.goals_against) goal_diff
FROM all_matches am
JOIN teams t USING (team_id)
GROUP BY t.team_name
ORDER BY points DESC, goal_diff DESC, team_name;





