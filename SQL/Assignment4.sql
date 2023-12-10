-- Task1 (Database Design)

CREATE database Courier_Management
use Courier_Management;
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255),
    ContactNumber VARCHAR(20),
    Address TEXT
);
CREATE TABLE Couriers (
    CourierID INT PRIMARY KEY,
    SenderUserID INT,
    ReceiverUserID INT,
    Weight DECIMAL(5, 2),
    Status VARCHAR(50),
    TrackingNumber VARCHAR(20) UNIQUE,
    DeliveryDate DATE,
    FOREIGN KEY (SenderUserID) REFERENCES Users(UserID),
    FOREIGN KEY (ReceiverUserID) REFERENCES Users(UserID)
);
CREATE TABLE CourierServices (
    ServiceID INT PRIMARY KEY,
    ServiceName VARCHAR(100),
    Cost DECIMAL(8, 2)
);
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    ContactNumber VARCHAR(20),
    Role VARCHAR(50),
    Salary DECIMAL(10, 2)
);
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(100),
    Address TEXT
);
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    CourierID INT,
    LocationID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (CourierID) REFERENCES Couriers(CourierID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Insert sample data into Users table

INSERT INTO Users (UserID, Name, Email, Password, ContactNumber, Address)
VALUES
(1,'Hary', 'hary@gmail.com','hary@','2378212367','345 dfd st'),
(2,'Joe', 'will@gmail.com','will@','3245352324','34 berjw'),
(3,'Mary', 'mary@gmail.com','mary@','4378212367','45 xcv'),
(4,'woon', 'woon@gmail.com','woon@','5378212367','66 adf'),
(5,'Neel', 'neel@gmail.com','neel@','7678212367','e4 fda'),
(6,'Amili', 'amili@gmail.com','amili@','6378212367','32 ers'),
(7,'Ben', 'ben@gmail.com','ben@','7378212367','45 erf'),
(8,'Corvy', 'corvy@gmail.com','corvy@','8378212367','534 cfrtr St'),
(9,'Duke', 'duke@gmail.com','duke@','9378212367','47 ghh'),
(10,'Emly', 'emely@gmail.com','emely@','1378212367','56 edf');

INSERT INTO Couriers 
VALUES 
(1, 'Ben', '43Ofgg, CityF', 'Receiver A', '456 Maple Lane, CityG', 4.3, 'In Transit', 'TN123456', '2023-12-15'),
(2, 'Neel', '352erert, CityH', 'Receiver B', '101 Elm Road, CityI', 2.1, 'Delivered', 'TN789012', '2023-12-16'),
(3, 'Duke', '24Elm tre, CityH', 'Receiver C', '987 Maple Road, CityI', 4.5, 'Delivered', 'TN789456', '2023-12-18'),
(4, 'Woon', '42Ortr, CityJ', 'Receiver D', '123 Pine Avenue, CityK', 5.2, 'In Transit', 'TN012345', '2023-12-19');

INSERT INTO CourierServices 
VALUES
(1, 'global Delivery', 870.99),
(2, 'new Delivery', 80.99),
(3, 'heya Delivery', 70.99),
(4, 'ray Delivery', 95.99),
(5, 'daily Shipping', 30.99);

INSERT INTO Employees 
VALUES
(1, 'John Doe', 'john.doe@example.com', '123-456-7890', 'Manager', 60000.00),
(2, 'Jane Smith', 'jane.smith@example.com', '987-654-3210', 'Delivery Staff', 40000.00),
(3, 'Bob Johnson', 'bob.johnson@example.com', '555-123-4567', 'Customer Service', 45000.00),
(4, 'Sam Wilson', 'sam.wilson@example.com', '777-888-9999', 'IT Specialist', 55000.00),
(5, 'Emily Davis', 'emily.davis@example.com', '333-222-1111', 'Accountant', 50000.00);

INSERT INTO Locations (LocationID, LocationName, Address)
VALUES
(1, 'Office A', '123 Main Street, CityA'),
(2, 'Office B', '456 Oak Street, CityB'),
(3, 'Warehouse', '789 Pine Street, CityC'),
(4, 'Warehouse B', '987 Cedar Street, CityD'),
(5, 'Office C', '654 Birch Street, CityE');

INSERT INTO Payments 
VALUES
(1, 1, 1, 658.99, '2023-01-22'),
(2, 2, 2, 345.99, '2023-10-12'),
(3, 3, 3, 3456.99, '2023-11-06'),
(4, 4, 4, 23.99, '2023-11-03');

--1. List all customers
select * from Users;

--2. List all orders for a specific customer
SELECT * FROM Couriers
WHERE CourierID = 3;

--3. List all couriers
select * from Couriers;

--4. List all packages for a specific order
SELECT *
select * from Couriers where Status = 'In Transit';

--5. List all deliveries for a specific courier
SELECT *
FROM Couriers
WHERE CourierID = 1 AND DeliveryDate IS NOT NULL;

--6. List all undelivered packages
SELECT *
FROM Couriers
WHERE DeliveryDate IS NULL;

--7. List all packages that are scheduled for delivery today
SELECT *
FROM Couriers
WHERE DeliveryDate = sysdate;

--8. List all packages with a specific status
SELECT *
FROM Couriers
WHERE Status = 'SpecificStatus';

--9. Calculate the total number of packages for each courier
SELECT CourierID, COUNT(*) AS TotalPackages
FROM Couriers
GROUP BY CourierID;

--10. Find the average delivery time for each courier
SELECT CourierID, AVG(DATEDIFF('DeliveryDate', 'PaymentDate','y')) AS AvgDeliveryTime
FROM Couriers
WHERE DeliveryDate IS NOT NULL
GROUP BY CourierID;

--11. List all packages with a specific weight range
SELECT *
FROM Couriers
WHERE Weight BETWEEN min(Weight) AND max(Weight); -- replace minWeight and maxWeight with the desired range

--12. Retrieve employees whose names contain 'John'
SELECT *
FROM Employees
WHERE Name LIKE '%John%';

--13. Retrieve all courier records with payments greater than $50
SELECT c.*
FROM Couriers c
INNER JOIN Payments p ON c.CourierID = p.CourierID
WHERE p.Amount > 50;

 --Task 3 (GroupBy, Aggregate Functions, Having, Order By, where)

SELECT e.Name AS EmployeeName, COUNT(c.CourierID) AS TotalCouriersHandled
FROM Employees e
LEFT JOIN Couriers c ON e.EmployeeID = c.CourierID
GROUP BY e.EmployeeID;


SELECT l.LocationName, SUM(p.Amount) AS TotalRevenueGenerated
FROM Locations l
LEFT JOIN Payments p ON l.LocationID = p.LocationID
GROUP BY l.LocationID;


SELECT l.LocationName, COUNT(c.CourierID) AS TotalCouriersDelivered
FROM Locations l
LEFT JOIN Couriers c 
ON l.LocationID = c.CourierID
GROUP BY l.LocationID;


SELECT c.CourierID, AVG(DATEDIFF('2022-02-03', 'c.CreatedDate','y')) AS AvgDeliveryTime
FROM Couriers c,
GROUP BY c.CourierID
ORDER BY AvgDeliveryTime DESC
LIMIT 1


SELECT l.LocationName, COALESCE(SUM(p.Amount), 0) AS TotalPayments
FROM Locations l
LEFT JOIN Payments p ON l.LocationID = p.LocationID
GROUP BY l.LocationID
HAVING TotalPayments < desired_amount;


SELECT c.CourierID, SUM(p.Amount) AS TotalPayments
FROM Couriers c
JOIN Payments p ON c.CourierID = p.CourierID
WHERE p.LocationID = 1
GROUP BY c.CourierID
HAVING Amount > 1000;

SELECT c.CourierID, SUM(p.Amount) AS TotalPayments
FROM Couriers c
JOIN Payments p ON c.CourierID = p.CourierID
WHERE p.PaymentDate > 'YYYY-MM-DD'
GROUP BY c.CourierID
HAVING Amount > 1000;


SELECT l.LocationName, COALESCE(SUM(p.Amount), 0) AS TotalPayments
FROM Locations l
LEFT JOIN Payments p ON l.LocationID = p.LocationID
WHERE p.PaymentDate < 'YYYY-MM-DD'
GROUP BY l.LocationID
HAVING Amount > 5000;

--task 4 ( Inner Join,Full Outer Join, Cross Join, Left Outer Join,Right Outer Join)

SELECT p.*, c.*
FROM Payments p
JOIN Couriers c ON p.CourierID = c.CourierID;

SELECT p.*, l.*
FROM Payments p
JOIN Locations l ON p.LocationID = l.LocationID;


SELECT p.*, c.*, l.*
FROM Payments p
JOIN Couriers c ON p.CourierID = c.CourierID
JOIN Locations l ON p.LocationID = l.LocationID;


SELECT p.*, c.*
FROM Payments p
LEFT JOIN Couriers c ON p.CourierID = c.CourierID;


SELECT c.CourierID, c.ReceiverUserID, SUM(p.Amount) AS TotalPaymentReceived
FROM Couriers c
LEFT JOIN Payments p ON c.CourierID = p.CourierID
GROUP BY c.CourierID, c.ReceiverUserID;
