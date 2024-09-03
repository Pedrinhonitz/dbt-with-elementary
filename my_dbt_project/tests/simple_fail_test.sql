SELECT COUNT(*) AS count
FROM {{ ref('customers') }}
WHERE customer_id = -1