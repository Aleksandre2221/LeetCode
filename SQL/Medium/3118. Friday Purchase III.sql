

         -- Approach 1. Using - 
WITH 
	  weeks AS (
      SELECT DISTINCT LEFT(TO_CHAR(purchase_date, 'Week'), 1) week_of_month
      FROM purchases
    ),
    memberships AS (
      SELECT DISTINCT membership 
      FROM users
	    WHERE membership IN ('VIP', 'Premium')
	  ),
	  weeks_memberships AS (
      SELECT * 
      FROM weeks 
      CROSS JOIN memberships 
	  ), 
    valid_data AS (
      SELECT 
		LEFT(TO_CHAR(p.purchase_date, 'Week'), 1) week_of_month, 
		u.membership, 
		SUM(p.amount_spend) total_amount
	  FROM purchases p 
	  JOIN users u ON p.user_id = u.user_id
	  WHERE u.membership IN ('VIP', 'Premium')
      	AND EXTRACT(DOW FROM p.purchase_date) = 5 
  	  GROUP BY u.membership, week_of_month
)
SELECT wm.week_of_month, wm.membership, COALESCE(vd.total_amount, 0) total_amount
FROM weeks_memberships wm 
LEFT JOIN valid_data vd ON wm.week_of_month = vd.week_of_month 
	AND wm.membership = vd.membership 
ORDER BY week_of_month, membership
