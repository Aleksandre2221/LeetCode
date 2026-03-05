


         -- Approach 1. Using - NOT EXISTS condition -- 
SELECT b.book_id, b.name
FROM books b
WHERE b.available_from < ('2019-06-23'::date - INTERVAL '1 month')
  AND NOT EXISTS (
      SELECT 1
      FROM orders o
      WHERE o.book_id = b.book_id
        AND o.dispatch_date BETWEEN ('2019-06-23'::date - INTERVAL '1 year') AND '2019-06-23'::date
      GROUP BY o.book_id
      HAVING SUM(o.quantity) >= 10
  );








