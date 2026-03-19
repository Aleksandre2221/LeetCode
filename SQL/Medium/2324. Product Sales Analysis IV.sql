

         -- Approach 1. Using two - CTE --  
WITH 
	total_amount AS (
    	SELECT s.user_id, p.product_id, 
            SUM(s.quantity * p.price) OVER(PARTITION BY s.user_id, p.product_id ) ta
        FROM sales s 
        JOIN product p USING (product_id)
  	), 
  	max_amount AS (
        SELECT *, 
      	    MAX(ta) OVER(PARTITION BY user_id) ma  
        FROM total_amount
) 
SELECT DISTINCT user_id, product_id 
FROM max_amount  
WHERE ta = ma;



