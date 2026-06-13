-- Problem: Department Top Three Salaries
-- LEETCODE 185

CREATE TABLE Employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    departmentId INT
);

CREATE TABLE Department (
    id INT,
    name VARCHAR(50)
);

INSERT INTO Department VALUES
(1,'IT'),
(2,'HR');

INSERT INTO Employee VALUES
(1,'John',90000,1),
(2,'Alice',85000,1),
(3,'Bob',80000,1),
(4,'David',75000,1),
(5,'Emma',70000,2),
(6,'Sophia',65000,2),
(7,'Liam',60000,2);

-- Solution

WITH RankedSalaries AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (
            PARTITION BY e.departmentId
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM Employee e
    JOIN Department d
        ON e.departmentId = d.id
)

SELECT
    Department,
    Employee,
    Salary
FROM RankedSalaries
WHERE salary_rank <= 3;

-- Expected Output
--
-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | John     | 90000  |
-- | IT         | Alice    | 85000  |
-- | IT         | Bob      | 80000  |
-- | HR         | Emma     | 70000  |
-- | HR         | Sophia   | 65000  |
-- | HR         | Liam     | 60000  |
-- +------------+----------+--------+
