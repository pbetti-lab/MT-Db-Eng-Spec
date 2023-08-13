/*
	This file contains queries that allow to test how to SQL manage virtual tables also known views.
    Firsts queries create the database, the table and the data used to test SQL commands.
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
VALUES (1, '2021-11-11', 7, 5, 1)
	,(2, '2021-11-11', 5, 2, 2)
	,(3, '2021-11-12', 3, 3, 3)
	,(4, '2021-11-12', 1, 7, 4)
	,(5, '2021-11-12', 4, 4, 5)
	,(6, '2021-11-13', 12, 5, 1)
	,(7, '2021-11-13', 4, 8, 3)
	,(8, '2021-11-13', 6, 3, 5);

-- test create a view with relevant data from joined table cuatomers and bookings
CREATE VIEW BestCustomers AS
SELECT c.FullName
	,c.PhoneNumber
    ,b.BookingDate
    ,b.NumberOfGuests
FROM Customers c
	inner join Bookings b
		on b.CustomerId = c.CustomerId
WHERE b.NumberOfGuests >= 5;

SELECT * FROM BestCustomers; 	-- check the view created

-- test updating data in view can update the below table
UPDATE BestCustomers
SET PhoneNumber = '757536111'
WHERE FullName = 'Vanessa McCarthy';

SELECT * FROM BestCustomers; 	-- check the updated view 
SELECT * FROM Customers c;		-- check the updated table below

-- test alter the structure of a view. Note: this command perform a drop view then a create view so the user needs 
-- relevant permissions. The original will be dropped so if you wanto to add a field you muust recreate the previous
-- view plus the new field
ALTER VIEW BestCustomers AS
SELECT c.CustomerId 
	,c.FullName
	,c.PhoneNumber
    ,b.BookingDate
    ,b.NumberOfGuests
FROM Customers c
	inner join Bookings b
		on b.CustomerId = c.CustomerId
WHERE b.NumberOfGuests >= 5;

SELECT * FROM BestCustomers; 	-- check the altered view 

-- test insert data in a view. Note: data can be insert one table per time (if the view came from a join) and only 
-- if not included field in the below table can set default values. 
INSERT INTO BestCustomers (CustomerId, FullName, PhoneNumber)
VALUES (6, 'Manual Customer To View', '99999999');

SELECT * FROM BestCustomers; 	-- check the updated view. Note: insert haven't change values because of the view join and where condition 
SELECT * FROM Customers c;		-- check the updated table below. Note: a new customer has been added

-- test droping view
DROP VIEW BestCustomers;

-- test is finished. Drop the database
-- drop database little_lemon; 
