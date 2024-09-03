<div align="center" id="top"> 
  <img src="./img/logo.png" alt="img-logo" style="width:750px; height:250px;" />

  &#xa0;

</div>

<h1 align="center">DBT e Elementary</h1>

<p align="center">
  <img alt="Github top language" src="https://img.shields.io/github/languages/top/Pedrinhonitz/dbt_project?color=56BEB8&logo=github">

  <img alt="Github language count" src="https://img.shields.io/github/languages/count/Pedrinhonitz/dbt_project?color=56BEB8&logo=github">

  <img alt="Repository size" src="https://img.shields.io/github/repo-size/Pedrinhonitz/dbt_project?color=56BEB8&logo=github">
</p>

<p align="center">
  <a href="#dart-sobre">Sobre</a> &#xa0; | &#xa0; 
  <a href="#rocket-tecnologias">Tecnologias</a> &#xa0; | &#xa0;
  <a href="#white_check_mark-como-usar">Como Usar</a> &#xa0; | &#xa0;
  <a href="#gear-comandos-para-instala%C3%A7%C3%A3o-e-execu%C3%A7%C3%A3o">Comandos para Instalação e Execução</a> &#xa0; | &#xa0;
  <a href="#books-padr%C3%B5es-de-commits">Padrões de Commits</a> &#xa0; | &#xa0;
  <a href="https://github.com/Pedrinhonitz" target="_blank">Autor</a>
</p>

<br>

## :dart: Sobre ##

Este projeto configura um ambiente de análise de dados utilizando DBT (Data Build Tool) em um banco de dados PostgreSQL. O objetivo é transformar dados brutos em insights significativos através de uma série de modelos e transformações SQL. A integração com o Elementary permite uma gestão eficiente dos modelos e visualizações, promovendo práticas de engenharia de dados modernas e colaborativas.

## :rocket: Tecnologias ##

As seguintes ferramentas foram utilizadas neste projeto:

