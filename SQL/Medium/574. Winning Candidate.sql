

        -- Appraoch 1. Using - COUNT(*) - in ORDER BY clause -- 
SELECT can.name
FROM candidate can
JOIN vote v ON can.id = v.candidateid
GROUP BY can.name
ORDER BY COUNT(*) DESC
LIMIT 1;


         -- Appraoch 2. Using - TOP 1 - (For MySQL) -- 
SELECT TOP 1 can.name
FROM candidate can
JOIN vote v ON can.id = v.candidateid
GROUP BY can.name
ORDER BY COUNT(*) DESC;



        -- Approach 2. Using Window Function - RANK -- 
SELECT can.name
FROM (
    SELECT candidateid, COUNT(*) cnt,
           RANK() OVER (ORDER BY COUNT(*) DESC) rnk
    FROM vote
    GROUP BY candidateid
) vc
JOIN candidate can ON can.id = vc.candidateid
WHERE vc.rnk = 1;



          -- Approach 3. Using Sunbquery in JOIN -- 
SELECT can.name
FROM candidate can
JOIN (
    SELECT candidateid, COUNT(*) cnt
    FROM vote
    GROUP BY candidateid
    ORDER BY cnt DESC
    LIMIT 1
) vc ON vc.candidateid = can.id;



        -- Appraoch 4. Using - CTE -- 
WITH votes_cnt AS (
  	SELECT candidateid, COUNT(*) cnt
  	FROM vote
  	GROUP BY candidateid
)
SELECT can.name
FROM candidate can
JOIN votes_cnt vc ON vc.candidateid = can.id
WHERE vc.cnt = (SELECT MAX(cnt) FROM votes_cnt);







