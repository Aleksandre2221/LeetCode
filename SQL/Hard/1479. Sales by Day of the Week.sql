


         -- Approach 1. Using - CTE -- 
WITH sold_amount AS (
    SELECT i.item_category,
        TRIM(TO_CHAR(o.order_date, 'Day')) week_day,
        SUM(o.quantity) total_sold
    FROM items i
    LEFT JOIN orders o USING (item_id)
    GROUP BY i.item_category, TRIM(TO_CHAR(o.order_date, 'Day'))
)
SELECT item_category,
    SUM(CASE WHEN week_day = 'Monday'    THEN total_sold ELSE 0 END) "Monday",
    SUM(CASE WHEN week_day = 'Tuesday'   THEN total_sold ELSE 0 END) "Tuesday",
    SUM(CASE WHEN week_day = 'Wednesday' THEN total_sold ELSE 0 END) "Wednesday",
    SUM(CASE WHEN week_day = 'Thursday'  THEN total_sold ELSE 0 END) "Thursday",
    SUM(CASE WHEN week_day = 'Friday'    THEN total_sold ELSE 0 END) "Friday",
    SUM(CASE WHEN week_day = 'Saturday'  THEN total_sold ELSE 0 END) "Saturday",
    SUM(CASE WHEN week_day = 'Sunday'    THEN total_sold ELSE 0 END) "Sunday"
FROM sold_amount
GROUP BY item_category
ORDER BY item_category;
