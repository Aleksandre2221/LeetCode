


         -- Approach 1. Using multiple - CTE --
WITH 
	sep_words AS(
    SELECT *,  
        UNNEST(STRING_TO_ARRAY(REPLACE(content_text,'-','  '), ' ')) word
    FROM user_content 
	),
  sp_char AS (
    SELECT content_id, content_text,  
        CASE 
            WHEN word = '' 
            THEN '-' 
            ELSE word 
        END word
    FROM sep_words
	), 
  upper_words AS (
    SELECT *, 
      CONCAT(UPPER(LEFT(word, 1)), LOWER(SUBSTR(word, 2))) upper_word
    FROM sp_char
) 
SELECT 
	content_id, 
  content_text original_text, 
  REPLACE(STRING_AGG(upper_word, ' '), ' - ', '-') converted_text
FROM upper_words
GROUP BY content_id, content_text
ORDER BY content_id;
