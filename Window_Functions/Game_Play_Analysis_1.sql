-- Problem: Game Play Analysis I

CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

INSERT INTO Activity VALUES
(1,2,'2016-03-01',5),
(1,2,'2016-05-02',6),
(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);

-- Solution

SELECT
    player_id,
    MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

-- Expected Output
--
-- +-----------+-------------+
-- | player_id | first_login |
-- +-----------+-------------+
-- |     1     | 2016-03-01  |
-- |     2     | 2017-06-25  |
-- |     3     | 2016-03-02  |
-- +-----------+-------------+
