/*
	This file contains queries that allow to test how to SQL manage functions and stored procedure.
    Firsts queries create the database, the table and the data used to test SQL commands.
*/


CREATE DATABASE little_lemon; 

USE little_lemon;

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


-- test how to declare and use a variable outside a stored function or procedure

set @MaxOrderQuantity = 0;

select @MaxOrderQuantity :=  max(Quantity)
from Orders
where orderDate = '2023-08-01';

select @MaxOrderQuantity;

set @MaxOrderQuantity = null;
 
-- test how to declare and use function with variable declaration

delimiter //
drop function if exists MaxOrderQuantity//
create function MaxOrderQuantity(orderDate date) returns int deterministic  -- if not specified the system assumes that the result is not deterministic
begin
	declare _maxOrderQuantity int default(0);
	
	select max(Quantity) into _maxOrderQuantity
	from Orders
	where orderDate = orderDate;
        
    return _maxOrderQuantity;
end//
delimiter ;

select MaxOrderQuantity('2023-08-01');

-- test how to declare and use stored procedure
delimiter //
drop procedure if exists GetMaxOrder//
create procedure GetMaxOrder(in orderDate date, out productName varchar(50), out quantity int)
begin
	declare _productName varchar(50) default null;
	declare _quantity int default(0);
	
	select o.ProductName
		,max(o.Quantity) as MaxQta 
	into _productName
	 	,_quantity
    from Orders o
	where o.OrderDate = orderDate
	group by o.ProductName	
    having MaxQta = (
		select max(oinner.Quantity) 
		from Orders oinner
	);
    
    set productName = _productName;
    set quantity = _quantity;
end//
delimiter ;

set @OrderProductName = null;
set @OrderQuantity = 0;

call GetMaxOrder('2023-08-01', @OrderProductName, @OrderQuantity);

select @OrderProductName, @OrderQuantity;    

-- test is finished. Drop the database
-- drop database little_lemon;