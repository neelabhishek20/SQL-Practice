WITH T AS (
    SELECT
        store_id,
        product_name,
        quantity,
        RANK() OVER (
            PARTITION BY store_id
            ORDER BY price DESC, quantity DESC
        ) AS expensive_rank,
        RANK() OVER (
            PARTITION BY store_id
            ORDER BY price ASC, quantity DESC
        ) AS cheap_rank,
        COUNT(*) OVER (
            PARTITION BY store_id
        ) AS product_count
    FROM inventory
)

SELECT
    s.store_id,
    s.store_name,
    s.location,
    e.product_name AS most_exp_product,
    c.product_name AS cheapest_product,
    ROUND(c.quantity / e.quantity, 2) AS imbalance_ratio
FROM T e
JOIN T c
    ON e.store_id = c.store_id
   AND e.expensive_rank = 1
   AND c.cheap_rank = 1
JOIN stores s
    ON e.store_id = s.store_id
WHERE e.product_count >= 3
  AND e.quantity < c.quantity
ORDER BY
    imbalance_ratio DESC,
    s.store_name ASC;
