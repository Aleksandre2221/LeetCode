

-- Risolved: 4 times


           -- Approach 1. Using two - CTE -- 
WITH 
  cons_groups AS (
    SELECT *, 
      seat_id - ROW_NUMBER() OVER(ORDER BY seat_id) grp_id
    FROM cinema
    WHERE free = TRUE
  ), 
  groups_cnt AS (
    SELECT grp_id,
      MIN(seat_id) first_seat_id,
      MAX(seat_id) last_seat_id,
      COUNT(*) consecutive_seats_len, 
      DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) rnk 
    FROM cons_groups
    GROUP BY grp_id
)
SELECT first_seat_id, last_seat_id, consecutive_seats_len
FROM groups_cnt
WHERE rnk = 1
ORDER BY first_seat_id;



           -- Approach 2. Using one CTE -- 
WITH row_num AS (
  SELECT *, 
      seat_id - ROW_NUMBER() OVER(ORDER BY seat_id) rn 
  FROM seats 
  WHERE is_free = 1
)
SELECT 
    MIN(seat_id) first_seat_id, 
    MAX(seat_id) last_seat_id, 
    COUNT(rn) consecutvie_seats_length
FROM row_num 
GROUP BY rn
HAVING COUNT(rn) = (
  SELECT COUNT(rn) cnt
  FROM row_num 
  GROUP BY rn 
  ORDER BY cnt DESC 
  LIMIT 1
);




