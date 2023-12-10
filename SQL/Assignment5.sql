Tasks 1 (Database Design)
  
--1
CREATE DATABASE TicketBookingSystem;

USE TicketBookingSystem;

--2 
--Venue Table:

CREATE TABLE Venue (
    venue_id INT PRIMARY KEY,
    venue_name VARCHAR(255),
    address VARCHAR(255)
);

--Event Table:

CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(255),
    event_date DATE,
    event_time TIME,
    venue_id INT,
    total_seats INT,
    available_seats INT,
    ticket_price DECIMAL(10, 2),
    event_type VARCHAR(50),
    booking_id INT
);

--Customer Table:

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    booking_id INT
);

--Booking Table:

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    customer_id INT,
    event_id INT,
    num_tickets INT,
    total_cost DECIMAL(10, 2),
    booking_date DATE
);
 
--4
Alter table Event
add venue_id INT

Alter table Event
add booking_id INT

Alter table Customer
add booking_id INT

Alter table booking
add customer_id INT

Alter table booking
add event_id INT
ALTER TABLE Event 
add constraint FK_venue_id FOREIGN KEY (venue_id) REFERENCES Venue(venue_id);

ALTER TABLE Event     
add constraint FK_booking_id FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);

ALTER TABLE Customer     
add constraint FKey_booking_id FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);

ALTER TABLE booking 
add constraint FK_customer_id  FOREIGN KEY(customer_id) references Customer(customer_id);


ALTER TABLE booking 
add constraint FK_event_id FOREIGN KEY(event_id) references Event(event_id);


--Tasks 2 (Select, Where, Between, AND, LIKE)

--1
INSERT INTO Venue (venue_id, venue_name, address) VALUES
(1, 'Delhi', 'Suite 640 1856 Turner Camp, East Harriett, NJ 34953'),
(2, 'Mumbai', 'F-1/10, Sector 10, Vashi'),
(3, 'Hyderabad', '5-1-459/7, Jam Bagh'),
(4, 'Bangalore', '92, 2nd Flr Mosque Road, Frazer Town'),
(5, 'Ahmedabad', 'Opp Spss Hall Nr Aditya Complex, Navrangpura'),
(6, 'Vadodara', '30, Narendra Park Society, Near'),
(7, 'Pune', 'Opp Green Roadways,near Hotel, Orient, Kasba Peth'),
(8, 'Madurai', 'D/g 29-30-31, Sardar Patel Cp, Station Road, Gidc, Ankleshwar'),
(9, 'Trichy', 'ABC Street,Navinagar'),
(10, 'Chennai', '12/13 agenda complex,AnnaNagar'); 

INSERT INTO Event (event_id, event_name, event_date, event_time, total_seats, available_seats, ticket_price, event_type, venue_id,booking_id) 
VALUES
(1, 'Fictional', '2023-01-01', '12:00:00', 100, 50, 250.00, 'Movie',1,1),
(2, 'Kabbadi Cup', '2023-02-02', '15:30:00', 1500, 500, 380.00, 'Sports',2,2),
(3, 'Dance Concert', '2023-02-03', '15:00:00', 155, 100, 2000.00, 'Concert',3,3),
(4, 'Horror', '2023-02-04', '11:30:00', 150, 100, 300.00, 'Movie',4,4),
(5, 'singing', '2023-02-05', '12:30:00', 150, 100, 2000.00, 'Concert',5,5),
(6, 'Volleyball', '2023-02-06', '13:30:00', 150, 100, 300.00, 'Sports',6,6),
(7, 'Comics', '2023-02-07', '14:30:00', 150, 100, 200.00, 'Movie',7,7),
(8, 'Music', '2023-02-08', '15:30:00', 1000, 600, 3000.00, 'Concert',8,8),
(9, 'Thriller', '2023-02-09', '16:30:00', 350, 250, 200.00, 'Movie',9,9),
(10, 'Football', '2023-02-10', '17:30:00',  150, 100, 350.00, 'Sports',10,10);
 
