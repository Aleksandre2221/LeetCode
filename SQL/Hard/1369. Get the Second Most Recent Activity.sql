


         -- Approach 1. Using two - CTE -- 
WITH 
  row_num AS (
    SELECT *,
      	ROW_NUMBER() OVER(PARTITION BY username ORDER BY enddate DESC) rn,
      	COUNT(*) OVER(PARTITION BY username) cnt 
    FROM user_activity
  ),
  valid_dates AS (
    SELECT username, activity, startdate, 
        CASE  
            WHEN rn = 2 AND cnt > 1 THEN enddate 
            WHEN cnt = 1 THEN enddate
        END enddate
    FROM row_num
)
SELECT * 
FROM valid_dates
WHERE enddate IS NOT NULL; 



         -- Approach 2. Using one - CTE -- 
WITH row_num AS (
	SELECT *,
      	ROW_NUMBER() OVER(PARTITION BY username ORDER BY enddate DESC) rn,
      	COUNT(*) OVER(PARTITION BY username) cnt 
	FROM user_activity
)
SELECT username, activity, startdate, enddate 
FROM row_num
WHERE rn = 2 OR cnt = 1; 


