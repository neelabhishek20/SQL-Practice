-- Problem: Second Highest Salary
-- Q176 LEETCODE
CREATE TABLE Employee (
    id INT,
    salary INT
);

INSERT INTO Employee VALUES
(1,100),
(2,200),
(3,300);

-- Solution

SELECT
    MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary <
(
    SELECT MAX(salary)
    FROM Employee
);

-- Expected Output
--
-- +---------------------+
-- | SecondHighestSalary |
-- +---------------------+
-- | 200                 |
-- +---------------------+
