

         -- Approach 1. Using - Self=Join --
SELECT DISTINCT c1.user_id
FROM confirmations c1
JOIN confirmations c2 
    ON c1.user_id = c2.user_id 
    AND c1.time_stamp < c2.time_stamp
    AND c2.time_stamp - c1.time_stamp <= INTERVAL '1 Day';



         -- Approach 2. Using - EXISTS condition -- 
SELECT DISTINCT c1.user_id
FROM confirmations c1
WHERE EXISTS (
  SELECT 1
  FROM confirmations c2
  WHERE c2.user_id = c1.user_id
    AND c2.time_stamp > c1.time_stamp
    AND c2.time_stamp - c1.time_stamp <= INTERVAL '1 day'
);
