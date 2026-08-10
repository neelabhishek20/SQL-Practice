WITH recent AS (
    SELECT
        employee_id,
        rating,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY review_date DESC
        ) AS rn,
        LAG(rating) OVER (
            PARTITION BY employee_id
            ORDER BY review_date DESC
        ) AS prev_rating
    FROM performance_reviews
)

SELECT
    r.employee_id,
    e.name,
    SUM(r.prev_rating - r.rating) AS improvement_score
FROM recent r
JOIN employees e
    ON r.employee_id = e.employee_id
WHERE r.rn BETWEEN 2 AND 3
GROUP BY r.employee_id, e.name
HAVING COUNT(*) = 2
   AND MIN(r.prev_rating - r.rating) > 0
ORDER BY improvement_score DESC, e.name ASC;
