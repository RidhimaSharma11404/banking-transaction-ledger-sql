-- ================================================================
--  PROJECT  : SecureBank – Banking & Transaction Management System
--  FILE     : 02_seed_data.sql
--  PURPOSE  : Realistic sample data for all tables
-- ================================================================

USE securebank;

-- ── Account Types ────────────────────────────────────────────
INSERT INTO account_types (type_name, interest_rate, min_balance, overdraft_limit) VALUES
('Savings',         3.50,  1000.00,     0.00),
('Current',         0.00,  5000.00, 50000.00),
('Fixed Deposit',   7.00,  5000.00,     0.00),
('Salary Account',  3.00,     0.00,     0.00),
('Loan Account',    0.00,     0.00,     0.00);

-- ── Branches ─────────────────────────────────────────────────
INSERT INTO branches (branch_name, city, state, ifsc_code, phone, opened_on) VALUES
('MG Road Main Branch',     'Bengaluru',  'Karnataka',    'SCBK0001001', '080-41234567', '2005-04-01'),
('Nariman Point Branch',    'Mumbai',     'Maharashtra',  'SCBK0001002', '022-22345678', '2003-07-15'),
('Connaught Place Branch',  'New Delhi',  'Delhi',        'SCBK0001003', '011-23456789', '2004-01-10'),
('Anna Nagar Branch',       'Chennai',    'Tamil Nadu',   'SCBK0001004', '044-24567890', '2006-09-20'),
('Salt Lake Branch',        'Kolkata',    'West Bengal',  'SCBK0001005', '033-25678901', '2007-03-05'),
('Banjara Hills Branch',    'Hyderabad',  'Telangana',    'SCBK0001006', '040-26789012', '2008-11-30');

-- ── Customers ────────────────────────────────────────────────
INSERT INTO customers (first_name, last_name, dob, gender, email, phone, city, pan_number, kyc_verified) VALUES
('Aarav',    'Sharma',      '1990-05-14', 'Male',   'aarav.sharma@gmail.com',    '9811001001', 'New Delhi',  'ABCPS1234A', 1),
('Priya',    'Nair',        '1988-11-22', 'Female', 'priya.nair@gmail.com',      '9822002002', 'Bengaluru',  'BCDPN2345B', 1),
('Rohan',    'Mehta',       '1995-03-08', 'Male',   'rohan.mehta@yahoo.com',     '9833003003', 'Mumbai',     'CDEPM3456C', 1),
('Sanya',    'Iyer',        '1992-07-19', 'Female', 'sanya.iyer@gmail.com',      '9844004004', 'Chennai',    'DEFSI4567D', 1),
('Karthik',  'Reddy',       '1985-01-30', 'Male',   'karthik.reddy@outlook.com', '9855005005', 'Hyderabad',  'EFGKR5678E', 1),
('Deepa',    'Banerjee',    '1993-09-12', 'Female', 'deepa.banerjee@gmail.com',  '9866006006', 'Kolkata',    'FGHDB6789F', 1),
('Vivek',    'Joshi',       '1989-04-25', 'Male',   'vivek.joshi@gmail.com',     '9877007007', 'Pune',       'GHIVJ7890G', 1),
('Anjali',   'Gupta',       '1997-12-03', 'Female', 'anjali.gupta@gmail.com',    '9888008008', 'Lucknow',    'HIJAG8901H', 0),
('Suresh',   'Pillai',      '1980-06-17', 'Male',   'suresh.pillai@gmail.com',   '9899009009', 'Kochi',      'IJKSP9012I', 1),
('Meera',    'Choudhary',   '1994-08-28', 'Female', 'meera.choud@gmail.com',     '9900010010', 'Jaipur',     'JKLMC0123J', 1),
('Arjun',    'Singh',       '1991-02-14', 'Male',   'arjun.singh@gmail.com',     '9811011011', 'Chandigarh', 'KLMAS1234K', 1),
('Pooja',    'Desai',       '1996-10-09', 'Female', 'pooja.desai@gmail.com',     '9822012012', 'Ahmedabad',  'LMNPD2345L', 1);

