-- 1 List the names of customers who spent more than 450.00 on a single bill when 'Charles' was their Headwaiter.
SELECT b.cust_name
FROM restBill b
JOIN restStaff s ON b.waiter_no = s.staff_no
WHERE b.bill_total > 450.00 AND s.staff_no = (
    SELECT staff_no
    FROM restStaff
    WHERE first_name = 'Charles'
);

-- 2 Nerida complained about a waiter on the 11th January 2016. What is the name and surname of the Headwaiter on that day?
SELECT s.first_name, s.surname
FROM restStaff s
WHERE s.staff_no = (
    SELECT headwaiter
    FROM restRoom_management rm
    WHERE rm.room_name = 'Green' AND rm.room_date = 160111
);

-- 3 List the names of the customers with the smallest bill.
SELECT b.cust_name
FROM restBill b
WHERE b.bill_total = (SELECT MIN(bill_total) FROM restBill);

-- 4 List the names of any waiters who have not taken any bills.
SELECT s.first_name, s.surname
FROM restStaff s
WHERE NOT EXISTS (
    SELECT 1
    FROM restBill b
    WHERE b.waiter_no = s.staff_no
);

-- 5 List of customers who had the largest bill with info on customers name, Headwaiter name and surname, room name and where they were served.
SELECT b.cust_name, hs.first_name AS headwaiter_first_name, hs.surname AS headwaiter_surname, rt.room_name
FROM restBill b
JOIN restRest_table rt ON b.table_no = rt.table_no
JOIN restRoom_management rm ON rt.room_name = rm.room_name AND b.bill_date = rm.room_date
JOIN restStaff hs ON rm.headwaiter = hs.staff_no
WHERE b.bill_total = (SELECT MAX(bill_total) FROM restBill);
