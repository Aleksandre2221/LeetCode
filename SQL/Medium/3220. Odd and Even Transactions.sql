

         -- Approach 1. Using - SUM with - CASE..WHEN conditions --
SELECT transaction_date, 
  COALESCE(SUM(CASE WHEN amount % 2 <> 0 THEN amount END), 0) odd_sum, 
  COALESCE(SUM(CASE WHEN amount % 2 = 0 THEN amount END), 0) even_sum 
FROM transactions 
GROUP BY transaction_date
ORDER BY transaction_date;



       -- Approach 2. Using - SUM with - FILTER conditions -- 
SELECT transaction_date,
  SUM(amount) FILTER (WHERE amount % 2 <> 0) odd_sum,
  SUM(amount) FILTER (WHERE amount % 2 = 0) even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date;