-- ── Employees ────────────────────────────────────────────────
INSERT INTO employees (branch_id, first_name, last_name, email, role, salary, joined_on) VALUES
(1, 'Rajesh',  'Kumar',    'rajesh.kumar@securebank.in',   'Manager',      95000.00, '2010-06-01'),
(1, 'Nisha',   'Verma',    'nisha.verma@securebank.in',    'Teller',       38000.00, '2018-03-15'),
(2, 'Anil',    'Patil',    'anil.patil@securebank.in',     'Manager',      92000.00, '2011-09-10'),
(2, 'Sunita',  'Rao',      'sunita.rao@securebank.in',     'Teller',       37000.00, '2019-01-20'),
(3, 'Manish',  'Aggarwal', 'manish.agg@securebank.in',     'Manager',      98000.00, '2009-04-05'),
(3, 'Kavita',  'Bose',     'kavita.bose@securebank.in',    'Loan Officer', 55000.00, '2015-07-22'),
(4, 'Sunil',   'Das',      'sunil.das@securebank.in',      'Manager',      90000.00, '2012-11-30'),
(4, 'Rekha',   'Menon',    'rekha.menon@securebank.in',    'Teller',       36000.00, '2020-02-10'),
(5, 'Prakash', 'Ghosh',    'prakash.ghosh@securebank.in',  'Auditor',      62000.00, '2014-05-18'),
(6, 'Lalita',  'Sharma',   'lalita.sharma@securebank.in',  'Manager',      91000.00, '2013-08-25');

-- ── Accounts ─────────────────────────────────────────────────
INSERT INTO accounts (account_number, customer_id, branch_id, type_id, balance, status, opened_on) VALUES
('ACC1000000001',  1,  1, 1,  85000.00,  'Active', '2015-03-10'),
('ACC1000000002',  1,  1, 2, 200000.00,  'Active', '2016-07-22'),
('ACC1000000003',  2,  1, 1,  42000.00,  'Active', '2017-01-15'),
('ACC1000000004',  3,  2, 4,  65000.00,  'Active', '2018-06-01'),
('ACC1000000005',  4,  4, 1,  33500.00,  'Active', '2016-09-30'),
('ACC1000000006',  5,  6, 2, 450000.00,  'Active', '2014-12-05'),
('ACC1000000007',  6,  5, 1,  18200.00,  'Active', '2019-04-18'),
('ACC1000000008',  7,  1, 1,  97000.00,  'Active', '2015-11-11'),
('ACC1000000009',  8,  3, 4,  55000.00,  'Active', '2020-08-20'),
('ACC1000000010',  9,  4, 1,  12800.00,  'Active', '2018-02-28'),
('ACC1000000011', 10,  2, 3, 500000.00,  'Active', '2021-01-10'),
('ACC1000000012', 11,  3, 1,  73000.00,  'Active', '2017-07-07'),
('ACC1000000013', 12,  2, 4,  88000.00,  'Active', '2019-10-15'),
('ACC1000000014',  2,  1, 3, 150000.00,  'Active', '2022-05-01'),
('ACC1000000015',  5,  6, 1,  25000.00,  'Frozen', '2020-03-22');

-- ── Transactions ─────────────────────────────────────────────
INSERT INTO transactions (account_id, txn_type, amount, balance_after, reference_no, description, channel, status, txn_date, performed_by) VALUES
-- Aarav's Savings
( 1,'Credit', 50000.00,  85000.00,'REF20240101001','Opening deposit',         'Branch',       'Success','2024-01-05 10:15:00', 2),
( 1,'Debit',  10000.00,  75000.00,'REF20240102002','ATM withdrawal',          'ATM',          'Success','2024-01-10 14:30:00', NULL),
( 1,'Credit', 20000.00,  95000.00,'REF20240103003','Salary credit',           'NetBanking',   'Success','2024-02-01 09:00:00', NULL),
( 1,'Debit',  10000.00,  85000.00,'REF20240104004','UPI payment - Swiggy',    'UPI',          'Success','2024-02-14 19:45:00', NULL),

