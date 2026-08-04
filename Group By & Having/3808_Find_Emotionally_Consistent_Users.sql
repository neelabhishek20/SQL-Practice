

WITH t AS (
    SELECT
        user_id,
        reaction,
        COUNT(*) AS cnt
    FROM reactions
    GROUP BY user_id, reaction
),
s AS (
    SELECT
        user_id,
        MAX(cnt) AS mx_cnt,
        ROUND(MAX(cnt) / SUM(cnt), 2) AS reaction_ratio
    FROM t
    GROUP BY user_id
    HAVING SUM(cnt) >= 5
       AND ROUND(MAX(cnt) / SUM(cnt), 2) >= 0.60
)

SELECT
    s.user_id,
    t.reaction AS dominant_reaction,
    s.reaction_ratio
FROM s
JOIN t
ON s.user_id = t.user_id
WHERE t.cnt = s.mx_cnt
ORDER BY reaction_ratio DESC, user_id;
