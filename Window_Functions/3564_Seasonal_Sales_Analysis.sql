WITH SeasonalSales AS (
    SELECT
        CASE
            WHEN MONTH(sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(sale_date) IN (6, 7, 8) THEN 'Summer'
            ELSE 'Fall'
        END AS season,
        category,
        SUM(quantity) AS total_quantity,
        SUM(quantity * price) AS total_revenue
    FROM sales
    JOIN products USING (product_id)
    GROUP BY season, category
),

Ranked AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY season
            ORDER BY total_quantity DESC,
                     total_revenue DESC
        ) AS rk
    FROM SeasonalSales
)

SELECT
    season,
    category,
    total_quantity,
    total_revenue
FROM Ranked
WHERE rk = 1
ORDER BY season;