-- Aarav's Current
( 2,'Credit',200000.00, 200000.00,'REF20240105005','Business deposit',        'Branch',       'Success','2024-01-06 11:00:00', 2),

-- Priya's Savings
( 3,'Credit', 42000.00,  42000.00,'REF20240106006','Opening deposit',         'Branch',       'Success','2024-01-08 10:30:00', 2),
( 3,'Debit',   5000.00,  37000.00,'REF20240107007','Online shopping',         'NetBanking',   'Success','2024-02-20 16:00:00', NULL),
( 3,'Credit',  5000.00,  42000.00,'REF20240108008','Transfer received',       'MobileBanking','Success','2024-03-01 08:00:00', NULL),

-- Rohan's Salary
( 4,'Credit', 65000.00,  65000.00,'REF20240109009','Salary April',            'NetBanking',   'Success','2024-04-01 09:00:00', NULL),
( 4,'Debit',  12000.00,  53000.00,'REF20240110010','Rent payment',            'NetBanking',   'Success','2024-04-05 10:00:00', NULL),
( 4,'Debit',   8000.00,  45000.00,'REF20240111011','Credit card bill',        'MobileBanking','Success','2024-04-15 12:00:00', NULL),
( 4,'Credit', 20000.00,  65000.00,'REF20240112012','Salary May',              'NetBanking',   'Success','2024-05-01 09:00:00', NULL),

-- Sanya's Savings
( 5,'Credit', 33500.00,  33500.00,'REF20240113013','Opening deposit',         'Branch',       'Success','2024-01-15 11:00:00', 8),
( 5,'Debit',   3000.00,  30500.00,'REF20240114014','ATM withdrawal',          'ATM',          'Success','2024-03-10 15:00:00', NULL),

-- Karthik's Current
( 6,'Credit',450000.00, 450000.00,'REF20240115015','Business capital',        'Branch',       'Success','2024-01-03 09:30:00', NULL),
( 6,'Debit', 100000.00, 350000.00,'REF20240116016','Vendor payment',          'RTGS',         'Success','2024-02-10 14:00:00', NULL),
( 6,'Credit', 200000.00,550000.00,'REF20240117017','Client payment received', 'RTGS',         'Success','2024-03-15 11:30:00', NULL),
( 6,'Debit',  100000.00,450000.00,'REF20240118018','Tax payment',             'NetBanking',   'Success','2024-04-20 10:00:00', NULL),

-- Deepa
( 7,'Credit', 18200.00,  18200.00,'REF20240119019','Opening deposit',         'Branch',       'Success','2024-02-05 10:00:00', 9),

-- Vivek
( 8,'Credit', 97000.00,  97000.00,'REF20240120020','Salary credit',           'NetBanking',   'Success','2024-01-31 09:00:00', NULL),
( 8,'Debit',  20000.00,  77000.00,'REF20240121021','Home loan EMI',           'NetBanking',   'Success','2024-02-05 09:00:00', NULL),
( 8,'Debit',  10000.00,  67000.00,'REF20240122022','Investment - MF',         'NetBanking',   'Failed', '2024-02-08 10:00:00', NULL),

-- Anjali
( 9,'Credit', 55000.00,  55000.00,'REF20240123023','Initial deposit',         'Branch',       'Success','2024-03-01 09:00:00', 5),

-- Suresh
(10,'Credit', 12800.00,  12800.00,'REF20240124024','Opening deposit',         'Branch',       'Success','2024-01-20 11:00:00', 8),
(10,'Debit',   2000.00,  10800.00,'REF20240125025','UPI - utility bill',      'UPI',          'Success','2024-03-25 18:00:00', NULL),

-- Meera FD
(11,'Credit',500000.00, 500000.00,'REF20240126026','Fixed deposit creation',  'Branch',       'Success','2024-01-10 10:00:00', 4),
(11,'Credit',  8750.00, 508750.00,'REF20240127027','Interest credit Q1',      'NetBanking',   'Success','2024-04-10 09:00:00', NULL),

