-- ================================================================
--  PROJECT  : SecureBank – Banking & Transaction Management System
--  FILE     : 01_schema.sql
--  PURPOSE  : Create all tables with constraints, indexes & relationships
--  Author   : [Your Name]  |  Cognizant MySQL Demo
-- ================================================================

DROP DATABASE IF EXISTS securebank;
CREATE DATABASE securebank
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE securebank;

-- ────────────────────────────────────────────
-- 1. BRANCHES
-- ────────────────────────────────────────────
CREATE TABLE branches (
    branch_id    INT          AUTO_INCREMENT PRIMARY KEY,
    branch_name  VARCHAR(120) NOT NULL,
    city         VARCHAR(100) NOT NULL,
    state        VARCHAR(100) NOT NULL,
    ifsc_code    VARCHAR(20)  NOT NULL UNIQUE,
    phone        VARCHAR(20),
    opened_on    DATE         NOT NULL DEFAULT (CURRENT_DATE)
);

-- ────────────────────────────────────────────
-- 2. CUSTOMERS
-- ────────────────────────────────────────────
CREATE TABLE customers (
    customer_id   INT          AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(100) NOT NULL,
    last_name     VARCHAR(100) NOT NULL,
    dob           DATE         NOT NULL,
    gender        ENUM('Male','Female','Other') NOT NULL,
    email         VARCHAR(150) NOT NULL UNIQUE,
    phone         VARCHAR(20)  NOT NULL,
    address       TEXT,
    city          VARCHAR(100),
    pan_number    VARCHAR(10)  UNIQUE,          -- India-specific identity
    kyc_verified  TINYINT(1)   NOT NULL DEFAULT 0,
    created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_cust_email (email),
    INDEX idx_cust_phone (phone)
);

-- ────────────────────────────────────────────
-- 3. ACCOUNT TYPES  (lookup)
-- ────────────────────────────────────────────
CREATE TABLE account_types (
    type_id          INT         AUTO_INCREMENT PRIMARY KEY,
    type_name        VARCHAR(60) NOT NULL UNIQUE,  -- Savings, Current, FD, Loan
    interest_rate    DECIMAL(5,2) DEFAULT 0.00,    -- annual %
    min_balance      DECIMAL(12,2) DEFAULT 0.00,
    overdraft_limit  DECIMAL(12,2) DEFAULT 0.00
);

-- ────────────────────────────────────────────
-- 4. ACCOUNTS
-- ────────────────────────────────────────────
CREATE TABLE accounts (
    account_id      INT            AUTO_INCREMENT PRIMARY KEY,
    account_number  VARCHAR(20)    NOT NULL UNIQUE,
    customer_id     INT            NOT NULL,
    branch_id       INT            NOT NULL,
    type_id         INT            NOT NULL,
    balance         DECIMAL(14,2)  NOT NULL DEFAULT 0.00,
    status          ENUM('Active','Frozen','Closed') NOT NULL DEFAULT 'Active',
    opened_on       DATE           NOT NULL DEFAULT (CURRENT_DATE),
    closed_on       DATE           DEFAULT NULL,
    CONSTRAINT fk_acc_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT,
    CONSTRAINT fk_acc_branch   FOREIGN KEY (branch_id)   REFERENCES branches(branch_id)    ON DELETE RESTRICT,
    CONSTRAINT fk_acc_type     FOREIGN KEY (type_id)     REFERENCES account_types(type_id) ON DELETE RESTRICT,
    INDEX idx_acc_customer (customer_id),
    INDEX idx_acc_status   (status)
);

