


        -- Approach 1. Using two - CTE -- 
WITH 
	cons_grps AS (
      SELECT customer_id, 
      		transaction_date - ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY transaction_date)::int grp
      FROM transactions
	), 
    cons_cnt AS (
      SELECT customer_id, COUNT(*), 
      	 RANK() OVER(ORDER BY COUNT(*) DESC) rnk 
      FROM cons_grps
      GROUP BY customer_id, grp
)
SELECT customer_id
FROM cons_cnt 
WHERE rnk = 1 
ORDER BY customer_id;