- [DBT](https://www.getdbt.com/)
- [PostgreSQL](https://www.postgresql.org/)
- [SQL](https://www.postgresql.org/docs/current/sql.html)
- [Python](https://www.python.org/)
- [Docker](https://www.docker.com/)
- [Jinja](https://jinja.palletsprojects.com/en/3.1.x/)
- [Elementary](https://www.elementary-data.com/)

## :white_check_mark: Como Usar ##
```bash
# Clone
$ git clone https://github.com/Pedrinhonitz/dbt_project.git

# Entrando na Pasta
$ cd dbt_project

# Abrindo no VScode
$ code .

# Entrando na CLI do DBT
$ cd my_dbt_project

# Testando os Modelos
$ dbt debug

# Executando os Modelos
$ dbt run
```

## :gear: Comandos para Instalação e Execução ##

Instalando o Docker
```bash
# Atualiza o Pacote de Instalação
$ sudo apt-get update

# Instala o Docker
$ sudo apt-get install -y docker.io

# Inicia o Docker
$ sudo systemctl start docker

# Configura para o Docker Execucar sempre que o Sistema Iniciar
$ sudo systemctl enable docker

# Adiciona um grupo para o Docker
$ sudo groupadd docker

# Liberação das Perimissões para o Grupo do Docker
$ sudo usermod -aG docker $USER

# Altera a Sessão de Usuário para o Grupo Docker
$ newgrp docker
```

Criando container com PostgreSQL
```bash
# Baixando um container Docker com o PostgreSQL
$ docker run --name postgres-dbt -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
```

Configurando Env
```bash
# Instalando o pip
$ sudo apt-get install -y python3-pip

# Instalando o Virtual Env pelo PIP
$ pip3 install virtualenv

# Instalando o Python Venv pelo Pacote do Ubuntu
$ sudo apt-get install -y python3-venv

# Cria uma VENV com o nome de dbt-env
$ python3 -m venv dbt-env

# Ativa a venv
$ source dbt-env/bin/activate
```

Instalando o DBT para o PostgreSQL
```bash
# Instala o DBT para o PostgreSQL
$ pip install dbt-postgres

# Tendo os Seguintes Casos Possiveis
# dbt-postgres
# dbt-bigquery
# dbt-snowflake
# dbt-redshift
# dbt-athena
# dbt-exasol
# dbt-databricks
# dbt-spark
# dbt-mysql
# dbt-oracle
```

Criando o projeto DBT
```bash
# Cria a estrutura DBT, caso precise
$ dbt init my_dbt_project

# Entra na Estrutura DBT
$ cd my_dbt_project
```

Conectando no container Postgres
```bash
# Entra no container do PostgreSQL
$ docker exec -it postgres-dbt psql -U postgres

# Para alterar a senha caso precise
$ \password postgres
```

Criando Tabelas de Teste
```sql
-- Cria a Tabela public.customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);

-- Cria a Tabela public.orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    amount DECIMAL(10, 2)
);

-- Insere Dados na Tabela public.customers
INSERT INTO customers (customer_name, email) VALUES
('Alice Smith', 'alice.smith@example.com'),
('Bob Johnson', 'bob.johnson@example.com'),
('Carol Williams', 'carol.williams@example.com'),
('David Brown', 'david.brown@example.com');

-- Insere Dados na Tabela public.orders
INSERT INTO orders (customer_id, amount) VALUES
(1, 100.50),
(1, 200.75),
(2, 50.00),
(3, 75.25),
(4, 300.00),
(2, 150.40);
```

Criando os modelos DBT
```sql
-- Consulta para o modelo de Customers no seguinte diretorio: models/customers.sql
SELECT 
    customer_id, 
    customer_name, 
    email 
FROM {{ ref('customers') }};

-- Consulta para o modelo de Orders no seguinte diretorio: models/orders.sql
SELECT 
    order_id, 
    customer_id, 
    amount 
FROM {{ ref('orders') }};

-- Consulta para o modelo de Customers Orders no seguinte diretorio: models/customers_orders.sql
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
```bash
# Instala a CLI do Elementary
$ pip install elementary-data

# Apos adicionar o elementary no packages.yml, este comando ira verificar todas as dependencias
$ dbt deps

# Roda o modelo do elementary para criar as tabelas de insights
$ dbt run --select elementary

# Roda todos os modelos DBT
$ dbt run
```

Conectando ao PSQL
```bash
# Entra no container do PostgreSQL
$ docker exec -it postgres-dbt psql -U postgres
```

Verificando as tabelas pelo PSQL
```SQL
-- Mostra as tabelas existentes no schema public
SELECT 
    tablename
FROM 
    pg_tables
WHERE 
    schemaname = 'public';

-- Mostra as tabelas existentes no schema public_elementary
SELECT 
    tablename
FROM 
    pg_tables
WHERE 
    schemaname = 'public_elementary';
```

tabelas criadas no __public__
- customers
- orders
- customers_orders

tabelas criadas no __public_elementary__
- dbt_models
- dbt_sources
- test_result_rows
- dbt_run_results
- dbt_tests
- data_monitoring_metrics
- dbt_columns
- dbt_seeds
- elementary_test_results
- metadata
- dbt_exposures
- dbt_snapshots
- dbt_invocations
- dbt_metrics
- dbt_source_freshness_results
- schema_columns_snapshot

## :books: Padrões de Commits ##

<table>
  <thead>
    <tr>
      <th>Tipo de commit</th>
      <th>Emojis</th>
      <th>Palavra-chave</th>
    </tr>
  </thead>
 <tbody>
    <tr>
      <td>Correção</td>
      <td>🐛 <code>:bug:</code></td>
      <td><code>fix</code></td>
    </tr>
    <tr>
      <td>Documentação</td>
      <td>📚 <code>:books:</code></td>
      <td><code>docs</code></td>
    </tr>
    <tr>
      <td>Estrutura do Projeto</td>
      <td>🧱 <code>:bricks:</code></td>
      <td><code>ci</code></td>
    </tr>
    <tr>
      <td>Novo recurso</td>
      <td>✨ <code>:sparkles:</code></td>
      <td><code>feat</code></td>
    </tr>
    <tr>
      <td>Testes</td>
      <td>🧪 <code>:test_tube:</code></td>
      <td><code>test</code></td>
    </tr>
  </tbody>
</table>







#
Feito por <a href="https://github.com/Pedrinhonitz" target="_blank">Pedrinhonitz</a>

<a href="#top">Voltar ao topo</a>