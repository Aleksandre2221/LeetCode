

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
    FROM category_info t  
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
