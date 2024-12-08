-- 1 View with the name samsBills to allow the waiter Sam Pitt to see the bills he has taken.
CREATE VIEW samsBills AS
SELECT first_name, surname, bill_date, cust_name, bill_total
FROM bills
WHERE waiter_id = (SELECT id FROM waiters WHERE first_name = 'Sam' AND surname = 'Pitt');

-- 2 Query using the samsBills view so he can see only bills over £400.
SELECT *
FROM samsBills
WHERE bill_total > 400;

-- 3 View with the name roomTotals to allow management to see how much each room has taken.
CREATE VIEW roomTotals AS
SELECT room_name, SUM(bill_total) AS total_sum
FROM bills
GROUP BY room_name;

-- 4 view with the name roomTotals to allow management to see how much each room has taken.
CREATE VIEW teamTotals AS
SELECT 
    CONCAT(first_name, ' ', surname) AS headwaiter_name, 
    SUM(bill_total) AS total_sum
FROM bills
JOIN waiters ON bills.waiter_id = waiters.id
GROUP BY headwaiter_name;
