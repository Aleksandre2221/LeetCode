

-- Risolved: 3 times


         -- Approach 1. Using two - CTE -- 
WITH 
  category_info AS (
    SELECT t.customer_id, p.category,   
      COUNT(*) cnt, 
      MAX(transaction_date) max_date
    FROM transactions t  
    JOIN products p ON P.product_id = t.product_id
    GROUP BY t.customer_id, p.category
  ),
  category_ranking AS (
    SELECT customer_id, category, 
      RANK() OVER(PARTITION BY customer_id ORDER BY cnt DESC, max_date DESC) rnk
    FROM category_info   
) 
SELECT 
  t.customer_id, 
  ROUND(SUM(p.price), 2) total_amount, 
  COUNT(t.transaction_id) total_transactions, 
  COUNT(DISTINCT p.category) unique_categories, 
  ROUND(AVG(p.price), 2) avg_transaction_amount, 
  MAX(cr.category) top_category,
  ROUND((COUNT(transaction_id) * 10) + (SUM(p.price) / 100), 2) loyalty_score
FROM transactions t 
JOIN products p ON p.product_id = t.product_id
JOIN category_ranking cr ON cr.customer_id = t.customer_id AND cr.rnk = 1
GROUP BY t.customer_id
ORDER BY loyalty_score DESC, customer_id;



          -- Approach 2. Using one - CTE -- 
WITH category_info AS (
  SELECT t.customer_id, p.category, 
           DENSE_RANK() OVER(
                           PARTITION BY t.customer_id 
                           ORDER BY COUNT(*) DESC, MAX(t.transaction_date) DESC) rnk
  FROM transactions t  
  JOIN products p ON t.product_id = p.product_id
  GROUP BY t.customer_id, p.category
)
SELECT t.customer_id, 
    SUM(t.amount) total_amount, 
    COUNT(t.transaction_id) transaction_cnt, 
    COUNT(DISTINCT p.category) category_cnt,
    MAX(ci.category) most_frequent_category,
    ROUND(AVG(t.amount), 2) avg_amount, 
    ROUND((COUNT(t.transaction_id) * 10.0) + (sum(t.amount) / 100.0), 2) loyalty_score
FROM transactions t 
JOIN products p USING (product_id)
JOIN category_info ci USING (customer_id)
WHERE ci.rnk = 1 
GROUP BY t.customer_id
ORDER BY loyalty_score DESC, customer_id;