INSERT INTO Customer (customer_id, customer_name, email, phone_number, booking_id) VALUES
(1, 'John', 'john@example.com', '123-456-7890',1),
(2, 'Jane', 'jane@example.com', '987-654-3210',2),
(3, 'Bob', 'bob@example.com', '423-456-7890',3),
(4, 'Alice', 'alice@example.com', '523-456-7890',4),
(5, 'Charlie', 'charlie@example.com', '623-456-7890',5),
(6, 'Eva', 'eva@example.com', '723-456-7890',6),
(7, 'Frank', 'frank@example.com', '823-456-7000',7),
(8,  'Grace', 'grace@example.com', '923-456-7000',8),
(9, 'Henry', 'henry@example.com', '223-456-7000',9),
(10, 'Ivy', 'ivy.@example.com', '323-456-7890',10);

INSERT INTO Booking (booking_id, num_tickets, total_cost, booking_date, customer_id, event_id) VALUES
(1, 2, 4000.00, '2023-01-01 10:00:00',1,1),
(2, 3, 900.00, '2023-02-02 12:30:00',2, 2),
(3, 2, 5550.00, '2023-01-03 09:00:00',3, 3),
(4, 2, 4444.00, '2023-01-04 09:00:00', 4, 4),
(5, 1, 4300.00, '2023-01-05 10:00:00', 5, 5),
(6, 2, 3540.00, '2023-01-06 11:00:00', 6, 6),
(7, 4, 3670.00, '2023-01-07 11:00:00',7, 7),
(8, 2, 2240.00, '2023-01-08 10:00:00', 8, 8),
(9, 3, 4540.00, '2023-01-09 09:00:00',9,9),
(10, 2, 5540.00, '2023-01-10 10:00:00',10, 10);

--2
SELECT * FROM Event;

--3
SELECT event_id,event_name,available_seats  FROM Event ;

--4
SELECT * FROM Event
WHERE event_name LIKE '%cup%';

--5
SELECT   *  FROM Event
WHERE ticket_price BETWEEN 1000 AND 2500;
 
--6
SELECT * FROM Event
WHERE event_date BETWEEN '2023-01-01' AND '2023-12-31';
 
--7
SELECT * FROM Event
WHERE available_seats > 0 AND event_name LIKE '%Concert%';
 
--8
SELECT customer_id, customer_name, email, phone_number
FROM Customer
ORDER BY customer_id
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;
 
--9
SELECT * FROM Booking
WHERE num_tickets > =4;

--10
SELECT * FROM Customer
WHERE phone_number LIKE '%000';
 
--11
SELECT * FROM Event
WHERE total_seats > 150
ORDER BY total_seats;

--12
SELECT * FROM Event
WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'v%';

--TASK 3 (Aggregate functions, Group By and Joins)

--1
SELECT e.event_id, e.event_name, AVG(e.ticket_price) AS average_ticket_price
FROM Event e
GROUP BY e.event_id, e.event_name;
 
--2
SELECT SUM(B.total_cost) AS total_revenue FROM Booking B;
 
--3
SELECT TOP 1 E.event_id,E.event_name,SUM(B.num_tickets) AS total_tickets_sold
FROM Event E
JOIN Booking B ON E.event_id = B.event_id
GROUP BY E.event_id, E.event_name
ORDER BY total_tickets_sold DESC;
 
--4
SELECT E.event_id, E.event_name, SUM(B.num_tickets) AS total_tickets_sold
FROM Event E
JOIN Booking B ON E.event_id = B.event_id
GROUP BY E.event_id, E.event_name;

--5
SELECT e.event_id, e.event_name
FROM Event e
LEFT JOIN Booking b ON e.event_id = b.event_id
WHERE b.event_id IS NULL;
 
--6
SELECT TOP 1 c.customer_id, c.customer_name, SUM(b.num_tickets) AS total_tickets_booked
FROM Customer c
JOIN Booking b ON c.booking_id = b.booking_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_tickets_booked DESC;

--7
SELECT E.event_id,E.event_name,MONTH(B.booking_date) AS booking_month,SUM(B.num_tickets) AS total_tickets_sold
FROM Event E JOIN Booking B ON E.event_id = B.event_id
GROUP BY E.event_id, E.event_name, MONTH(booking_date)
ORDER BY booking_month, E.event_id;
 
--8
SELECT V.venue_id, V.venue_name, AVG(E.ticket_price) AS average_ticket_price FROM Venue V
JOIN Event E ON V.venue_id = E.venue_id
GROUP BY V.venue_id, V.venue_name;

