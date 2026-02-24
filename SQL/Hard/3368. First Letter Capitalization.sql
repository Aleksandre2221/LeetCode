


         -- Approach 1. Using - INITCAP -- 
SELECT 
    content_id,
    content_text original_text,
    INITCAP(content_text) converted_text
FROM content;



         -- Approach 2. Without - INITCAP, using two - CTE -- 
WITH 
	sep_words AS (
    SELECT *, 
      LOWER(UNNEST(STRING_TO_ARRAY(content_text, ' '))) word
    FROM content
	), 
  uppercase_words AS (
    SELECT *, 
      CONCAT(UPPER(LEFT(word, 1)), SUBSTRING(word FROM 2)) upper_word
    FROM sep_words
)
SELECT 
	content_id, 
  content_text original_text, 
  STRING_AGG(upper_word, ' ') converted_text
FROM uppercase_words
GROUP BY content_id, content_text