-- Arjun
(12,'Credit', 73000.00,  73000.00,'REF20240128028','Salary credit',           'NetBanking',   'Success','2024-01-31 09:00:00', NULL),
(12,'Debit',  15000.00,  58000.00,'REF20240129029','EMI deduction',           'NetBanking',   'Success','2024-02-05 09:00:00', NULL),

-- Pooja Salary
(13,'Credit', 88000.00,  88000.00,'REF20240130030','April salary',            'NetBanking',   'Success','2024-04-01 09:00:00', NULL),
(13,'Debit',  22000.00,  66000.00,'REF20240131031','Rent + utilities',        'UPI',          'Success','2024-04-07 08:00:00', NULL);

-- ── Transfers ────────────────────────────────────────────────
-- Rohan → Priya (Internal)
INSERT INTO transactions (account_id, txn_type, amount, balance_after, reference_no, description, channel, status, txn_date) VALUES
(4, 'Debit',  5000.00, 60000.00, 'TRF20240201001', 'Transfer to Priya Nair',     'MobileBanking', 'Success', '2024-03-01 07:55:00'),
(3, 'Credit', 5000.00, 42000.00, 'TRF20240201002', 'Transfer from Rohan Mehta',  'MobileBanking', 'Success', '2024-03-01 08:00:00');

INSERT INTO transfers (from_account_id, to_account_id, debit_txn_id, credit_txn_id, amount, transfer_mode, initiated_at) VALUES
(4, 3, 33, 34, 5000.00, 'IMPS', '2024-03-01 07:55:00');

-- ── Loans ────────────────────────────────────────────────────
INSERT INTO loans (customer_id, branch_id, loan_type, principal, interest_rate, tenure_months, emi_amount, disbursed_on, status, approved_by) VALUES
(1,  1, 'Home',     5000000.00, 8.50, 240, 43391.00, '2022-06-01', 'Disbursed', 1),
(7,  1, 'Personal',  300000.00, 12.00, 36,   9964.00, '2023-01-15', 'Disbursed', 1),
(3,  2, 'Vehicle',   700000.00, 9.50,  60,  14668.00, '2023-08-10', 'Disbursed', 3),
(10, 2, 'Education', 400000.00, 8.00,  84,   6253.00, '2022-03-01', 'Disbursed', 3),
(5,  6, 'Business', 2000000.00, 10.50, 120, 26997.00, '2021-05-20', 'Disbursed', 10),
(8,  3, 'Personal',  150000.00, 13.00,  24,   7107.00, NULL,         'Applied',   NULL),
(11, 3, 'Home',     3500000.00, 8.75,  180, 34960.00, '2023-11-01', 'Disbursed', 5);

-- ── Loan Repayments ──────────────────────────────────────────
INSERT INTO loan_repayments (loan_id, paid_on, amount_paid, principal_part, interest_part, outstanding) VALUES
-- Aarav Home Loan (partial)
(1, '2024-01-01', 43391.00, 8116.00, 35275.00, 4902744.00),
(1, '2024-02-01', 43391.00, 8174.00, 35217.00, 4894570.00),
(1, '2024-03-01', 43391.00, 8232.00, 35159.00, 4886338.00),
-- Vivek Personal Loan
(2, '2024-01-15', 9964.00, 6964.00, 3000.00, 243036.00),
(2, '2024-02-15', 9964.00, 7034.00, 2930.00, 236002.00),
(2, '2024-03-15', 9964.00, 7104.00, 2860.00, 228898.00),
-- Rohan Vehicle Loan
(3, '2024-01-10', 14668.00, 9168.00, 5500.00, 650832.00),
(3, '2024-02-10', 14668.00, 9240.00, 5428.00, 641592.00),
-- Karthik Business Loan
(5, '2024-01-20', 26997.00, 9497.00, 17500.00,1690503.00),
(5, '2024-02-20', 26997.00, 9580.00, 17417.00,1680923.00),
(5, '2024-03-20', 26997.00, 9663.00, 17334.00,1671260.00);