

         -- The Best Approach. Using - WHERE condition --
SELECT book_id, title, author, published_year
FROM books 
WHERE rating IS NULL 
ORDER BY book_id;
