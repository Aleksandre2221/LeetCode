

-- Risolved: 2 times


         -- Approach 1. Using - UNION ALL -- 
WITH all_teams AS (
	SELECT home_team_id AS team_id, away_team_id, home_team_goals, away_team_goals
	FROM matches 
	UNION ALL
	SELECT away_team_id AS team_id, home_team_id, away_team_goals, home_team_goals
	FROM matches
)
SELECT t.team_name,	
	COUNT(*) matches_played,
	SUM(
		CASE 
			WHEN home_team_goals>away_team_goals THEN 3 
			WHEN home_team_goals=away_team_goals THEN 1
			ELSE 0
     	END
	) points,
	SUM(home_team_goals) goal_for,
	SUM(away_team_goals) goal_against,  
	SUM(home_team_goals) - SUM(away_team_goals) goal_diff
FROM teams t  
LEFT JOIN all_teams a ON a.team_id = t.team_id
GROUP BY t.team_name
ORDER BY points DESC, goal_diff DESC, team_name;




		 -- Approach 2. Usomg two - CTE -- 
WITH 
	home_teams AS (
      SELECT home_team_id, 
      	SUM(home_team_goals) goals_for, 
      	SUM(away_team_goals) goals_against, 
      	COUNT(*) matches_played,
      	SUM(
          	CASE 	
          		WHEN away_team_goals < home_team_goals THEN 3 
          		WHEN away_team_goals = home_team_goals THEN 1 ELSE 0 
          	END) pts
      FROM matches  
      GROUP BY home_team_id
	), 
    away_teams AS (
	  SELECT away_team_id, 
      	SUM(away_team_goals) goals_for, 
      	SUM(home_team_goals) goals_against, 
      	COUNT(*) matches_played,
      	SUM(
          	CASE 	
          		WHEN away_team_goals > home_team_goals THEN 3 
          		WHEN away_team_goals = home_team_goals THEN 1 ELSE 0 
          	END) pts
      FROM matches  
      GROUP BY away_team_id
)
SELECT t.team_name, 
	COALESCE(ht.matches_played + at.matches_played, 0) matches_played, 
	COALESCE(ht.pts + at.pts) points,
    COALESCE(ht.goals_for + at.goals_for, 0) goal_for, 
    COALESCE(ht.goals_against + at.goals_against, 0) goal_against,
    COALESCE((ht.goals_for + at.goals_for) - (ht.goals_against + at.goals_against), 0) goal_diff
FROM teams t
LEFT JOIN home_teams ht ON ht.home_team_id = t.team_id
LEFT JOIN away_teams at ON at.away_team_id = t.team_id
ORDER BY points DESC, goal_diff DESC, team_name;




         -- Approach 3. Using multiple - CTE --   
WITH 
  points AS (
    SELECT *,
       CASE  
           WHEN home_team_goals > away_team_goals THEN 3 
           WHEN home_team_goals = away_team_goals THEN 1
           ELSE 0 
       END home_team_pts, 
       CASE  
           WHEN home_team_goals < away_team_goals THEN 3 
           WHEN home_team_goals = away_team_goals THEN 1
           ELSE 0 
       END away_team_pts 
    FROM matches 
  ), 
  home_stats AS (
    SELECT home_team_id team_id,
           COUNT(*) matches_played,
           SUM(home_team_pts) points,
           SUM(home_team_goals) goals_for,
           SUM(away_team_goals) goals_against
    FROM points
    GROUP BY home_team_id
  ),
  away_stats AS (
    SELECT away_team_id team_id,
           COUNT(*) matches_played,
           SUM(away_team_pts) points,
           SUM(away_team_goals) goals_for,
           SUM(home_team_goals) goals_against
    FROM points
    GROUP BY away_team_id
)
SELECT t.team_name,
  (h.matches_played + a.matches_played) matches_played,
  (h.points + a.points) points,
  (h.goals_for + a.goals_for) goals_for,
  (h.goals_against + a.goals_against) goals_against,
  (h.goals_for + a.goals_for) - (h.goals_against+ a.goals_against) goal_diff
FROM teams t
LEFT JOIN home_stats h ON t.team_id = h.team_id
LEFT JOIN away_stats a ON t.team_id = a.team_id
ORDER BY points DESC, goal_diff DESC, team_name;




