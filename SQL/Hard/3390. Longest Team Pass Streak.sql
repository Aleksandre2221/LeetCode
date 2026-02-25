


         -- Approach 1. Using multiple - CTE -- 
WITH 
	flagged AS (
      SELECT 
          t1.team_name team_name,
          p.time_stamp,
          CASE 
              WHEN t1.team_name = t2.team_name 
      		    THEN 1
              ELSE 0
          END is_success
      FROM passes p
      JOIN teams t1 ON t1.player_id = p.pass_from
      JOIN teams t2 ON t2.player_id = p.pass_to
  ),
  filtered AS (
      SELECT *
      FROM flagged
      WHERE is_success = 1
  ),
  row_nums AS (
      SELECT 
         team_name,
         time_stamp,
         ROW_NUMBER() OVER (ORDER BY time_stamp) global_rn,
         ROW_NUMBER() OVER (PARTITION BY team_name ORDER BY time_stamp) team_rn
      FROM filtered
  ),
  grps AS (
      SELECT *,
          (global_rn - team_rn) grp_id
      FROM row_nums
  ),
  streaks_cnt AS (
      SELECT team_name, 
          COUNT(*) streak_length
      FROM grps
      GROUP BY team_name, grp_id
)
SELECT team_name,
    MAX(streak_length) longest_streak
FROM streaks_cnt
GROUP BY team_name
ORDER BY team_name;
