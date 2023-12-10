--Task 1(Database Design)

CREATE DATABASE SISDB
  
CREATE TABLE Students(
student_id INT PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30),
date_of_birth DATE,
email VARCHAR(50),
phone_number VARCHAR(10)
);

CREATE TABLE Courses(
course_id INT PRIMARY KEY,
course_name VARCHAR(50),
credits INT,
teacher_id INT,
FOREIGN KEY (teacher_id) REFERENCES Teacher (teacher_id)
);

CREATE TABLE Enrollments (
enrollment_id INT PRIMARY KEY,
student_id INT,
course_id INT,
enrollment_date DATE,
FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Teacher (
teacher_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100)
);

CREATE TABLE Payments (
payment_id INT PRIMARY KEY,
student_id INT,
amount DECIMAL(10, 2),
payment_date DATE,
FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

--Inserting values into the database

INSERT INTO Students VALUES
(1, 'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890'),
(2, 'Jane', 'Smith', '1998-05-22', 'jane.smith@example.com',
'9876543210'),
(3, 'Alice', 'Johnson', '1997-11-30', 'alice.johnson@example.com',
'5555555555'),
(4, 'Bob', 'Williams', '1996-04-10', 'bob.williams@example.com',
'7777777777'),
(5, 'Eva', 'Brown', '1999-09-18', 'eva.brown@example.com', '8888888888'),
(6, 'Charlie', 'Taylor', '1994-03-05', 'charlie.taylor@example.com',
'6666666666'),
(7, 'Sophia', 'Martin', '1993-01-25', 'sophia.martin@example.com',
'9999999999'),
(8, 'Daniel', 'Clark', '1992-07-12', 'daniel.clark@example.com',
'1111111111'),
(9, 'Olivia', 'Anderson', '1997-12-08', 'olivia.anderson@example.com',
'2222222222'),
(10, 'Michael', 'Davis', '1996-06-20', 'michael.davis@example.com',
'3333333333');

INSERT INTO Teacher VALUES
(1, 'Professor1', 'Johnson', 'professor1.johnson@example.com'),
(2, 'Professor2', 'Smith', 'professor2.smith@example.com'),
(3, 'Professor3', 'Brown', 'professor3.brown@example.com'),
(4, 'Professor4', 'Clark', 'professor4.clark@example.com'),
(5, 'Professor5', 'Taylor', 'professor5.taylor@example.com'),
(6, 'Professor6', 'Anderson', 'professor6.anderson@example.com'),
(7, 'Professor7', 'Martin', 'professor7.martin@example.com'),
(8, 'Professor8', 'Williams', 'professor8.williams@example.com'),
(9, 'Professor9', 'Davis', 'professor9.davis@example.com'),
(10, 'Professor10', 'White', 'professor10.white@example.com');

INSERT INTO Courses VALUES
(1, 'Mathematics', 3, 1),
(2, 'Physics', 4, 2),
(3, 'Chemistry', 3, 2),
(4, 'History', 3, 3),
(5, 'Computer Science', 4, 4),
(6, 'English Literature', 3, 4),
(7, 'Biology', 4, 5),
(8, 'Art', 2, 6),
(9, 'Economics', 3, 7),
(10, 'Psychology', 3, 8),
(11, 'Algebra', 9, 9),
(12, 'Geography', 2, 10);

INSERT INTO Enrollments VALUES
(101, 1, 1, '2023-01-15'),
(102, 2, 2, '2023-01-16'),
(103, 3, 2, '2023-01-17'),
(104, 4, 2, '2023-01-18'),
(105, 5, 3, '2023-01-19'),
(106, 6, 3, '2023-01-20'),
(107, 7, 4, '2023-01-21'),
(108, 8, 4, '2023-01-22'),
(109, 9, 5, '2023-01-23'),
(110, 10, 5, '2023-01-24');

INSERT INTO Payments VALUES
(1, 1, 100.00, '2023-02-01'),
(2, 2, 120.00, '2023-02-02'),
(3, 3, 90.00, '2023-02-03'),
(4, 4, 110.00, '2023-02-04'),
(5, 5, 80.00, '2023-02-05'),
(6, 6, 130.00, '2023-02-06'),
(7, 7, 95.00, '2023-02-07'),
(8, 8, 105.00, '2023-02-08'),
(9, 9, 75.00, '2023-02-09'),
(10, 10, 85.00, '2023-02-10');

--Tasks 2 (Select, Where, Between, AND LIKE)

--1
INSERT INTO Students VALUES (11, 'John', 'Doe', '1995-08-15',
'john.doe@example.com', '1234567890');

--2
INSERT INTO Enrollments VALUES (1, 1, 2, '2023-02-01');

--3
UPDATE Teacher
SET email = 'new.email@example.com'
WHERE teacher_id = 1;

--4
DELETE FROM Enrollments
WHERE enrollment_id=110 AND course_id=5;

--5
UPDATE Courses
SET teacher_id = 5 WHERE course_id = 11;

--6
DELETE FROM Enrollments WHERE student_id = 1;

-- Step 1: Delete related records in the Payments table
DELETE FROM Payments WHERE student_id = 1;

-- Step 2: Delete the student from the Students table
DELETE FROM Students WHERE student_id = 1;

--7
UPDATE Payments
SET amount = 300.00
WHERE payment_id=5;

--Task 3 (Aggregate functions, Having, Order By, GroupBy and Joins)

--1
SELECT s.first_name, s.last_name, SUM(p.amount) AS Total_payments FROM
Students s
JOIN Payments p ON p.student_id = s.student_id
WHERE p.student_id=4
GROUP BY s.first_name,s.last_name;

--2
SELECT C.course_id, C.course_name,
COUNT(E.student_id) AS enrolled_students_count
FROM Courses C
LEFT JOIN
Enrollments E ON C.course_id = E.course_id
GROUP BY C.course_id, C.course_name;

--3
SELECT s.student_id,s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e
ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

--4
SELECT s.first_name,s.last_name, c.course_name
FROM Students s
JOIN Enrollments e
ON s.student_id = e.student_id
JOIN Courses c ON c.course_id = e.course_id;

--5
SELECT t.teacher_id,c.course_id,t.last_name,c.course_name
FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id;

--6
SELECT
s.student_id,s.first_name,s.last_name,e.enrollment_date,c.course_name
FROM Students s
JOIN
Enrollments e ON s.student_id = e.student_id
JOIN
Courses c ON c.course_id = e.course_id;

--7
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN
Payments p ON s.student_id = p.student_id
WHERE p.amount is NULL;

--8
SELECT c.course_id,c.course_name
FROM Courses c
LEFT JOIN
Enrollments e ON c.course_id = e.course_id
WHERE e.course_id is NULL;

--9
SELECT
E.student_id,
S.first_name,
S.last_name
FROM
Enrollments E
JOIN
Students S ON E.student_id = S.student_id
GROUP BY
E.student_id, S.first_name, S.last_name
HAVING
COUNT(DISTINCT E.course_id) > 1;

--10
SELECT t.teacher_id, t.first_name,t.last_name
FROM Teacher t
LEFT JOIN
Courses c ON t.teacher_id = c.teacher_id
WHERE c.teacher_id is NULL;

--Task 4 (Subquery and its type)

--1
SELECT course_name, AVG(student_count) AS avg_students_enrolled
FROM (
SELECT c.course_name, COUNT(e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
) AS CourseStudentCount
GROUP BY course_name;

--2
SELECT s.student_id, s.first_name,s.last_name, p.amount
FROM Students s
JOIN
Payments p ON s.student_id = p.student_id
WHERE p.amount = (SELECT MAX(p.amount) FROM Payments p)

--3
SELECT
C.course_id,
C.course_name,
C.credits,
C.teacher_id,
COUNT(E.enrollment_id) AS enrollment_count FROM Courses C
LEFT JOIN
Enrollments E ON C.course_id = E.course_id
GROUP BY
C.course_id, C.course_name, C.credits, C.teacher_id
HAVING
COUNT(E.enrollment_id) = (SELECT MAX(enrollment_count) 
FROM (SELECT course_id, 
COUNT(enrollment_id) AS enrollment_count FROM Enrollments GROUP BY course_id) 
AS CourseEnrollmentCounts);

--4
SELECT
T.teacher_id,
T.first_name,
T.last_name,
SUM(P.amount) AS total_payments
FROM
Teacher T
JOIN
Courses C ON T.teacher_id = C.teacher_id
LEFT JOIN
Enrollments E ON C.course_id = E.course_id
LEFT JOIN
Payments P ON E.student_id = P.student_id
GROUP BY T.teacher_id, T.first_name, T.last_name;

--5
SELECT s.first_name, s.last_name
FROM Students s
WHERE (SELECT COUNT(DISTINCT e.course_id)
FROM Enrollments e
WHERE e.student_id = s.student_id) = (
SELECT COUNT(DISTINCT course_id) FROM Courses);

--6
SELECT t.teacher_id,t.first_name,t.last_name
FROM Teacher t
WHERE t.teacher_id NOT IN
(SELECT DISTINCT c.teacher_id FROM Courses c)

--7
SELECT
AVG(age) AS average_age
FROM (
SELECT
DATEDIFF(YEAR, date_of_birth, GETDATE()) AS age
FROM
Students
) AS StudentAges;

--8
SELECT c.course_id, c.course_name
FROM Courses c
WHERE c.course_id NOT IN (
SELECT DISTINCT e.course_id FROM Enrollments e)

--9
SELECT
E.student_id,
C.course_id,
SUM(P.amount) AS total_payments
FROM
Enrollments E
JOIN
Courses C ON E.course_id = C.course_id
LEFT JOIN
Payments P ON E.student_id = P.student_id
GROUP BY
E.student_id, C.course_id;

--10
SELECT
student_id
FROM
Payments
GROUP BY
student_id
HAVING
COUNT(payment_id) > 1;

--11
SELECT s.student_id,s.first_name,s.last_name, SUM(p.amount) AS
Total_payments
FROM Students s
LEFT JOIN Payments p
ON s.student_id = p.student_id
GROUP BY s.student_id,s.first_name,s.last_name

--12
SELECT c.course_id,c.course_name, COUNT(e.student_id) AS Student_Count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id=e.course_id
GROUP BY c.course_id,c.course_name;

--13
SELECT s.student_id,s.first_name,s.last_name,AVG(p.amount) AS
Averga_payment
FROM Students s
LEFT JOIN
Payments p ON s.student_id = p.student_id
GROUP BY s.student_id,s.first_name,s.last_name
