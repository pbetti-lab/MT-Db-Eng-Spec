/*
	This file contains queries that allow to test how SQL manage sorting and filtering.
    Firsts queries create the database, the table and the data used to test SQL commands
*/

CREATE DATABASE my_company_db;

USE my_company_db;

CREATE TABLE Employee (
	Id int not null primary key,
    Name varchar(75),
    City varchar(75),
    Salary decimal default 0,
    Allowance decimal default 0,
    Tax decimal default 0
);

INSERT INTO Employee 
VALUES (1, "Antony", "London", 24000, 1000, 1500),
	(2, "Jhon", "London",32000, 2000, 2000),
	(3, "Rebecca", "Paris", 47000, 3000, 4500),
	(4, "Rey", "Berlin", 27000, 1300, 1400),
	(5, "Sara", "Berlin", 30000, 1700, 1900),
	(6, "Rose", "Berlin", 36000, 2500, 2300),
    (7, "Albert", "Rome", 29000, 1100, 1800);


-- testing the result of distinct by the city field 
SELECT DISTINCT City FROM Employee; 

-- testing the result of distinct by the city and name fields 
SELECT DISTINCT City, NAME FROM Employee;

-- testing the result of "order by" 
SELECT DISTINCT City
FROM Employee
ORDER BY City; -- note without order specification the default is ascending 

-- testing the result of "order by" with ascending and descending salary
SELECT * FROM Employee ORDER BY Salary; 
-- OR
SELECT * FROM Employee ORDER BY Salary ASC; 

SELECT * FROM Employee ORDER BY Salary DESC; 

-- testing the result of "filtering" and "order by" 
SELECT Name
	,City
FROM Employee 
WHERE Salary >= 30000 
ORDER BY Salary DESC; 

SELECT DISTINCT City
FROM Employee 
WHERE City LIKE '%o%'
ORDER BY City DESC; 

-- test is finished. Drop the database
DROP DATABASE my_company_db;


