# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        score,
        student_id,
        exam_id,
        RANK() OVER (PARTITION BY exam_id ORDER BY score DESC) AS Max_ranked,
        RANK() OVER (PARTITION BY exam_id ORDER BY score ASC) AS Min_ranked
    FROM
        Exam
)
SELECT
    Student.student_id,
    Student.student_name
FROM
    Student
RIGHT JOIN
    Exam ON Student.student_id = Exam.student_id
WHERE
    Student.student_id NOT IN (
        SELECT
            student_id
        FROM         
            (SELECT
                DISTINCT student_id,
                MIN(Max_ranked) AS Max_ranked,
                MIN(Min_ranked) AS Min_ranked
            FROM
                CTE
            GROUP BY
                student_id
            HAVING
                Max_ranked = 1 OR Min_ranked = 1
            ) AS CTE_2
    )
GROUP BY
    Student.student_id
ORDER BY
    Student.student_id;
