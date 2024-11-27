-- 1 Waiters with two or more bills on a single date; inc name, surname, date and number of bills.
SELECT s.first_name, s.surname, b.bill_date, COUNT(b.bill_no) AS number_of_bills
FROM restStaff s
JOIN restBill b ON s.staff_no = b.waiter_no
GROUP BY s.first_name, s.surname, b.bill_date
HAVING COUNT(b.bill_no) >= 2;

-- 2 List rooms with tables that can serve more than 6 people and the total number of them.
SELECT rt.room_name, COUNT(rt.table_no) AS number_of_large_tables
FROM restRest_table rt
WHERE rt.no_of_seats > 6
GROUP BY rt.room_name;

-- 3 List the names of rooms and total amount of bills in each room.
SELECT rt.room_name, SUM(b.bill_total) AS total_bill_amount
FROM restBill b
JOIN restRest_table rt ON b.table_no = rt.table_no
GROUP BY rt.room_name;

-- 4 List headwaiters name, surname and total bill amount that their waiters have taken. Ordered by total bill amount largest first.
SELECT hs.first_name, hs.surname, SUM(b.bill_total) AS total_bill_amount
FROM restStaff hs
JOIN restStaff ws ON hs.staff_no = ws.headwaiter
JOIN restBill b ON ws.staff_no = b.waiter_no
GROUP BY hs.first_name, hs.surname
ORDER BY total_bill_amount DESC;

-- 5 List any customers who have spent more than £400 on average.
SELECT b.cust_name
FROM restBill b
GROUP BY b.cust_name
HAVING AVG(b.bill_total) > 400;

-- 6 Which waiters have taken 3 or more bills on one date.List their names, surnames and number of bills they have taken.
SELECT s.first_name, s.surname, COUNT(b.bill_no) AS number_of_bills
FROM restStaff s
JOIN restBill b ON s.staff_no = b.waiter_no
GROUP BY s.first_name, s.surname
HAVING COUNT(b.bill_no) >= 3;
