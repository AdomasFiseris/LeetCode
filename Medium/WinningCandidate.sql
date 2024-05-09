WITH CTE AS (
    SELECT
        Candidate.name AS name,
        COUNT(Vote.id) AS vote_count
    FROM
        Candidate
    JOIN
        Vote ON Candidate.id = Vote.candidateId
    GROUP BY
        Candidate.name
    ORDER BY
        vote_count DESC
)
SELECT
    name
FROM
    CTE
LIMIT 1;
