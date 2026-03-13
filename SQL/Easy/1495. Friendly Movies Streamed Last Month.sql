

         -- Approach 1. Using - TO_CHAR (ONLY PostgreSQL) -- 
SELECT DISTINCT c.title 
FROM content c 
JOIN tvprogram tv ON c.content_id = tv.content_id
WHERE TO_CHAR(program_date, 'YYYY-MM') = '2020-06' 
	  AND c.kids_content = 'Y'
    AND c.content_type = 'Movies';



        -- Approach 2. Using - BETWEEN (All RDBMS) -- 
SELECT DISTINCT c.title
FROM content c
JOIN tvprogram tv ON c.content_id = tv.content_id
WHERE tv.program_date BETWEEN '2020-06-01' AND '2020-07-01'
  AND c.kids_content = 'Y'
  AND c.content_type = 'Movies';



        -- Approach 3. Using only operators - < / >= / = -- 
SELECT DISTINCT c.title
FROM content c
JOIN tvprogram tv ON c.content_id = tv.content_id
WHERE tv.program_date >= '2020-06-01' AND tv.program_date < '2020-07-01'
  AND c.kids_content = 'Y'
  AND c.content_type = 'Movies';