--9
SELECT e.event_type, SUM(b.num_tickets) AS total_tickets_sold FROM Event e
JOIN Booking b ON e.event_id = b.event_id
GROUP BY e.event_type;
 
--10
SELECT YEAR(B.booking_date) AS booking_year, SUM(B.total_cost) AS total_revenue
FROM Booking B
GROUP BY YEAR(B.booking_date)
ORDER BY booking_year;
 
--11
SELECT c.customer_id, c.customer_name, COUNT( b.event_id) AS num_events_booked
FROM Customer c
JOIN Booking b ON c.booking_id = b.booking_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT( b.event_id) > 1;
 
--12
select c.customer_id,c.customer_name, SUM(b.total_cost) as total_revenue from Customer c join Booking b on c.customer_id = b.customer_id group by c.customer_id, c.customer_name;

--13
SELECT e.event_type, v.venue_name, AVG(e.ticket_price) AS average_ticket_price
FROM Event e
JOIN Venue v ON e.venue_id = v.venue_id
GROUP BY e.event_type, v.venue_name;

--14
SELECT c.customer_id, c.customer_name, COUNT(b.booking_id) AS total_tickets_purchased
FROM Customer c
JOIN Booking b ON c.booking_id = b.booking_id
WHERE b.booking_date >= DATEADD(DAY,-30,GETDATE())
GROUP BY c.customer_id, c.customer_name;

--TASK 4 (Subquery and its Types)

--1
SELECT v.venue_id, v.venue_name,
(SELECT AVG(e.ticket_price) FROM Event e WHERE e.venue_id = v.venue_id) AS average_ticket_price
FROM Venue v;

--2
SELECT e.event_id,e.event_name,e.total_seats,available_seats,ticket_price,event_type FROM Event e
WHERE (SELECT SUM(num_tickets) FROM Booking b WHERE b.event_id = e.event_id) > 0.5 * e.total_seats;
 
--3
SELECT e.event_id, e.event_name,
(SELECT SUM(b.num_tickets) FROM Booking b WHERE b.event_id = e.event_id) AS total_tickets_sold
FROM Event e;

--4
SELECT c.customer_id, c.customer_name FROM Customer c
WHERE NOT EXISTS ( SELECT 1 FROM Booking b WHERE c.booking_id = b.booking_id );
 
--5
SELECT e.event_id, e.event_name
FROM Event e
WHERE e.event_id NOT IN (SELECT DISTINCT event_id FROM Booking b);

--6
SELECT
    e.event_type,
    SUM(b.num_tickets) AS total_tickets_sold
FROM
    (SELECT
        event_id,
        event_type
    FROM
        Event) e
JOIN
    Booking b ON e.event_id = b.event_id
GROUP BY
    e.event_type;
 
--7
SELECT event_id, event_name, ticket_price FROM Event
WHERE ticket_price > ( SELECT AVG(ticket_price) FROM Event );

--8
SELECT
    c.customer_id,
    c.customer_name,
    (
        SELECT
            SUM(b.total_cost)
        FROM
            Booking b
        WHERE
            b.customer_id = c.customer_id
    ) AS total_revenue_generated
    FROM
    Customer c;
 
--9
SELECT customer_id, customer_name
FROM Customer
WHERE customer_id IN (SELECT DISTINCT customer_id FROM Booking WHERE event_id IN (SELECT event_id FROM Event WHERE venue_id = 1));
  
--10
SELECT event_type, SUM(total_tickets_sold) AS total_tickets_sold
FROM (
    SELECT event_id, event_type, 
           (SELECT SUM(num_tickets) FROM Booking WHERE Booking.event_id = Event.event_id) AS total_tickets_sold
    FROM Event
) AS Subquery
GROUP BY event_type;

--11
SELECT
    c.customer_id,
    c.customer_name,
    FORMAT(booking_date, 'MM-yyyy') AS booking_month
FROM
    Customer c
JOIN
    Booking b ON c.customer_id = b.customer_id
GROUP BY
    c.customer_id, c.customer_name, FORMAT(booking_date, 'MM-yyyy');

--12
SELECT v.venue_id, v.venue_name,
(SELECT AVG(e.ticket_price) FROM Event e WHERE e.venue_id = v.venue_id) AS average_ticket_price
FROM Venue v;
