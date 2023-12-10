-- Task 1 (Database Design)

CREATE database HMBank;

use HMBank;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
	DOB date,
    email VARCHAR(255),
    phone_number VARCHAR(15),
	address VARCHAR(255)
);
CREATE TABLE Accounts(
    account_id INT PRIMARY KEY,
	customer_id INT, 
    account_type VARCHAR(255),
    balance INT,
	FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions(
    transaction_id INT PRIMARY KEY,
	account_id INT, 
    transaction_type VARCHAR(255),
    amount INT,
	transaction_date date,
	FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

--Task 2 (Select, Where, Between, AND, LIKE)

INSERT INTO Customers (customer_id, first_name, last_name, DOB, email, phone_number, address)
VALUES
(1,'hary', 'musk','2001-09-22','hary@gmail.com','2378212367','345 dfd st'),
(2,'Joe', 'william','2023-03-01','will@gmail.com','3245352324','34 berjw'),
(3,'Mary', 'clark','2001-08-03','mary@gmail.com','4378212367','45 xcv'),
(4,'woon', 'moore','2004-02-21','woon@gmail.com','5378212367','66 adf'),
(5,'Neel', 'broun','2001-04-21','neel@gmail.com','7678212367','e4 fda'),
(6,'Amili', 'Askir','2003-11-02','Amili@gmail.com','6378212367','32 ers'),
(7,'Ben', 'ten','2001-04-12','Ben@gmail.com','7378212367','45 erf'),
(8,'Corvy', 'smith','2001-04-21','Corvy@gmail.com','8378212367','534 cfrtr St'),
(9,'Duke', 'musk','2001-03-12','Duke@gmail.com','9378212367','47 ghh'),
(10,'Emly', 'brown','2001-11-11','Emely@gmail.com','1378212367','56 edf');

Select * from Customers

INSERT INTO Accounts (account_id, customer_id, account_type, balance)
VALUES
(101, 1,'saving','345'),
(102, 2,'current','345'),
(103, 3,'saving','345'),
(104, 4,'current','345'),
(105, 5,'saving','345'),
(106, 6,'current','345'),
(107, 7,'saving','345'),
(108, 8,'current','345'),
(109, 9,'saving','345'),
(110, 10,'current','345');
Select * from Accounts

INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date)
VALUES
(1001, 101,'deposit','565','2001-09-22'),
(1002, 102,'withdrawl','245','2001-11-11'),
(1003, 103,'transfer','2455','2001-04-21'),
(1004, 104,'deposit','455','2001-04-21'),
(1005, 105,'withdrawl','565','2023-03-01'),
(1006, 106,'transfer','67545','2004-02-21'),
(1007, 107,'deposit','54535','2001-11-11'),
(1008, 108,'withdrawl','655','2001-04-21'),
(1009, 109,'transfer','765','2001-04-21'),
(1010, 110,'deposit','895','2001-04-21');
Select * from Transactions

--1
SELECT c.first_name, c.last_name, a.account_type, c.email
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

--2
SELECT c.first_name, c.last_name, t.transaction_type, t.amount, t.transaction_date
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
JOIN Transactions t ON a.account_id = t.account_id;

--3
UPDATE Accounts
SET balance = balance + :amount_to_increase
WHERE account_id = :specific_account_id;

--4
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM Customers;

--5
DELETE FROM Accounts
WHERE balance = 0 AND account_type = 'savings';

--6
SELECT *
FROM Customers
WHERE address LIKE '%specific_city%';

--7
SELECT balance
FROM Accounts
WHERE account_id = :specific_account_id;

--8
SELECT *
FROM Accounts
WHERE account_type = 'current' AND balance > 1000;

--9
SELECT *
FROM Transactions
WHERE account_id = :specific_account_id;

--10
SELECT account_id, balance * (1 + (:interest_rate / 100)) - balance AS interest_accrued
FROM Accounts
WHERE account_type = 'savings';

--11
SELECT *
FROM Accounts
WHERE balance < :overdraft_limit;

--12
SELECT *
FROM Customers
WHERE address NOT LIKE '%specific_city%';
  

--Task 3 (Aggregate functions, Having, Order By, GroupBy and Joins)

--1
  SELECT AVG(balance) AS average_balance
FROM Accounts;


--2
SELECT customer_id, account_id, balance
FROM Accounts
ORDER BY balance DESC
LIMIT 10;


--3
SELECT SUM(amount) AS total_deposits
FROM Transactions
WHERE transaction_type = 'deposit'
AND transaction_date = 'specific_date'; -- Replace 'specific_date' with the date you want to specify


--4
SELECT first_name, last_name, DOB
FROM Customers
ORDER BY DOB ASC LIMIT 1; -- Oldest
SELECT first_name, last_name, DOB
FROM Customers
ORDER BY DOB DESC LIMIT 1; -- Newest


--5
SELECT t.*, a.account_type
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id;


--6
SELECT c.*, a.*
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;


--7
SELECT t.*, c.*
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id
WHERE a.account_id = specific_account_id; -- Replace 'specific_account_id' with the account ID you want to query


--8
SELECT customer_id, COUNT(*) AS num_accounts
FROM Accounts
GROUP BY customer_id
HAVING COUNT(*) > 1;


--9
SELECT transaction_type, SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE -amount END) AS transaction_difference
FROM Transactions
WHERE transaction_type IN ('deposit', 'withdrawal')
GROUP BY transaction_type;


