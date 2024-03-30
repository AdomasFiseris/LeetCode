# Write your MySQL query statement below
WITH NodeType AS (
    SELECT
        Tree.id,
        CASE
            WHEN ParentNode.id IS NULL THEN 'Root'
            WHEN ChildNode.id IS NULL THEN 'Leaf'
            ELSE 'Inner'
        END AS Type
    FROM
        Tree
    LEFT JOIN Tree AS ParentNode ON Tree.p_id = ParentNode.id
    LEFT JOIN Tree AS ChildNode ON Tree.id = ChildNode.p_id
    GROUP BY Tree.id
)
SELECT
    id,
    MAX(Type) AS Type
FROM
    NodeType
GROUP BY
    id;