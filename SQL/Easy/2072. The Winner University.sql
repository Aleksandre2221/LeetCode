

         -- The Best Approach. Using - Cross Join and - CASE...WHEN conditions --  
SELECT
	CASE  
        WHEN n.cnt > c.cnt THEN 'New York University' 
        WHEN n.cnt < c.cnt THEN 'California University'
        ELSE 'No Winner'
    END winner
FROM 
	(SELECT COUNT(*) cnt FROM newyork WHERE score >= 90) n, 
    (SELECT COUNT(*) cnt FROM california WHERE score >= 90) c;
