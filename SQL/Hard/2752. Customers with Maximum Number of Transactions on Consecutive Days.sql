


        -- Approach 1. Using two - CTE -- 
WITH 
	cons_grps AS (
      SELECT *, 
        transaction_date - ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY transaction_date)::int cons_id
      FROM transactions
    ),
    cons_cnt AS (
      SELECT customer_id, 
      	COUNT(cons_id) cons_cnt
      FROM cons_grps 
      GROUP BY customer_id, cons_id
)
SELECT customer_id 
FROM cons_cnt
WHERE cons_cnt = (SELECT MAX(cons_cnt) FROM cons_cnt)
ORDER BY customer_id;
