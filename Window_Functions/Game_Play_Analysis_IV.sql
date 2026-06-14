-- Problem: Game Play Analysis IV

CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

INSERT INTO Activity VALUES
(1,2,'2016-03-01',5),
(1,2,'2016-03-02',6),
(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);

-- Solution

WITH FirstLogin AS (
    SELECT
        player_id,
        MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
)

SELECT
    ROUND(
        COUNT(DISTINCT a.player_id) /
        (SELECT COUNT(DISTINCT player_id) FROM Activity),
        2
    ) AS fraction
FROM Activity a
JOIN FirstLogin f
ON a.player_id = f.player_id
WHERE a.event_date = DATE_ADD(f.first_login, INTERVAL 1 DAY);

-- Expected Output
--
-- +----------+
-- | fraction |
-- +----------+
-- |   0.33   |
-- +----------+
