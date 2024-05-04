# Write your MySQL query statement below
WITH RECURSIVE CTE AS (
    SELECT
        task_id,
        1 AS subtask_id
    FROM
        Tasks
    UNION ALL
    SELECT
        CTE.task_id,
        CTE.subtask_id + 1
    FROM
        CTE
    JOIN
        Tasks ON CTE.task_id = Tasks.task_id
    WHERE
        CTE.subtask_id < Tasks.subtasks_count
)
SELECT
    CTE.task_id,
    CTE.subtask_id
FROM
    CTE
LEFT JOIN Executed
  ON CTE.task_id = Executed.task_id
  AND CTE.subtask_id = Executed.subtask_id
WHERE Executed.subtask_id IS NULL;
