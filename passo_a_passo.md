Installando o Docker
```shell
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
```

Criando container com PostgreSQL
```shell
docker run --name postgres-dbt -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d postgres
```
Configurando Env
```shell
sudo apt-get install -y python3-pip
pip3 install virtualenv
sudo apt-get install -y python3-venv
python3 -m venv dbt-env
source dbt-env/bin/activate
```
Instalando o DBT para o PostgreSQL
```shell
pip install dbt-postgres
```
Criando o projeto DBT
```shell
dbt init my_dbt_project
cd my_dbt_project
```
Conectando no container Postgres
```shell
docker exec -it postgres-dbt psql -U postgres
# Para alterar a senha caso precise
\password postgres
```
Criando tabelas de teste
```sql
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    amount DECIMAL(10, 2)
);
```
Criando os modelos DBT
```sql
-- customers.sql
SELECT 
    customer_id, 
    customer_name, 
    email 
FROM {{ ref('customers') }};

-- orders.sql
SELECT 
    order_id, 
    customer_id, 
    amount 
FROM {{ ref('orders') }};

-- customers_orders.sql
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
    c.customer_name;
```
Instalando, Configurando e Testando o Elementary
```shell
pip install elementary-data
edr init
edr start
dbt run
edr test
```