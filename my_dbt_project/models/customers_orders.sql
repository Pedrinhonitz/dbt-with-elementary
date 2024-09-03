WITH customers AS (
    SELECT 
        * 
    FROM 
        {{ ref('customers') }}
),
orders AS (
    SELECT 
        * 
    FROM 
        {{ ref('orders') }}
)
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS number_of_orders,
    SUM(o.amount) AS total_spent
FROM 
    customers AS c
LEFT JOIN orders AS o ON 
    c.customer_id = o.customer_id
GROUP BY 
    c.customer_name