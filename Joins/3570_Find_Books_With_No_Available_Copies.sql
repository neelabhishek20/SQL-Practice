

WITH T AS (
    SELECT
        book_id,
        COUNT(*) AS current_borrowers
    FROM borrowing_records
    WHERE return_date IS NULL
    GROUP BY book_id
)

SELECT
    lb.book_id,
    lb.title,
    lb.author,
    lb.genre,
    lb.publication_year,
    T.current_borrowers
FROM library_books lb
JOIN T
ON lb.book_id = T.book_id
WHERE T.current_borrowers = lb.total_copies
ORDER BY current_borrowers DESC, title ASC;
