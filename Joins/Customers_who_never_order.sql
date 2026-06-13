-- Problem: Customers Who Never Order

CREATE TABLE Customers (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    customerId INT
);

INSERT INTO Customers VALUES
(1,'Joe'),
(2,'Henry'),
(3,'Sam'),
(4,'Max');

INSERT INTO Orders VALUES
(1,3),
(2,1);

-- Solution

SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
ON c.id = o.customerId
WHERE o.customerId IS NULL;

-- Expected Output
--
-- +-----------+
-- | Customers |
-- +-----------+
-- | Henry     |
-- | Max       |
-- +-----------+
