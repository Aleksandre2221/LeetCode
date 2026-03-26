


         -- Approach 1. Using multiple - CTE -- 
WITH 
	team_passes AS (
        SELECT
            t1.team_name,
            p.time_stamp,
            (t1.team_name = t2.team_name) intra_team
        FROM Passes p
        JOIN Teams t1 ON p.pass_from = t1.player_id
        JOIN Teams t2 ON p.pass_to = t2.player_id
    ),
	grps AS (
        SELECT
            team_name,
            time_stamp,
            intra_team,
            ROW_NUMBER() OVER (PARTITION BY team_name ORDER BY time_stamp) -
            ROW_NUMBER() OVER (PARTITION BY team_name, intra_team ORDER BY time_stamp) grp
        FROM team_passes
    ),
	streaks_ranking AS (
        SELECT
            team_name,
            COUNT(*) AS cnt,
            RANK() OVER (PARTITION BY team_name ORDER BY COUNT(*) DESC) rnk
        FROM grps
        WHERE intra_team = TRUE
        GROUP BY team_name, grp
)
SELECT
    team_name,
    MAX(cnt) AS longest_streak       
FROM streaks_ranking
WHERE rnk = 1
GROUP BY team_name
ORDER BY team_name;
