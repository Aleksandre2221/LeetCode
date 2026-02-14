


         -- Approach 1. Using multiple - CTE -- 
WITH 
	words AS (
    SELECT *, UNNEST(STRING_TO_ARRAY(content, ' ')) word
    FROM posts
  ),
  grps AS (
    SELECT DISTINCT w.post_id, k.topic_id  
    FROM words w  
    JOIN keywords k ON LOWER(w.word) = LOWER(k.word)
	),
  topics AS (
    SELECT post_id, 
      STRING_AGG(topic_id::text, ',' ORDER BY topic_id) topic 
    FROM grps  
    GROUP BY post_id
)
SELECT p.post_id, 
	COALESCE(t.topic, 'Ambiguous!') topic
FROM posts p  
LEFT JOIN topics t ON p.post_id = t.post_id;



           -- Approach 2. Using conditions in - LEFT JOIN -- 
SELECT p.post_id,
    COALESCE(
            STRING_AGG(DISTINCT k.topic_id::TEXT, ',' ORDER BY k.topic_id::TEXT) 
      ,'Ambiguous!') topic
FROM posts p
LEFT JOIN keywords k 
  ON ' ' || LOWER(p.content) || ' ' LIKE '% ' || LOWER(k.word) || ' %'
GROUP BY p.post_id;




