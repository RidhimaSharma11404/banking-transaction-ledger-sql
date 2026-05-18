-- ================================================================
--  PROJECT  : SecureBank – Banking & Transaction Management System
--  FILE     : 03_views.sql
--  PURPOSE  : Reusable views for reporting & application queries
-- ================================================================

USE securebank;

-- ────────────────────────────────────────────
-- VIEW 1: Customer Account Summary
-- Shows each customer's accounts with branch & type details
-- ────────────────────────────────────────────
CREATE OR REPLACE VIEW vw_customer_account_summary AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name)   AS customer_name,
    c.email,
    c.city,
    a.account_number,
    at.type_name                              AS account_type,
    b.branch_name,
    b.city                                    AS branch_city,
    a.balance,
    a.status                                  AS account_status,
    a.opened_on,
    CASE
        WHEN a.balance < at.min_balance THEN 'Below Minimum Balance'
        ELSE 'OK'
    END                                       AS balance_health
FROM customers c
JOIN accounts    a  ON a.customer_id = c.customer_id
JOIN account_types at ON at.type_id  = a.type_id
JOIN branches    b  ON b.branch_id   = a.branch_id;


-- ────────────────────────────────────────────
-- VIEW 2: Transaction Ledger
-- Full readable transaction history with account & customer info
-- ────────────────────────────────────────────
CREATE OR REPLACE VIEW vw_transaction_ledger AS
SELECT
    t.txn_id,
    t.reference_no,
    a.account_number,
    CONCAT(c.first_name, ' ', c.last_name)   AS customer_name,
    t.txn_type,
    t.amount,
    t.balance_after,
    t.channel,
    t.status,
    t.description,
    t.txn_date,
    CONCAT(e.first_name, ' ', e.last_name)   AS processed_by
FROM transactions t
JOIN accounts  a ON a.account_id  = t.account_id
JOIN customers c ON c.customer_id = a.customer_id
LEFT JOIN employees e ON e.employee_id = t.performed_by;


-- ────────────────────────────────────────────
-- VIEW 3: Branch Performance Summary
-- Total accounts, total deposits, total transactions per branch
-- ────────────────────────────────────────────
CREATE OR REPLACE VIEW vw_branch_performance AS
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.ifsc_code,
    COUNT(DISTINCT a.account_id)              AS total_accounts,
    COUNT(DISTINCT c.customer_id)             AS total_customers,
    COALESCE(SUM(a.balance), 0)               AS total_deposits,
    COUNT(DISTINCT e.employee_id)             AS total_employees,
    COUNT(DISTINCT t.txn_id)                  AS total_transactions
FROM branches b
LEFT JOIN accounts     a ON a.branch_id   = b.branch_id AND a.status = 'Active'
LEFT JOIN customers    c ON c.customer_id = a.customer_id
LEFT JOIN employees    e ON e.branch_id   = b.branch_id
LEFT JOIN transactions t ON t.account_id  = a.account_id AND t.status = 'Success'
GROUP BY b.branch_id, b.branch_name, b.city, b.ifsc_code;


-- ────────────────────────────────────────────
-- VIEW 4: Loan Portfolio
-- All loans with customer, branch, and repayment progress
-- ────────────────────────────────────────────
CREATE OR REPLACE VIEW vw_loan_portfolio AS
SELECT
    l.loan_id,
    CONCAT(c.first_name, ' ', c.last_name)   AS customer_name,
    c.email,
    b.branch_name,
    l.loan_type,
    l.principal,
    l.interest_rate,
    l.tenure_months,
    l.emi_amount,
    l.disbursed_on,
    l.status                                  AS loan_status,
    COALESCE(SUM(r.amount_paid), 0)           AS total_repaid,
    l.principal - COALESCE(SUM(r.principal_part), 0) AS outstanding_principal,
    CONCAT(e.first_name, ' ', e.last_name)   AS approved_by
FROM loans l
JOIN customers c ON c.customer_id = l.customer_id
JOIN branches  b ON b.branch_id   = l.branch_id
LEFT JOIN loan_repayments r ON r.loan_id    = l.loan_id
LEFT JOIN employees       e ON e.employee_id= l.approved_by
GROUP BY l.loan_id, c.first_name, c.last_name, c.email,
         b.branch_name, l.loan_type, l.principal, l.interest_rate,
         l.tenure_months, l.emi_amount, l.disbursed_on, l.status,
         e.first_name, e.last_name;


-- ────────────────────────────────────────────
-- VIEW 5: Monthly Transaction Volume
-- Aggregated by month & channel — useful for dashboards
-- ────────────────────────────────────────────
CREATE OR REPLACE VIEW vw_monthly_txn_volume AS
SELECT
    DATE_FORMAT(txn_date, '%Y-%m')            AS txn_month,
    txn_type,
    channel,
    COUNT(*)                                  AS txn_count,
    SUM(amount)                               AS total_amount,
    AVG(amount)                               AS avg_amount,
    SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END) AS failed_count
FROM transactions
GROUP BY txn_month, txn_type, channel
ORDER BY txn_month DESC;


-- ────────────────────────────────────────────
-- VIEW 6: High Value Customers
-- Customers whose total balance across all accounts > 1,00,000
-- ────────────────────────────────────────────
CREATE OR REPLACE VIEW vw_high_value_customers AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name)   AS customer_name,
    c.email,
    c.city,
    COUNT(a.account_id)                       AS num_accounts,
    SUM(a.balance)                            AS total_balance,
    MAX(a.balance)                            AS highest_single_balance,
    GROUP_CONCAT(at.type_name ORDER BY at.type_name SEPARATOR ', ') AS account_types_held
FROM customers c
JOIN accounts      a  ON a.customer_id = c.customer_id AND a.status = 'Active'
JOIN account_types at ON at.type_id    = a.type_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city
HAVING SUM(a.balance) > 100000
ORDER BY total_balance DESC;