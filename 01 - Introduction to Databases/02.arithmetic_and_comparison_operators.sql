/*
	This file contains queries that allow to test how SQL manage aritmethic and comparison operator.
    Firsts queries create the database, the table and the data used to test SQL commands
*/

CREATE DATABASE my_company_db;

USE my_company_db;

CREATE TABLE Employee (
	Id int not null primary key,
    Name varchar(75),
    Salary decimal default 0,
    Allowance decimal default 0,
    Tax decimal default 0
);

INSERT INTO Employee 
VALUES (1, "Antony", 24000, 1000, 1500),
	(2, "Jhon", 32000, 2000, 2000),
	(3, "Rebecca", 47000, 3000, 4500),
	(4, "Rey", 27000, 1300, 1800);


-- testing the result of Salary + Allowance
SELECT Name, Salary, Allowance, Salary + Allowance FROM Employee;

-- testing the result of double Salary 
SELECT Name, Salary, Salary * 2 FROM Employee;

-- testing the result of half Salary 
SELECT Name, Salary, Salary / 2 FROM Employee;

-- testing the result of Salary plus 10%
SELECT Name, Salary, Salary + ((Salary / 100) * 10) FROM Employee;
-- OR 
SELECT Name, Salary, Salary + (Salary * 0.10) FROM Employee;

-- testing the result of Salary minus Tax
SELECT Name, Salary, Salary - Tax FROM Employee;


-- testing the result of Salary grater then or equal to 32000
SELECT * 
FROM Employee
WHERE Salary >= 32000;

-- testing the result of Salary grater then 32000
SELECT * 
FROM Employee
WHERE Salary > 32000;

-- testing the result of Salary plus Allowance lesser then 32000
SELECT * 
FROM Employee
WHERE Salary + Allowance < 32000;

-- testing the result of Name different from Antony Allowance lesser then 32000
SELECT * 
FROM Employee
WHERE Name != 'Antony';


-- test is finished. Drop the database
DROP DATABASE my_company_db;





