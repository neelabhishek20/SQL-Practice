-- Create Table

CREATE TABLE Employees (
    employee_id INT,
    name VARCHAR(50),
    salary INT
);

-- Insert Sample Data

INSERT INTO Employees VALUES
(1, 'John', 50000),
(2, 'Alice', 70000),
(3, 'Bob', 60000),
(4, 'David', 80000);

-- Find Top 3 Highest Paid Employees

WITH RankedEmployees AS (
    SELECT *
    FROM Employees
)

SELECT *
FROM RankedEmployees
ORDER BY salary DESC
LIMIT 3;
