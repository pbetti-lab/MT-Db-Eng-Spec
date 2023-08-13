/*
	This file contains queries that allow to test how to SQL manage constraints.
    Firsts queries create the database, the table and the data used to test SQL commands.
    
    note: 
    Constraints are used to define the rules that maintain data in tables to ensure data validity, accuracy, consistency 
    and reliability. There are three main types of constraints that can be applied in MySQL:

	Key Constraints are constraints applied to a relational database to ensures no duplications of records and data 
    integrity. Example of key constraints are primary key or unique. 

	Domain constraints are special rules defined for the values that can be stored for a certain column like not null, 
    default or check
	
	Referential Integrity Constraints are constraints applied to a relational database to ensures integrity between relationship.
    A foreign key in one table linked to a primary key (or a unique key) in another table is a referential integrity constraints
    
*/


CREATE DATABASE IF NOT EXISTS little_lemon; 

USE little_lemon;

CREATE TABLE Customers (
	Id int not null primary key								-- set a primary key			(key constraint)
    ,FullName VARCHAR(100) NOT NULL 						-- set a not null constraint	(domain constraint)
    ,PhoneNumber VARCHAR(20) unique							-- set a unique constraint		(key constraint)
);

CREATE TABLE Booking (
	Id int not null primary key								-- set a primary key			(key constraint)
    ,BookDate date default(current_date())					-- set a default constraint		(domain constraint)
    ,NumberOfGuest int check(NumberOfGuest <= 8)			-- set a check constraint		(domain constraint)
    ,CustomerId int not null
    ,foreign key (CustomerId) references Customers(Id)		-- set a foreign key 			(referential integrity constraints)
);


/*
	note: a primary key and a foreign key may also be declared explicitly to define a name for the constraints
	
    CREATE TABLE Customers (
		Id int not null
        ...field...
        ...field...
        ,constraint PK_Customers_Id primary key (Id) 
	);

	CREATE TABLE Orders (
		Id int not null
        ,CustomerId int not null
        ...field...
        ...field...
        ,constraint FK_Customers_Id_Orders_Id foreign key (CustomerId) references Customers(Id) 
	);

*/

-- test customers table schema
SHOW COLUMNS FROM Customers;

-- test booking table schema
SHOW COLUMNS FROM Booking;

-- test is finished. Drop the database
-- drop database little_lemon;
