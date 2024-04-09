# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        student_id,
        course_id,
        grade,
        RANK() OVER (PARTITION by student_id ORDER BY grade DESC) AS ranked
    FROM
        Enrollments
)
SELECT
    student_id,
    MIN(course_id) AS course_id,
    grade
FROM
    CTE
WHERE
    ranked = 1
GROUP BY
    student_id
