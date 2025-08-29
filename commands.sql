CREATE TABLE branches (
    branch_id INT PRIMARY KEY,
    branch_name TEXT
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    branch_id INT,
    customer_name TEXT,
    join_date DATE
);

CREATE TABLE deposits (
    deposit_id INT PRIMARY KEY,
    branch_id INT,
    customer_id INT,
    deposit_type TEXT,
    amount DECIMAL(12,2),
    deposit_date DATE
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    branch_id INT,
    customer_id INT,
    principal DECIMAL(12,2),
    status TEXT,
    loan_date DATE
);

SELECT d.branch_id, b.branch_name,
ROUND(SUM(CASE WHEN deposit_type IN ('Current','Savings') THEN amount ELSE 0 END) * 100.0 / SUM(amount),2) AS casa_ratio
FROM deposits d JOIN branches b ON d.branch_id = b.branch_id
GROUP BY d.branch_id, b.branch_name;

SELECT l.branch_id, b.branch_name,
ROUND(SUM(l.principal) * 100.0 / (SELECT SUM(amount) FROM deposits d WHERE d.branch_id = l.branch_id),2) AS loan_deposit_ratio
FROM loans l JOIN branches b ON l.branch_id = b.branch_id
GROUP BY l.branch_id, b.branch_name;

SELECT l.branch_id, b.branch_name,
ROUND(SUM(CASE WHEN l.status = 'npa' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS npa_percent
FROM loans l JOIN branches b ON l.branch_id = b.branch_id
GROUP BY l.branch_id, b.branch_name;

SELECT d.branch_id, b.branch_name, SUM(d.amount) as total_deposits
FROM deposits d JOIN branches b ON d.branch_id = b.branch_id
GROUP BY d.branch_id, b.branch_name;

SELECT l.branch_id, b.branch_name, SUM(l.principal) as total_loans
FROM loans l JOIN branches b ON l.branch_id = b.branch_id
GROUP BY l.branch_id, b.branch_name;

SELECT branch_id, COUNT(*) as total_customers
FROM customers
GROUP BY branch_id;

SELECT l.branch_id, b.branch_name,
ROUND(SUM(l.principal)*0.1 - SUM(CASE WHEN l.status='npa' THEN l.principal*0.5 ELSE 0 END),2) AS profitability_index
FROM loans l JOIN branches b ON l.branch_id = b.branch_id
GROUP BY l.branch_id, b.branch_name;