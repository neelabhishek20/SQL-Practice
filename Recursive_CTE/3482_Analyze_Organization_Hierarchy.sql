WITH RECURSIVE EmployeeHierarchy AS (
    SELECT
        employee_id,
        employee_name,
        manager_id,
        salary,
        1 AS level
    FROM Employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        eh.level + 1
    FROM Employees e
    JOIN EmployeeHierarchy eh
        ON e.manager_id = eh.employee_id
),

Subordinates AS (
    SELECT
        employee_id AS manager_id,
        employee_id AS subordinate_id,
        salary
    FROM Employees

    UNION ALL

    SELECT
        s.manager_id,
        e.employee_id,
        e.salary
    FROM Subordinates s
    JOIN Employees e
        ON e.manager_id = s.subordinate_id
),

TeamStats AS (
    SELECT
        manager_id AS employee_id,
        COUNT(*) - 1 AS team_size,
        SUM(salary) AS budget
    FROM Subordinates
    GROUP BY manager_id
)

SELECT
    eh.employee_id,
    eh.employee_name,
    eh.level,
    ts.team_size,
    ts.budget
FROM EmployeeHierarchy eh
JOIN TeamStats ts
    ON eh.employee_id = ts.employee_id
ORDER BY
    eh.level ASC,
    ts.budget DESC,
    eh.employee_name ASC;
