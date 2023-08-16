/*
	This file contains queries that allow to test how to SQL manage functions.
    Firsts queries create the database, the table and the data used to test SQL commands.
*/


CREATE DATABASE mysql_functions; 

USE mysql_functions;

CREATE TABLE Orders (
	ProductName varchar(50) not null
	,Quantity int not null
    ,OrderDate date not null
);
  
INSERT INTO Orders
VALUES ('Pizza', 3, '2023-08-01') 
	,('Cucumbers', 1, '2023-08-01')
	,('Ice Cream', 3, '2023-08-01')
	,('Pizza', 4, '2023-08-01')
	,('Cucumbers', 5, '2023-08-01')
	,('Ice Cream', 8, '2023-08-01')
	,('Pizza', 6, '2023-08-01');
    
CREATE TABLE SalesRevenue (
	ItemId int not null primary key
    ,Category varchar(50) default null
	,Quarter1 decimal not null
    ,Quarter2 decimal not null
    ,Quarter3 decimal not null
    ,Quarter4 decimal not null
);

INSERT INTO SalesRevenue 
VALUES (1, 'Starter', 1000, 980, 1100, 890) 
	,(2, 'Starter', 500, 540, 450, 480) 
	,(3, 'Drinks', 873, 902, 863, 910) 
	,(4, null, 129, 104, 156, 100) 
	,(5, 'Drinks', 976, 1120, 1290, 1250) 
	,(6, null, 436, 498, 469, 512) 
	,(7, 'Drinks', 675, 713, 698, 736); 


-- test aggregate function
select ProductName
	,count(*) as NumberOfOrders 
    ,avg(Quantity) as AverangePerOrder
    ,max(Quantity) as MaximunPerOrder
    ,min(Quantity) as MinimunPerOrder
    ,sum(Quantity) as SumPerProduct
from Orders 
where OrderDate = '2023-08-01'
group by ProductName;

-- test math functions
select ProductName
	,round(avg(Quantity), 2) as RoundAverangePerOrder
    ,mod(sum(Quantity), 2) as ModuleOfSumDivideByTwo
from Orders 
where OrderDate = '2023-08-01'
group by ProductName;

-- test string functions
select ProductName
	,concat(sum(Quantity), " sold on ", OrderDate) as Concat
	,substring(ProductName, 1, 4) as ProductNameSubstringOfFourChar
    ,ucase(ProductName) as UpperCaseProductName
    ,lcase(ProductName) as LowerCaseProductName
from Orders 
where OrderDate = '2023-08-01'
group by ProductName;

-- test date functions
select 
	current_date()
	,current_time()
    ,date_format(current_date(), "%M") as CurrentMonth
    ,datediff('2023-12-25', current_date()) as DaysToChristmas2023;
    
-- test comparison functions
select 
	ItemId, 
    greatest(Quarter1, Quarter2, Quarter3, Quarter4) as GreatestQuarter
    ,least(Quarter1, Quarter2, Quarter3, Quarter4) as LowestQuarter    
from SalesRevenue;

select 
	ItemId 
    ,greatest(Quarter1, Quarter2, Quarter3, Quarter4) as GreatestQuarter
    ,least(Quarter1, Quarter2, Quarter3, Quarter4) as LowestQuarter    
from SalesRevenue
where isnull(category);

-- test flow control
select 
	ItemId 
    ,case 
		when isnull(Category) then 'Unknown'
        else Category
	end as Category
    ,case 
		when least(Quarter1, Quarter2, Quarter3, Quarter4) < 500 then "Loos"
        else "Profit"
	end as ProfitOrLoss
from SalesRevenue

-- test is finished. Drop the database
-- drop database mysql_functions

