

-- Risolved: 3 times


         -- The Best Approach. Using - CASE...WHEN condition within Window Function - SUM --  
SELECT account_id, day,  
	SUM(CASE WHEN type = 'Deposit' THEN amount ELSE -amount END) OVER(PARTITION BY account_id ORDER BY DAy) balance
FROM transactions 
ORDER BY account_id, day; 
