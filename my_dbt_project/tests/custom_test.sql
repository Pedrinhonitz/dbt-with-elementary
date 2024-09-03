WITH failed_tests AS (
    SELECT COUNT(*) AS count
    FROM {{ ref('customers') }}
    WHERE customer_id > 1000
)
SELECT * FROM failed_tests
WHERE count = 0