WITH latest_event AS (
    SELECT
        user_id,
        event_type,
        plan_name,
        monthly_amount,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY event_date DESC, event_id DESC
        ) AS rn
    FROM subscription_events
),

history AS (
    SELECT
        user_id,
        MIN(event_date) AS start_date,
        MAX(event_date) AS last_event_date,
        MAX(monthly_amount) AS max_historical_amount,
        SUM(event_type = 'downgrade') AS downgrade_count
    FROM subscription_events
    GROUP BY user_id
)

SELECT
    l.user_id,
    l.plan_name AS current_plan,
    l.monthly_amount AS current_monthly_amount,
    h.max_historical_amount,
    DATEDIFF(h.last_event_date, h.start_date) AS days_as_subscriber
FROM latest_event l
JOIN history h
    ON l.user_id = h.user_id
WHERE l.rn = 1
  AND l.event_type <> 'cancel'
  AND h.downgrade_count >= 1
  AND l.monthly_amount < 0.5 * h.max_historical_amount
  AND DATEDIFF(h.last_event_date, h.start_date) >= 60
ORDER BY
    days_as_subscriber DESC,
    l.user_id ASC;
