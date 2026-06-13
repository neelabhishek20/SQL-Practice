-- Problem: Friend Requests II - Who Has the Most Friends
-- LEETCODE 602

CREATE TABLE RequestAccepted (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

INSERT INTO RequestAccepted VALUES
(1,2,'2016-06-03'),
(1,3,'2016-06-08'),
(2,3,'2016-06-08'),
(3,4,'2016-06-09');

-- Solution

WITH FriendCounts AS (
    SELECT requester_id AS id,
           COUNT(*) AS num
    FROM RequestAccepted
    GROUP BY requester_id

    UNION ALL

    SELECT accepter_id AS id,
           COUNT(*) AS num
    FROM RequestAccepted
    GROUP BY accepter_id
)

SELECT
    id,
    SUM(num) AS num
FROM FriendCounts
GROUP BY id
ORDER BY num DESC
LIMIT 1;

-- Expected Output
--
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 3  | 3   |
-- +----+-----+





Friend relationships:
1 ↔ 2
1 ↔ 3
2 ↔ 3
3 ↔ 4

Friend count:
1 → 2 friends
2 → 2 friends
3 → 3 friends
4 → 1 friend

id = 3
num = 3


