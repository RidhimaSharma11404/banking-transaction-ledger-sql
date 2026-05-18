# Core Banking & Transaction DB System

A production-ready MySQL database architecture designed for a modern retail banking platform. This project demonstrates advanced database design principles, data integrity constraints, automated workflows using stored procedures, and complex financial reporting queries.

Developed as a showcase portfolio project for enterprise data engineering roles.

---

## 🚀 Key Features & Architecture

The database is structured to handle high-concurrency transactional data while maintaining strict ACID compliance. 

* **Relational Schema (`01_schema.sql`)**: Implements strict data types, foreign key constraints (`ON DELETE RESTRICT`), and check constraints to prevent negative balances or invalid transaction types.
* **Mock Dataset (`02_seed_data.sql`)**: Includes realistic data covering diverse customer profiles, multi-currency accounts, and varied transaction histories (deposits, withdrawals, transfers).
* **Database Views (`03_views.sql`)**: Abstracts complex joins into high-performance views for sensitive data auditing and customer 360-degree profiles without exposing raw tables.
* **Stored Procedures (Upcoming)**: Safe, transactional wrappers for processing inter-account fund transfers with rollback capabilities on failure.

---

## 📊 Database Schema Design


The architecture revolves around 4 core pillars:
1.  **Customers**: Personal/Corporate profiles with strict identity verification tracking.
2.  **Accounts**: Multi-type account management (Savings, Checking, Loan) linked to real-time balances.
3.  **Transactions**: Immutable ledger logging every single financial movement with precise timestamps.
4.  **Branches/Employees**: Managing operational data mapping.

---

## 🛠️ How to Setup and Run

### Prerequisites
* MySQL Server (v8.0+) or any compatible SQL IDE (DBeaver, MySQL Workbench).

### Installation Steps
1. Clone the repository:
   ```bash
   git clone [https://github.com/YOUR_USERNAME/banking-transaction-ledger-sql.git](https://github.com/YOUR_USERNAME/banking-transaction-ledger-sql.git)
   cd banking-transaction-ledger-sql

### Execution:
 -- 1. Create tables and relationships
  SOURCE 01_schema.sql;

-- 2. Populate the database with realistic test data
SOURCE 02_seed_data.sql;

-- 3. Deploy optimization views and analytics reporting
SOURCE 03_views.sql;

📈 Featured Analytical Insights (Examples Included)
The project includes complex analytical queries utilizing Window Functions, Common Table Expressions (CTEs), and Aggregations to solve real business problems:
Fraud Detection: Identifying accounts with multiple high-value transactions within short windows.
Churn Risk: Flagging accounts with zero transaction activity over the last 90 days.
Monthly Financial Health: Aggregating total deposits vs. withdrawals per branch.

💡 Key Skills Demonstrated
Database Normalization: Applied 3NF (Third Normal Form) to eliminate data redundancy.
Transactional Integrity: Ensuring atomicity during fund transfers using START TRANSACTION, COMMIT, and ROLLBACK.
Performance Optimization: Strategic indexing on frequently queried columns (customer_id, transaction_date).

### Author
Ridhima Sharma