-- ────────────────────────────────────────────
-- 5. EMPLOYEES  (bank staff)
-- ────────────────────────────────────────────
CREATE TABLE employees (
    employee_id  INT          AUTO_INCREMENT PRIMARY KEY,
    branch_id    INT          NOT NULL,
    first_name   VARCHAR(100) NOT NULL,
    last_name    VARCHAR(100) NOT NULL,
    email        VARCHAR(150) NOT NULL UNIQUE,
    role         ENUM('Teller','Manager','Loan Officer','Auditor') NOT NULL,
    salary       DECIMAL(10,2),
    joined_on    DATE         NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_emp_branch FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- ────────────────────────────────────────────
-- 6. TRANSACTIONS
-- ────────────────────────────────────────────
CREATE TABLE transactions (
    txn_id           INT            AUTO_INCREMENT PRIMARY KEY,
    account_id       INT            NOT NULL,
    txn_type         ENUM('Credit','Debit','Transfer','Interest','Fee') NOT NULL,
    amount           DECIMAL(14,2)  NOT NULL CHECK (amount > 0),
    balance_after    DECIMAL(14,2)  NOT NULL,
    reference_no     VARCHAR(40)    NOT NULL UNIQUE,   -- UTR / IMPS ref
    description      VARCHAR(255),
    channel          ENUM('Branch','ATM','NetBanking','MobileBanking','UPI') DEFAULT 'Branch',
    status           ENUM('Success','Failed','Pending','Reversed') NOT NULL DEFAULT 'Success',
    txn_date         DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    performed_by     INT            DEFAULT NULL,      -- employee_id if branch txn
    CONSTRAINT fk_txn_account  FOREIGN KEY (account_id)   REFERENCES accounts(account_id)   ON DELETE RESTRICT,
    CONSTRAINT fk_txn_employee FOREIGN KEY (performed_by) REFERENCES employees(employee_id)  ON DELETE SET NULL,
    INDEX idx_txn_account  (account_id),
    INDEX idx_txn_date     (txn_date),
    INDEX idx_txn_status   (status),
    INDEX idx_txn_channel  (channel)
);

-- ────────────────────────────────────────────
-- 7. TRANSFERS  (links two transaction rows)
-- ────────────────────────────────────────────
CREATE TABLE transfers (
    transfer_id      INT           AUTO_INCREMENT PRIMARY KEY,
    from_account_id  INT           NOT NULL,
    to_account_id    INT           NOT NULL,
    debit_txn_id     INT           NOT NULL UNIQUE,
    credit_txn_id    INT           NOT NULL UNIQUE,
    amount           DECIMAL(14,2) NOT NULL,
    transfer_mode    ENUM('NEFT','RTGS','IMPS','UPI','Internal') NOT NULL DEFAULT 'IMPS',
    initiated_at     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_tr_from    FOREIGN KEY (from_account_id) REFERENCES accounts(account_id),
    CONSTRAINT fk_tr_to      FOREIGN KEY (to_account_id)   REFERENCES accounts(account_id),
    CONSTRAINT fk_tr_debit   FOREIGN KEY (debit_txn_id)    REFERENCES transactions(txn_id),
    CONSTRAINT fk_tr_credit  FOREIGN KEY (credit_txn_id)   REFERENCES transactions(txn_id)
);

-- ────────────────────────────────────────────
-- 8. LOANS
-- ────────────────────────────────────────────
CREATE TABLE loans (
    loan_id          INT            AUTO_INCREMENT PRIMARY KEY,
    customer_id      INT            NOT NULL,
    branch_id        INT            NOT NULL,
    loan_type        ENUM('Home','Personal','Vehicle','Education','Business') NOT NULL,
    principal        DECIMAL(14,2)  NOT NULL,
    interest_rate    DECIMAL(5,2)   NOT NULL,    -- annual %
    tenure_months    INT            NOT NULL,
    emi_amount       DECIMAL(12,2)  NOT NULL,
    disbursed_on     DATE,
    status           ENUM('Applied','Approved','Disbursed','Closed','Rejected') DEFAULT 'Applied',
    approved_by      INT            DEFAULT NULL,
    CONSTRAINT fk_loan_customer  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_loan_branch    FOREIGN KEY (branch_id)   REFERENCES branches(branch_id),
    CONSTRAINT fk_loan_approver  FOREIGN KEY (approved_by) REFERENCES employees(employee_id)
);

-- ────────────────────────────────────────────
-- 9. LOAN REPAYMENTS
-- ────────────────────────────────────────────
CREATE TABLE loan_repayments (
    repayment_id   INT            AUTO_INCREMENT PRIMARY KEY,
    loan_id        INT            NOT NULL,
    paid_on        DATE           NOT NULL,
    amount_paid    DECIMAL(12,2)  NOT NULL,
    principal_part DECIMAL(12,2)  NOT NULL,
    interest_part  DECIMAL(12,2)  NOT NULL,
    outstanding    DECIMAL(14,2)  NOT NULL,
    CONSTRAINT fk_repay_loan FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

-- ────────────────────────────────────────────
-- 10. AUDIT LOG  (tracks sensitive changes)
-- ────────────────────────────────────────────
CREATE TABLE audit_log (
    log_id      INT          AUTO_INCREMENT PRIMARY KEY,
    table_name  VARCHAR(100) NOT NULL,
    action      ENUM('INSERT','UPDATE','DELETE') NOT NULL,
    record_id   INT          NOT NULL,
    old_data    JSON,
    new_data    JSON,
    changed_by  VARCHAR(100) DEFAULT 'SYSTEM',
    changed_at  DATETIME     DEFAULT CURRENT_TIMESTAMP
);