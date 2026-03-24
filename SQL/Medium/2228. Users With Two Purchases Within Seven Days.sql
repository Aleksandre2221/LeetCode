

         -- Approach 1. Using - CTE with a Window Function - LAG() -- 
WITH date_diff AS (
  SELECT user_id, 
      purchase_date - LAG(purchase_date) OVER(PARTITION BY user_id ORDER BY purchase_date) diff
  FROM purchases
)
SELECT DISTINCT user_id 
FROM date_diff
WHERE diff <= 7
ORDER BY user_id;
