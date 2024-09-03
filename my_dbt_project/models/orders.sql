SELECT 
    order_id, 
    customer_id, 
    amount 
FROM 
    {{ source('data-lake', 'orders') }}