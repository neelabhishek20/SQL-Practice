WITH RECURSIVE EmployeeHierarchy AS (
    -- CEO
    SELECT
        employee_id,
        employee_name,
        manager_id,
        salary,
        1 AS level
    FROM Employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Employees under each manager
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
    -- Direct employees
    SELECT
        employee_id AS manager_id,
        employee_id AS subordinate_id
    FROM Employees

    UNION ALL

    -- Indirect employees
    SELECT
        s.manager_id,
        e.employee_id
    FROM Subordinates s
    JOIN Employees e
        ON e.manager_id = s.subordinate_id
),

TeamStats AS (
    SELECT
        s.manager_id AS employee_id,
        COUNT(*) - 1 AS team_size,
        SUM(e.salary) AS budget
    FROM Subordinates s
    JOIN Employees e
        ON e.employee_id = s.subordinate_id
    GROUP BY s.manager_id
)

SELECT
    eh.employee_id,
    eh.employee_name,
    eh.level,
    COALESCE(ts.team_size, 0) AS team_size,
    COALESCE(ts.budget, eh.salary) AS budget
FROM EmployeeHierarchy eh
LEFT JOIN TeamStats ts
    ON eh.employee_id = ts.employee_id
ORDER BY
    eh.level ASC,
    budget DESC,
    eh.employee_name ASC;
