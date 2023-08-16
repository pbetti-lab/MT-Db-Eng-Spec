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

create table OrderDeleteRowLog (
    Message varchar(500) not null
	,DeleteOn datetime not null
);

-- test create trigger to prevent null or negative value in Orders.QuantityPurchease
delimiter $$
create trigger Orders_BeforeInser_QuantityPurchease_Validation
before insert
on Orders for each row
begin
	set new.QuantityPurchease = ifnull(new.QuantityPurchease, 0);

	if new.QuantityPurchease < 0
	then set new.QuantityPurchease = 0;
    end if;
end $$
delimiter ;

-- test create trigger to log null or negative value in Orders.QuantityPurchease
delimiter $$
create trigger Orders_BeforeDelete_Log
after delete
on Orders for each row
begin
	declare message varchar(500);
    
    set message = concat(
		"Order row as been delete: Id: "
        ,old.id
		," - Customer: "
        ,old.CustomerName
        ," - ProductName: "  
        ,old.CustomerName
        ," - QuantityPurchease: "
        ,old.QuantityPurchease
	);

	insert into OrderDeleteRowLog 
    values (message, now());
end $$
delimiter ;


insert into Orders 
values (1, "Jhon Smith", "Soup", null, current_date())
	,(2, "Adam Black", "Spark water", -3, current_date())
	,(3, "Rose Red", "Drinks", 2, current_date())
	,(4, "Jessica Green", "Pizza", 1, current_date());
    
delete from Orders 
where id = 3;

-- check insert order with validation trigger
select * from Orders;

-- check insert log trigger
select * from OrderDeleteRowLog;


-- test drop triggers 
drop trigger Orders_BeforeInser_QuantityPurchease_Validation;

-- check insert order without validation trigger
insert into Orders 
values (5, "Sam Gray", "Humus", -3, current_date());

select * from orders
where id = 5;


-- test insert event that work one single time
create table CurrentDayReportOrders ( 
	Id int not null primary key
    ,CustomerName varchar(100) not null
    ,ProductName varchar(100) not null
    ,QuantityPurchease int 
);

create table HistoricalOrders ( 
	Id int not null primary key
    ,CustomerName varchar(100) not null
    ,ProductName varchar(100) not null
    ,QuantityPurchease int 
);

delimiter $$
create event CopyToCurrentDayReportOrders
on schedule at current_timestamp() + interval 3 hour
do
begin
	truncate CurrentDayReportOrders;

	insert into CurrentDayReportOrders
    select * 
    from Orders
    where OrderDate = current_date();
end $$
delimiter ;

delimiter $$
create event CopyToHistoricalOrdersReportOrders
on schedule every 1 day
do
begin
	insert into HistoricalOrders
    select * 
    from Orders
    where OrderDate = current_date();
end $$
delimiter ;
        
-- test is finished. Drop the database
-- drop database little_lemon;
