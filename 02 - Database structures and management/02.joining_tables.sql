/*
	This file contains queries that allow to test how SQL join tables.
    Firsts queries create the database, the table and the data used to test SQL commands
*/

CREATE DATABASE little_lemon; 

USE little_lemon;

CREATE TABLE Customers (
	CustomerID INT NOT NULL PRIMARY KEY, 
    FullName VARCHAR(100) NOT NULL, 
    PhoneNumber INT NOT NULL UNIQUE
);
    
INSERT INTO Customers (CustomerID, FullName, PhoneNumber) 
VALUES (1, "Vanessa McCarthy", 0757536378)
	,(2, "Marcos Romero", 0757536379)
    ,(3, "Hiroki Yamane", 0757536376)
    ,(4, "Anna Iversen", 0757536375)
	,(5, "Diana Pinto", 0757536374);

CREATE TABLE Bookings (
	BookingID INT NOT NULL PRIMARY KEY,  
    BookingDate DATE NOT NULL,  
    TableNumber INT NOT NULL, 
    NumberOfGuests INT NOT NULL CHECK (NumberOfGuests <= 8), 
    CustomerID INT NOT NULL, 
    FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID) ON DELETE CASCADE ON UPDATE CASCADE
); 

INSERT INTO Bookings (BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) 
VALUES (10, '2021-11-11', 7, 5, 1)
	,(11, '2021-11-10', 5, 2, 2)
	,(12, '2021-11-10', 3, 2, 4);

CREATE TABLE Employees (
	Id int not null,
	FullName varchar(150) default null,
	ContactNo varchar(12) default null,
	Email varchar(100) default null,
	JobTitle varchar(100) default null,
    LineManagerId int not null,
	AnnualSalary int default null,
    constraint PK_EmployeeID  primary key (Id)
);

INSERT INTO Employees VALUES 
	(1,'Seamus Hogan', '351478025', 'Seamus.h@luckyshrub.com', 'Manager', 3, 50000), 
	(2,'Thomas Eriksson', '351475058', 'Thomas.e@luckyshrub.com', 'Assistant', 1, 75000), 
	(3,'Simon Tolo', '351930582','Simon.t@luckyshrub.com', 'Head Chef', 3, 40000), 
	(4,'Francesca Soffia', '351258569','Francesca.s@luckyshrub.com', 'Assistant', 1, 45000), 
	(5,'Emily Sierra', '351083098','Emily.s@luckyshrub.com', 'Accountant', 1, 35000), 
	(6,'Maria Carter', '351022508','Maria.c@luckyshrub.com', 'Accountant', 3, 55000),
	(7,'Rick Griffin', '351478458','Rick.G@luckyshrub.com', 'Sous Chef', 3, 50000);
    
    
-- testing inner join to get all the rows that have values in both tables
SELECT c.FullName
	,c.PhoneNumber
    ,b.BookingDate
    ,b.NumberOfGuests
FROM Customers c
	INNER JOIN Bookings b
		ON b.CustomerID = c.CustomerId;
        
-- testing left join to get all the rows from the left table and the rows that have a reference on the right 
-- (in this case it is possible to have null values on the left table for all customers that have never booked before)
SELECT c.FullName
	,c.PhoneNumber
    ,b.BookingDate
    ,b.NumberOfGuests
FROM Customers c
	LEFT JOIN Bookings b
		ON b.CustomerID = c.CustomerId;
        
-- testing right join to get all the rows from the right table and the rows that have a reference on the left 
-- (in this case it is possible to have null values on the right table)
SELECT c.FullName
	,c.PhoneNumber
    ,b.BookingDate
    ,b.NumberOfGuests
FROM Customers c
	RIGHT JOIN Bookings b
		ON b.CustomerID = c.CustomerId;
        
-- testing self join. in a self join you can use INNER, LEFT or RIGHT join. The table is auto referenced but the system is able 
-- to see the same table as two different table using aliases. This kind of join is mainly used to estract data from table 
-- that contains information that can be referenced like parent-child information
SELECT e1.FullName as LineManager
	,e2.FullName as Employee
FROM Employees e1
	INNER JOIN Employees e2
		ON e1.Id = e2.LineManagerId
ORDER BY LineManager, Employee;


-- test is finished. Drop the database
DROP DATABASE little_lemon;
