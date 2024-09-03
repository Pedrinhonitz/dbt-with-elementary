SELECT 
    customer_id, 
    customer_name, 
    email 
FROM 
    {{ source('data-lake', 'customers') }}