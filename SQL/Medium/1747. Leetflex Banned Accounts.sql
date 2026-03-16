

         -- Approach 1. Using only - JOIN with multiple conditions -- 
SELECT DISTINCT l1.account_id 
FROM loginfo l1 
JOIN loginfo l2 
	ON l1.account_id = l2.account_id 
	AND l1.ip_address <> l2.ip_address 
 	AND l2.login BETWEEN l1.login AND l1.logout;



         -- Approach 2. Using - WHERE EXISTS condition -- 
SELECT DISTINCT l1.account_id
FROM loginfo l1
WHERE EXISTS (
    SELECT 1
    FROM loginfo l2
    WHERE l2.account_id = l1.account_id
      AND l2.ip_address <> l1.ip_address
      AND l2.login BETWEEN l1.login AND l1.logout
);
