/*
	This file contains queries that allow to test how SQL goup data.
    Firsts queries create the database, the table and the data used to test SQL commands
*/

CREATE DATABASE luckyshrub_db;

USE luckyshrub_db;

CREATE TABLE Orders (
	OrderID INT
    ,Department VARCHAR(100)
    ,OrderDate DATE
    ,OrderQty INT
    ,OrderTotal INT
    ,PRIMARY KEY(OrderID)
);

INSERT INTO Orders 
VALUES (1,'Lawn Care','2022-05-05',12,500)
	,(2,'Decking','2022-05-22',150,1450)
    ,(3,'Compost and Stones','2022-05-27',20,780)
    ,(4,'Trees and Shrubs','2022-06-01',15,400)
    ,(5,'Garden Decor','2022-06-10',2,1250)
    ,(6,'Lawn Care','2022-06-10',12,500)
    ,(7,'Decking','2022-06-25',150,1450)
    ,(8,'Compost and Stones','2022-05-29',20,780)
    ,(9,'Trees and Shrubs','2022-06-10',15,400)
    ,(10,'Garden Decor','2022-06-10',2,1250)
    ,(11,'Lawn Care','2022-06-25',10,400)
    ,(12,'Decking','2022-06-25',100,1400)
    ,(13,'Compost and Stones','2022-05-30',15,700)
    ,(14,'Trees and Shrubs','2022-06-15',10,300)
    ,(15,'Garden Decor','2022-06-11',2,1250)
    ,(16,'Lawn Care','2022-06-10',12,500)
    ,(17,'Decking','2022-06-25',150,1450)
    ,(18,'Trees and Shrubs','2022-06-10',15,400)
    ,(19,'Lawn Care','2022-06-10',12,500)
    ,(20,'Decking','2022-06-25',150,1450)
    ,(21,'Decking','2022-06-25',150,1450);
    

-- testing Group By clause filter duplicates as DISTINCT
SELECT Department 
FROM Orders
GROUP BY Department;

-- testing Group By clause to group order totals by department
SELECT Department
	,sum(OrderTotal)
FROM Orders
GROUP BY Department;

-- testing Group By clause to group order totals by days
SELECT OrderDate
	,sum(OrderTotal)
FROM Orders
GROUP BY OrderDate;

-- testing Group By clause with HAVING to group order totals by department and filter grouped data
SELECT Department, sum(OrderTotal) as Total 
FROM Orders
GROUP BY Department
HAVING Total > 2300;

-- testing HAVING without GROUP BY that act like WHERE clause
SELECT Department
FROM Orders
HAVING Department = 'Lawn Care';

-- testing GROUP BY and HAVING with logical operator
SELECT OrderDate
    ,avg(OrderTotal) as AvgTotal
FROM Orders
GROUP BY OrderDate
HAVING AvgTotal BETWEEN 0 and 1000
	AND OrderDate BETWEEN '2022-05-01' and '2022-05-30';

-- testing GROUP BY, HAVING and ANY
SELECT Department, sum(OrderTotal) as Total 
FROM Orders
GROUP BY Department
HAVING Department = ANY (
		SELECT Department 
		FROM Orders 
		WHERE Department in ('Decking', 'Compost and Stones')
    );

-- testing GROUP BY, HAVING and ALL
SELECT Department, sum(OrderTotal) as Total 
FROM Orders
GROUP BY Department
HAVING Department = ALL (
		SELECT Department
		FROM Orders 
		WHERE OrderId = 1
    );

-- testing UNION to get all the data that have similar column (by type and disposition) from different queries 
-- (and also from different table)
-- note UNION by default exclude duplicates, UNION ALL include also duplicates
SELECT Department, OrderDate
FROM Orders
WHERE Department = 'Decking'
UNION 
SELECT Department, OrderDate
FROM Orders
WHERE Department = 'Trees and Shrubs';

SELECT Department, OrderDate
FROM Orders
WHERE Department = 'Decking'
UNION ALL
SELECT Department, OrderDate
FROM Orders
WHERE Department = 'Trees and Shrubs';

-- test is finished. Drop the database
DROP DATABASE luckyshrub_db;

