/*
	This file contains queries that allow to test how to SQL manage triggers and events.
    Firsts queries create the database, the table and the data used to test SQL commands.
*/

create database little_lemon;

use little_lemon;

create table Orders ( 
	Id int not null primary key
    ,CustomerName varchar(100) not null
    ,ProductName varchar(100) not null
    ,QuantityPurchease int 
    ,OrderDate date
);

insert into Orders 
values (1, "Jhon Smith", "Humus", 2, "2023-08-14")
	,(2, "Rose Red", "Soup", 1, "2023-08-14")
	,(3, "Adam Black", "Cesar Salad", 3, "2023-08-15")
	,(4, "Jennifer Green", "Pasta and Tomato Sauge", 5, "2023-08-15")
	,(5, "Alfonse Brown", "Salmon", 1, "2023-08-16")
	,(6, "James Gray", "Sea Cruditès", 3, "2023-08-16");
	

-- check current data 
select * from orders;

-- test transaction-rollback 
start transaction; -- this commend is the standard for sql. begin or begin work can also be used in MySQL
	update Orders set OrderDate = "2023-08-13" where Id = 1;
	insert into Orders values (7, "Roland Purple", "Stuffed vegetables", 2, "2023-08-18");
	delete from Orders where Id = 5;
	
    -- check data 
    select * from orders;  
    
    -- queries execution changes are visible on db but data are not already persisted
	-- suppose some error occour and you need to restore data	
    rollback;

    -- check data 
    select * from orders;  

    -- now situation has been restored at the moment before the strat transaction command
    
start transaction; -- second try
	update Orders set OrderDate = "2023-08-13" where Id = 1;
	insert into Orders values (7, "Roland Purple", "Stuffed vegetables", 2, "2023-08-18");
	delete from Orders where Id = 5;
commit;

    -- check data. now changes has been persisted
    select * from orders;  
    
-- --------------------------------------------------------------------------------------    


-- test cte (common table expressione) to simplified complex queries 
with 
	customers as (
		select CustomerName
			,OrderDate 
        from Orders
		where OrderDate >= "2023-08-15"
	)
	,products as (
		select CustomerName
			,ProductName
            ,QuantityPurchease 
        from Orders
		where QuantityPurchease >= 3
	)
select c.CustomerName
	,p.ProductName
    ,p.QuantityPurchease
    ,c.OrderDate
from customers c 
	join products p
where p.CustomerName = c.CustomerName;

-- test prepared statement. Note prepared statement are prepared one time and used every time needed
prepare GetOrderByDate from 'select * from Orders where OrderDate = ?';

set @orderDate = "2023-08-15";
execute GetOrderByDate using @orderDate;

set @orderDate = "2023-08-16";
execute GetOrderByDate using @orderDate;

-- test querying a json object inside a table
create table Activities (
	Id int not null primary key
    ,Attributes varchar(500) not null
);

insert into Activities 
values (1, '{"Id":"ACT001", "Name":"Check mail", "Done":"true" }')
	,(2, '{"Id":"ACT002", "Name":"Have shower", "Done":"true" }')
	,(3, '{"Id":"ACT003", "Name":"Have breakfast", "Done":"false" }');

select 
	Id
    ,Attributes->'$.Id'
    ,Attributes->'$.Name'
    ,Attributes->'$.Done'
from Activities
where Attributes->'$.Done' = 'false';


-- test is finished. Drop the database
-- drop database little_lemon;
