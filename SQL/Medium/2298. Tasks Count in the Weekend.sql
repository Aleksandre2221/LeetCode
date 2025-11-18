

         -- Approach 1. Using - CASE...WHEN condition within - SUM -- 
SELECT 
	SUM(CASE WHEN TRIM(TO_CHAR(submit_date, 'Day')) IN ('Saturday', 'Sunday') THEN 1 END) weekend_cnt,
  SUM(CASE WHEN TRIM(TO_CHAR(submit_date, 'Day')) NOT IN ('Saturday', 'Sunday') THEN 1 END) working_cnt
FROM tasks;


         -- Approach 2. Using - DOW instead of - Day -- 
SELECT
    SUM(CASE WHEN EXTRACT(DOW FROM submit_date) IN (0, 6) THEN 1 END) AS weekend_cnt,
    SUM(CASE WHEN EXTRACT(DOW FROM submit_date) NOT IN (0, 6) THEN 1 END) AS working_cnt
FROM tasks;
