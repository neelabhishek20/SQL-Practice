WITH week_meeting_hours AS (
    SELECT
        employee_id,
        YEAR(meeting_date) AS year,
        WEEK(meeting_date, 1) AS week,
        SUM(duration_hours) AS hours
    FROM meetings
    GROUP BY employee_id, YEAR(meeting_date), WEEK(meeting_date, 1)
),

intensive_weeks AS (
    SELECT
        w.employee_id,
        e.employee_name,
        e.department,
        COUNT(*) AS meeting_heavy_weeks
    FROM week_meeting_hours w
    JOIN employees e
        ON w.employee_id = e.employee_id
    WHERE w.hours > 20
    GROUP BY
        w.employee_id,
        e.employee_name,
        e.department
)

SELECT
    employee_id,
    employee_name,
    department,
    meeting_heavy_weeks
FROM intensive_weeks
WHERE meeting_heavy_weeks >= 2
ORDER BY
    meeting_heavy_weeks DESC,
    employee_name ASC;