--10
SELECT account_id, AVG(balance) AS avg_daily_balance
FROM Accounts
GROUP BY account_id;


--11
SELECT account_type, SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;


--12
SELECT account_id, COUNT(*) AS num_transactions
FROM Transactions
GROUP BY account_id
ORDER BY num_transactions DESC;


--13
SELECT c.customer_id, c.first_name, c.last_name, a.account_type, SUM(a.balance) AS aggregate_balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id
ORDER BY aggregate_balance DESC;


--14
SELECT transaction_id, transaction_date, amount, account_id, COUNT(*) AS num_duplicates
FROM Transactions
GROUP BY transaction_date, amount, account_id
HAVING COUNT(*) > 1;


--  Task 4 (Subquery and its type)

-- 1. Retrieve the customer(s) with the highest account balance
SELECT c.customer_id, c.first_name, c.last_name, MAX(a.balance) AS highest_balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id
ORDER BY highest_balance DESC
LIMIT 1;

-- 2. Calculate the average account balance for customers who have more than one account
SELECT customer_id, AVG(balance) AS avg_balance
FROM Accounts
GROUP BY customer_id
HAVING COUNT(customer_id) > 1;

-- 3. Retrieve accounts with transactions whose amounts exceed the average transaction amount
SELECT a.*
FROM Accounts a
JOIN Transactions t ON a.account_id = t.account_id
WHERE t.amount > (SELECT AVG(amount) FROM Transactions);

-- 4. Identify customers who have no recorded transactions
SELECT c.*
FROM Customers c
LEFT JOIN Accounts a ON c.customer_id = a.customer_id
LEFT JOIN Transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

-- 5. Calculate the total balance of accounts with no recorded transactions
SELECT SUM(a.balance) AS total_balance_no_transactions
FROM Accounts a
LEFT JOIN Transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

-- 6. Retrieve transactions for accounts with the lowest balance
SELECT t.*
FROM Transactions t
JOIN (
    SELECT account_id, MIN(balance) AS lowest_balance
    FROM Accounts
    GROUP BY account_id
) AS min_balance ON t.account_id = min_balance.account_id;

-- 7. Identify customers who have accounts of multiple types
SELECT c.customer_id, c.first_name, c.last_name
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT a.account_type) > 1;

-- 8. Calculate the percentage of each account type out of the total number of accounts
SELECT account_type, COUNT(*) AS num_accounts,
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM Accounts)) * 100, 2) AS percentage
FROM Accounts
GROUP BY account_type;

-- 9. Retrieve all transactions for a customer with a given customer_id
SELECT t.*
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
WHERE a.customer_id = <given_customer_id>; -- Replace <given_customer_id> with the actual ID

-- 10. Calculate the total balance for each account type, including a subquery within the SELECT clause
SELECT account_type,
       (SELECT SUM(balance) FROM Accounts a2 WHERE a2.account_type = a.account_type) AS total_balance
FROM Accounts a
GROUP BY account_type;
