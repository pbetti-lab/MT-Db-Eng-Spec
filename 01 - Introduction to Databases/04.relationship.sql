/*
	This file contains queries that allow to test how SQL manage relationship.
    Firsts queries create the database, the table and the data used to test SQL commands

	Relationship are grouped into three main groups
		- One-to-one: the kind of relationship who links only one element in a table to only one another element in another table;
		- One-to-many: the kind of relationship who links one element in a table to many another elements in another table;
		- Many-to-many: the kind of relationship who links many elements in a table to many another elements in another table;

	The test context is about a company who rent car in an airport. Relationship that we want to explore are between cutomers and 
    driver license (one-to-one), customer and rent order (one-to-many), customer and cars (many to many)

	note: when relationship are created the order in which tables area created matters. relationship preserve the data integrity
		  so it's not allowed the creation of a table that contain foreign key reference before the table referenced.
*/

CREATE DATABASE hot_wheels_db;

USE hot_wheels_db;

CREATE TABLE DriverLicences (
	Id int not null,
	Licence varchar(50) not null,
    constraint PK_DriverLicenceId primary key (Id)
);

CREATE TABLE Customers (
	Id int not null,
    Name varchar(50) not null,
    Surname varchar(50) not null,
    DriverLicenceId int not null,
    constraint PK_CustomerId primary key (Id),
    constraint FK_Customers_DriverLicenceId_DriverLicences_Id foreign key (DriverLicenceId) references DriverLicences(Id)	
);

CREATE TABLE Cars (
	Id int not null,
	Brand varchar(50) not null,
    Model varchar(50) not null,
    LicencePlate varchar(50) not null,
    constraint PK_CarId primary key (Id)
);

CREATE TABLE Orders (
	Id int not null,
    CustomerId int not null,
	CarId int not null,
    RentPeriodInDays int not null default 1, 
    TotalPrice decimal not null default 0,
    constraint PK_OrderId primary key (Id),
    constraint FK_Orders_CustomerId_Customers_Id foreign key (CustomerId) references Customers(Id),
    constraint FK_Orders_CarId_Cars_Id foreign key (CarId) references Cars(Id)
);

CREATE TABLE CustomersToCars (
	CustomerId int not null,
    CarId int not null,
    constraint PK_CustomersToCars primary key (CustomerId, CarId)
);

INSERT INTO DriverLicences 
VALUES (1, "AB-123-GD"),
	(2, "GS-345-HS"),
    (3, "OL-462-LO"),
    (4, "WD-936-PL"),
    (5, "PS-635-YY");

INSERT INTO Customers 
VALUES (1, "Jhon", "Smith", 1),
	(2, "Rose", "Red", 2),
    (3, "Jack", "Green", 3),
    (4, "Adam", "Black", 4),
    (5, "Samantha", "Grey", 5);

INSERT INTO Cars 
VALUES (1, "FIAT", "Panda", "AHF-846"),
	(2, "Volkswagen", "Golf", "OSE-643"),
    (3, "Peugeot", "C3", "VCF-359"),
    (4, "Mercesdes", "Classe A", "PSK-034"),
    (5, "BMV", "118i", "CXR-748");

INSERT INTO Orders
VALUES (1, 1, 3, 2, 500),
	(2, 4, 4, 7, 1500),
	(3, 2, 1, 2, 350),
	(4, 5, 5, 8, 2500),
	(5, 2, 3, 3, 750),
	(6, 4, 1, 3, 750);
    
INSERT INTO CustomersToCars
VALUES (1, 3),
	(4, 4),
	(2, 1),
	(5, 5),
	(2, 3),
    (4, 1);


-- test relationshib one-to-one
SELECT Customers.Name
	,Customers.Surname
    ,DriverLicences.Licence   
FROM Customers
	JOIN DriverLicences
		ON DriverLicences.Id = Customers.DriverLicenceId;

-- test relationshib one-to-many
SELECT Orders.Id
	,CONCAT(Cars.Brand, " ", Cars.Model) 
    ,Orders.RentPeriodInDays 
    ,Orders.TotalPrice
FROM Orders
	JOIN Cars
		ON Orders.CarId = Cars.Id;

-- test relationshib many-to-many
SELECT CONCAT(Customers.Name, " ", Customers.Surname) 
	,CONCAT(Cars.Brand, " ", Cars.Model) 
	,Cars.LicencePlate
FROM CustomersToCars
	JOIN Customers
		ON Customers.Id = CustomersToCars.CustomerId
	JOIN Cars
		ON Cars.Id = CustomersToCars.CarId;


-- test is finished. Drop the database
DROP DATABASE hot_wheels_db;