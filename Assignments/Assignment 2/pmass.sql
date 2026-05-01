use financelab;

-- case study 1
with account_summary as (
SELECT a.account_id, a.customer_id, a.account_type, a.opening_balance,
COUNT(t.transaction_id)   as transaction_count,
IFNULL(SUM(t.amount), 0)  as total_transaction_amount,
IFNULL(AVG(t.amount), 0)  as avg_transaction_amount
FROM Accounts a
LEFT JOIN Transactions t on a.account_id = t.account_id
GROUP BY a.account_id, a.customer_id, a.account_type, a.opening_balance
),

active_transaction_accounts as (
SELECT a.account_id, a.customer_id, a.account_type,
SUM(t.amount) as total_trans_amount,
COUNT(t.transaction_id) as trans_count,
AVG(t.amount) as trans_avg
FROM Accounts a
INNER JOIN Transactions t on a.account_id = t.account_id
GROUP BY a.account_id, a.customer_id, a.account_type
)

SELECT c1.customer_id, c1.customer_name, c1.city, c1.segment, 
acs.account_id, acs.account_type, acs.opening_balance,
acs.transaction_count, acs.total_transaction_amount, 
acs.avg_transaction_amount, ata.total_trans_amount,
CASE
WHEN acs.transaction_count = 0 AND acs.opening_balance>=100000
	THEN 'Silent High-Value Account'
WHEN acs.transaction_count = 0 AND acs.opening_balance<100000 
	THEN 'Inactive Low-Balance Account'
WHEN acs.transaction_count BETWEEN 1 AND 2 AND opening_balance>100000
	THEN 'Underutilized High-Value Account'
WHEN acs.transaction_count >= 3 
	AND acs.total_transaction_amount>(select avg(amount) from Transactions)
	THEN 'Active Account'
ELSE 'Review Account'
END as Account_Flag
FROM Customers c1
RIGHT JOIN account_summary acs on c1.customer_id = acs.customer_id
LEFT JOIN active_transaction_accounts ata on acs.account_id = ata.account_id
LEFT JOIN Customers c2 on c1.city = c2.city AND c1.customer_id < c2.customer_id
GROUP BY c1.customer_id, c1.customer_name, c1.city, c1.segment,
acs.account_id, acs.account_type, acs.opening_balance,
acs.transaction_count, acs.total_transaction_amount,
acs.avg_transaction_amount
ORDER BY acs.opening_balance DESC, acs.transaction_count ASC;


-- case study 2
with customer_details as (
SELECT c.customer_id, c.customer_name, c.city, c.segment, c.registration_date,
COUNT(DISTINCT a.account_id) as account_count,
IFNULL(SUM(a.opening_balance), 0) as total_balance,
COUNT(t.transaction_id) as transaction_count,
IFNULL(SUM(t.amount), 0) as total_transaction_amount,
IFNULL(AVG(t.amount), 0) as avg_transaction_amount
FROM Customers c
LEFT JOIN Accounts a  on c.customer_id = a.customer_id
LEFT JOIN Transactions t on a.account_id = t.account_id
GROUP BY c.customer_id, c.customer_name, c.city,
c.segment, c.registration_date
),

active_accounts as (
SELECT a.customer_id,
COUNT(t.transaction_id) as active_transaction_count,
SUM(t.amount) as active_total_amount,
AVG(t.amount) as active_avg_amount
FROM Accounts a
INNER JOIN Transactions t on a.account_id = t.account_id
GROUP BY a.customer_id
)

SELECT cd.customer_id, cd.customer_name, cd.city, 
cd.segment, cd.account_count, cd.total_balance, cd.transaction_count, 
cd.total_transaction_amount, cd.avg_transaction_amount,
CASE
WHEN cd.account_count = 0
	THEN 'No Account-Unengaged Customer'
WHEN cd.transaction_count = 0 AND cd.total_balance > 0
	THEN 'Has Account But Never Transacted'
WHEN cd.transaction_count BETWEEN 1 AND 2
	THEN 'Occasional User'
WHEN cd.transaction_count >= 3 AND cd.total_balance>100000
	THEN 'Active High-Value Customer'
WHEN cd.transaction_count >= 3 AND cd.total_balance<100000 
AND cd.total_balance < (SELECT avg(opening_balance) from accounts)
	THEN 'Active Low-Balance Customer'
ELSE 'Needs Further Review'
END AS Customer_Behavior
FROM customer_details cd
LEFT JOIN active_accounts aa ON cd.customer_id = aa.customer_id
LEFT JOIN Customers c2 ON cd.city = c2.city AND cd.customer_id < c2.customer_id
GROUP BY cd.customer_id, cd.customer_name, cd.city, cd.segment,cd.account_count, 
cd.total_balance, cd.transaction_count, cd.total_transaction_amount, cd.avg_transaction_amount
ORDER BY cd.total_balance DESC, cd.transaction_count DESC;
