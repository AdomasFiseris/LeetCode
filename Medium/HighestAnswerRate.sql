# Write your MySQL query statement below
WITH CTE AS (
    SELECT
        question_id,
        COUNT(action) AS showed
    FROM
        SurveyLog
    WHERE
        action = 'show'
    GROUP BY
        question_id
), CTE_2 AS (
    SELECT
        question_id,
        COUNT(action) AS answered
    FROM
        SurveyLog
    WHERE
        action = 'answer'
    GROUP BY
        question_id
), CTE_3 AS (
    SELECT
        CTE.question_id,
        CTE.showed,
        CTE_2.answered,
        CASE 
            WHEN CTE_2.answered = 0 THEN NULL
            ELSE CAST(CTE_2.answered AS FLOAT) / CAST(CTE.showed AS FLOAT)
        END AS answer_rate
    FROM
        CTE
    JOIN
        CTE_2 ON CTE.question_id = CTE_2.question_id
    ORDER BY
        answer_rate DESC,
        question_id ASC
)
SELECT
    question_id AS survey_log
FROM
    CTE_3
LIMIT 1;
