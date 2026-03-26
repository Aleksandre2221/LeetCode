


         -- Approach 1. Using multiple - CTE -- 
WITH 
	words AS (
      SELECT post_id, 
      	 UNNEST(STRING_TO_ARRAY(content, ' ')) word
      FROM posts
	), 
    topics AS (
      SELECT DISTINCT w.post_id, k.topic_id
      FROM words w  
      JOIN keywords k ON LOWER(w.word) = LOWER(k.word)
) 
SELECT 
	p.post_id, 
    COALESCE(
		STRING_AGG(t.topic_id::text, ',' ORDER BY t.topic_id)
    , 'Ambiguous!') topic 
FROM posts p 
LEFT JOIN topics t USING (post_id)
GROUP BY p.post_id;



           -- Approach 2. Using conditions in - LEFT JOIN -- 
SELECT p.post_id,
    COALESCE(
            STRING_AGG(DISTINCT k.topic_id::TEXT, ',' ORDER BY k.topic_id::TEXT) 
      ,'Ambiguous!') topic
FROM posts p
LEFT JOIN keywords k 
  ON ' ' || LOWER(p.content) || ' ' LIKE '% ' || LOWER(k.word) || ' %'
GROUP BY p.post_id;




