/*
	This file contains queries that allow to test how SQL filter data using logical operators.
    Firsts queries create the database, the table and the data used to test SQL commands
*/

CREATE DATABASE luckyshrub_db; 

USE luckyshrub_db;

CREATE TABLE Employees (
	Id int not null,
	Name varchar(150) default null,
	Department varchar(150) default null,
	ContactNo varchar(12) default null,
	Email varchar(100) default null,
	AnnualSalary int default null,
	constraint PK_EmployeeID  primary key (Id)
);

INSERT INTO Employees VALUES 
	(1,'Seamus Hogan', 'Recruitment', '351478025', 'Seamus.h@luckyshrub.com', 50000), 
	(2,'Thomas Eriksson', 'Legal', '351475058', 'Thomas.e@luckyshrub.com', 75000), 
	(3,'Simon Tolo', 'Marketing', '351930582','Simon.t@luckyshrub.com', 40000), 
	(4,'Francesca Soffia', 'Finance', '351258569','Francesca.s@luckyshrub.com', 45000), 
	(5,'Emily Sierra', 'Customer Service', '351083098','Emily.s@luckyshrub.com', 35000), 
	(6,'Maria Carter', 'Human Resources', '351022508','Maria.c@luckyshrub.com', 55000),
	(7,'Rick Griffin', 'Marketing', '351478458','Rick.G@luckyshrub.com', 50000);
    
-- testing AND condition
SELECT * 
FROM Employees
WHERE Department = 'Marketing'
	AND AnnualSalary > 30000;
    
-- testing OR condition
SELECT * 
FROM Employees
WHERE Department = 'Marketing'
	OR Department = 'Finance';
    
-- testing IN condition
SELECT * 
FROM Employees
WHERE Department IN ('Finance', 'Human Resources', 'Recruitment');

-- testing BETWEEN condition
SELECT * 
FROM Employees
WHERE AnnualSalary BETWEEN 35000 AND 50000;

-- testing NOT condition
SELECT * 
FROM Employees
WHERE Department NOT IN ('Finance', 'Human Resources', 'Recruitment');

SELECT * 
FROM Employees
WHERE AnnualSalary NOT BETWEEN 35000 AND 50000;

-- testing LIKE condition
SELECT * 
FROM Employees
WHERE Name LIKE '%ri%';

SELECT * 
FROM Employees
WHERE Name LIKE 'ri%';

SELECT * 
FROM Employees
WHERE Name LIKE '%on';


-- test is finished. Drop the database
DROP DATABASE luckyshrub_db;
