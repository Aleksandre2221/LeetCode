-- Risolved: 2 times 


         -- Approach 1. Using - UNION ALL --
SELECT id, COUNT(*) num  
FROM (
  	SELECT accepter_id id FROM requestaccepted
  	UNION ALL  
  	SELECT requester_id id FROM requestaccepted
)
GROUP BY id  
ORDER BY num DESC  
LIMIT 1



         -- Appraoch 2. Withoout - UNION ALL -- 
WITH 
	req_cnt AS (
      SELECT requester_id, COUNT(*) req_cnt
      FROM requestaccepted
      GROUP BY requester_id), 
      
     acc_cnt AS (
       SELECT accepter_id, COUNT(*) acc_cnt
       FROM requestaccepted
       GROUP BY accepter_id)

SELECT * 
FROM (
  SELECT COALESCE(requester_id, accepter_id) id , COALESCE(req_cnt, 0) + COALESCE(acc_cnt, 0) num
  FROM req_cnt 
  FULL JOIN acc_cnt ON acc_cnt.accepter_id = req_cnt.requester_id
)
ORDER BY num DESC  
LIMIT 1
