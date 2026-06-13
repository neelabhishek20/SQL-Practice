WITH ManagerCount AS (
    SELECT managerId,
           COUNT(*) AS cnt
    FROM Employee
    GROUP BY managerId
)
SELECT e.name
FROM Employee e
JOIN ManagerCount m
ON e.id = m.managerId
WHERE m.cnt >= 5;

-- LEETCODE 570
