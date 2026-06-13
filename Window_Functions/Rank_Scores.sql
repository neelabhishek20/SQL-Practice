-- Problem: Rank Scores
--- Q178 LEETCODE
CREATE TABLE Scores (
    id INT,
    score DECIMAL(3,2)
);

INSERT INTO Scores VALUES
(1,3.50),
(2,3.65),
(3,4.00),
(4,3.85),
(5,4.00),
(6,3.65);

-- Solution

SELECT
    score,
    DENSE_RANK() OVER (
        ORDER BY score DESC
    ) AS `rank`
FROM Scores
ORDER BY score DESC;

-- Expected Output
--
-- +-------+------+
-- | score | rank |
-- +-------+------+
-- | 4.00  | 1    |
-- | 4.00  | 1    |
-- | 3.85  | 2    |
-- | 3.65  | 3    |
-- | 3.65  | 3    |
-- | 3.50  | 4    |
-- +-------+------+
