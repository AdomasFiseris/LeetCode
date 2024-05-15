# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        dept_id,
        COUNT(student_id) AS student_number
    FROM
        Student
    GROUP BY
        dept_id
)
SELECT
    Department.dept_name,
    COALESCE(CTE.student_number, 0) AS student_number
FROM
    CTE
RIGHT JOIN
    Department ON CTE.dept_id = Department.dept_id
ORDER BY
    CTE.student_number DESC,
    Department.dept_name ASC;
