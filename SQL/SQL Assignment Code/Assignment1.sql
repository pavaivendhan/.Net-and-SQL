--Task 1 (Database Design)

--1
USE TechShop;

--2
CREATE TABLE Customers(
CustomerId INT PRIMARY KEY,
FirstName VARCHAR(20),
LastName VARCHAR(20),
Email VARCHAR(40),
Phone VARCHAR(10),
Address VARCHAR(30),
);

SELECT * FROM Customers;

CREATE TABLE Products(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(30),
Description VARCHAR(50),
Price DECIMAL(10,2)
);

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
TotalAmount DECIMAL(10,2),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerId)
);

CREATE TABLE OrderDetails (
OrderDetailID INT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Inventory (
InventoryID INT PRIMARY KEY,
ProductID INT,
QuantityInStock INT,
LastStockUpdate DATE,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

--Inserting Values into database

INSERT INTO Customers VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '123-456-7890', '123 Main St'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '987-654-3210', '456 Oak St'),
-- ... (Insert 8 more records)
  
-- Step 8: Insert sample records into Products table
INSERT INTO Products VALUES
(1, 'Laptop', 'High-performance laptop', 999.99),
(2, 'Smartphone', 'Flagship smartphone', 699.99),
-- ... (Insert 8 more records)
  
-- Step 9: Insert sample records into Orders table
INSERT INTO Orders VALUES
(1, 1, '2023-01-01', 999.99),
(2, 2, '2023-02-01', 699.99),
-- ... (Insert 8 more records)
  
-- Step 10: Insert sample records into OrderDetails table
INSERT INTO OrderDetails VALUES
(1, 1, 1, 2),
(2, 1, 2, 1),
-- ... (Insert 8 more records)
  
-- Step 11: Insert sample records into Inventory table
INSERT INTO Inventory VALUES
(1, 1, 50, '2023-01-01'),
(2, 2, 100, '2023-02-01'),
-- ... (Insert 8 more records)

--Task 2 (Select, Where, Between, AND LIKE)

  --1
SELECT FirstName + ' ' + LastName AS Names, Email as Emails from Customers;


--2
SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName from Orders O INNER
JOIN Customers C ON O.OrderID= C.CustomerId;

--3
INSERT INTO Customers VALUES (11,'Jay', 'Singh', 'jay.customer@email.com',
'5551234567', '789 New St');

--4
UPDATE Products
SET Price = Price * 1.1;

--5
DECLARE @OrderID INT; -- Declare the parameter
SET @OrderID = 9;
DELETE FROM OrderDetails
WHERE OrderID = @OrderID;
DELETE FROM Orders
WHERE OrderID = @OrderID;

--6
INSERT INTO Orders VALUES (11, 11, '2023-11-01', 499.99);

--7
DECLARE @CustomerID INT = 1;
UPDATE Customers
SET Email='abc121@gmail.com', Address = 'New Jersey'
WHERE CustomerId = @CustomerID;

--8
UPDATE Orders
SET TotalAmount =(
SELECT SUM(P.Price*O.Quantity)From OrderDetails O JOIN Products P
ON O.ProductID = P.ProductID WHERE O.OrderID = Orders.OrderID);

--9
DECLARE @CustomerID INT = 1;
DELETE FROM OrderDetails WHERE OrderID = (
SELECT OrderID from Orders WHERE CustomerID = @CustomerID)
DELETE FROM Orders WHERE Orders.CustomerID = @CustomerID;

--10
INSERT INTO Products
VALUES (11,'Fridge', 'Multi-functional', 299.99);

--11
DECLARE @OrderID INT = 4; -- Replace with the actual order ID
UPDATE Orders
SET Status = 'Shipped'
WHERE OrderID = @OrderID;

--12
UPDATE Customers
SET NumberOfOrders = (
SELECT COUNT(*)
FROM Orders
WHERE Orders.CustomerID = Customers.CustomerId
);

--Task 3 (Aggregate functions, Having, Order By, GroupBy and Joins)

--1
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName,
Customers.LastName, Customers.Email, Customers.Phone
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerId;

--2
SELECT p.ProductName, SUM(od.Quantity * p.Price) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName;

--3
SELECT DISTINCT
c.FirstName,
c.LastName,
c.Email,
c.Phone
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

--4
SELECT ProductName FROM Products WHERE ProductID = (
SELECT ProductID FROM OrderDetails O WHERE Quantity =
(SELECT MAX(Quantity) FROM OrderDetails) GROUP BY ProductID );

--5
SELECT p.ProductName, p.Description, p.Price
FROM Products p;

--6
SELECT c.CustomerID, c.FirstName, c.LastName, AVG(o.TotalAmount) AS
AverageOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

--7
SELECT TOP 1 C.FirstName, C.LastName, O.TotalAmount From Orders O
JOIN Customers C ON O.CustomerID = C.CustomerId
ORDER BY TotalAmount DESC;

--8
SELECT p.ProductName, COUNT(od.OrderDetailID) AS OrderCount
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName;

--9
SELECT c.FirstName, c.LastName, c.Email, c.Phone
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = @ProductName;

--10
DECLARE @StartDate DATE = '2023-01-01';
DECLARE @EndDate DATE = '2023-12-31';
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders
WHERE Orders.OrderDate BETWEEN @StartDate AND @EndDate;

--Task 4( Subquery and its type)

--1
SELECT C.FirstName, C.LastName FROM Customers C
WHERE C.CustomerId NOT IN(
SELECT O.CustomerID FROM Orders O
);

--2
SELECT COUNT(*) AS TotalProducts
FROM Products;

--3
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders;

--4
DECLARE @PRODUCTNAME VARCHAR(20) = 'Camera';
SELECT AVG(O.Quantity) AS AverageQunantity FROM OrderDetails O WHERE
O.ProductID IN
(SELECT P.ProductID FROM Products P WHERE P.ProductName = @PRODUCTNAME)

--5
DECLARE @CUSTID INT = 5;
SELECT SUM(O.TotalAmount) AS TotalRevenue FROM Orders O
WHERE O.CustomerID = @CUSTID;

--6
SELECT TOP 1 FirstName, LastName, OrderCount
FROM (SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount,
RANK() OVER (ORDER BY COUNT(o.OrderID) DESC) AS CustomerRank
FROM Customers c 
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
) AS RankedCustomers WHERE CustomerRank = 1;

--7
SELECT p.ProductName, od.quantity FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
WHERE Quantity = (
SELECT TOP 1 Quantity FROM OrderDetails
ORDER BY Quantity DESC
)

--8
SELECT C.FirstName, C.LastName, TotalSpending
FROM Customers C
JOIN (SELECT TOP 1 O.CustomerID, (O.TotalAmount * Od.Quantity) AS TotalSpending
FROM Orders O
JOIN OrderDetails Od ON Od.OrderID = O.OrderID
ORDER BY (O.TotalAmount * Od.Quantity) DESC
) Orders ON C.CustomerID = Orders.CustomerID;

--9
SELECT c.FirstName, c.LastName, AVG(OrderValue) AS AverageOrderValue
FROM Customers c
JOIN (
SELECT o.CustomerID, SUM(o.TotalAmount) AS OrderValue
FROM Orders o
GROUP BY o.CustomerID
) AS CustomerOrderValues ON c.CustomerID = CustomerOrderValues.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

--10
SELECT FirstName, LastName, OrderCount
FROM Customers c
LEFT JOIN (
SELECT CustomerID, COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY CustomerID
) AS CustomerOrderCount ON c.CustomerID = CustomerOrderCount.CustomerID;
