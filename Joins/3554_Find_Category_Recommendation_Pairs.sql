WITH user_category AS (
    SELECT DISTINCT
        pp.user_id,
        pi.category
    FROM ProductPurchases pp
    JOIN ProductInfo pi
        ON pp.product_id = pi.product_id
),

pair_per_user AS (
    SELECT
        a.user_id,
        a.category AS category1,
        b.category AS category2
    FROM user_category a
    JOIN user_category b
        ON a.user_id = b.user_id
        AND a.category < b.category
)

SELECT
    category1,
    category2,
    COUNT(DISTINCT user_id) AS customer_count
FROM pair_per_user
GROUP BY category1, category2
HAVING COUNT(DISTINCT user_id) >= 3
ORDER BY customer_count DESC, category1 ASC, category2 ASC;
