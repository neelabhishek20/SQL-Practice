-- Problem: Nth Highest Salary
-- LEETCODE Q177

CREATE TABLE Employee (
    id INT,
    salary INT
);

INSERT INTO Employee VALUES
(1,100),
(2,200),
(3,300),
(4,400);

-- Example: Find 2nd Highest Salary

SET @N = 2;

SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET @N - 1;

-- Expected Output
--
-- +--------+
-- | salary |
-- +--------+
-- | 300    |
-- +--------+


ACTUAL SOLUTION FOR LEETCODE:
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET N = N - 1;

    RETURN (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET N
    );
END
