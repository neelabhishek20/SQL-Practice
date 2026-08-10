WITH T AS (
    SELECT
        user_id,
        activity_type,
        ROUND(AVG(activity_duration), 2) AS duration
    FROM UserActivity 
    WHERE activity_type != 'cancelled'
    GROUP BY user_id, activity_type
)

SELECT 
    f.user_id,
    f.duration AS trial_avg_duration,
    p.duration AS paid_avg_duration
FROM T f
JOIN T p
    ON f.user_id = p.user_id
WHERE f.activity_type = 'free_trial'
  AND p.activity_type = 'paid'
ORDER BY f.user_id;
