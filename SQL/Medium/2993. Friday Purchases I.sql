

         -- Approach 1. Using - EXTRACT --  
SELECT
    CEIL(EXTRACT(DAY FROM purchase_date) / 7.0) AS week_of_month,
    purchase_date,
    SUM(amount_spend) AS total_amount
FROM purchases
WHERE EXTRACT(DOW FROM purchase_date) = 5
GROUP BY CEIL(EXTRACT(DAY FROM purchase_date) / 7.0), purchase_date;
