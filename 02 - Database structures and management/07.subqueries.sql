/*
	This file contains queries that allow to test how to SQL manage subqueries.
    Firsts queries create the database, the table and the data used to test SQL commands.
*/

create database if not exists little_lemon_db ;

use little_lemon_db;

CREATE TABLE MenuItems (
  ItemID int NOT NULL
  ,Name varchar(200) DEFAULT NULL
  ,Type varchar(100) DEFAULT NULL
  ,Price int DEFAULT NULL
  ,PRIMARY KEY (ItemID)
);

INSERT INTO MenuItems 
VALUES (1,'Olives','Starters',5)
	,(2,'Flatbread','Starters',5)
	,(3,'Minestrone','Starters',8)
	,(4,'Tomato bread','Starters',8)
	,(5,'Falafel','Starters',7)
	,(6,'Hummus','Starters',5)
	,(7,'Greek salad','Main Courses',15)
	,(8,'Bean soup','Main Courses',12)
	,(9,'Pizza','Main Courses',15)
	,(10,'Greek yoghurt','Desserts',7)
	,(11,'Ice cream','Desserts',6)
	,(12,'Cheesecake','Desserts',4)
	,(13,'Athens White wine','Drinks',25)
	,(14,'Corfu Red Wine','Drinks',30)
	,(15,'Turkish Coffee','Drinks',10)
	,(16,'Turkish Coffee','Drinks',10)
	,(17,'Kabasa','Main Courses',17);
    
-- test simple subquery
select *
from MenuItems
where ItemId = (
		select ItemId
        from MenuItems
        where name = 'Falafel'
    );

-- test subquery: get all starter greater or equal to the averange starter price
select *
	,(select avg(Price)
		from MenuItems
        where type = 'Starters'        
	) as AverangePrice
from MenuItems
where type = 'Starters'        
	and Price >= all (
		select avg(Price)
        from MenuItems
        where type = 'Starters'        
    );


-- test subquery: get all starter that have the name in the list of all item with a price grater than 5
select *
from MenuItems
where type = 'Starters'        
	and Name = any (
		select Name
        from MenuItems
        where Price > 5
    );

-- test subquery: get all starter that have the name in the list of all item with a price grater than or equal to 7
select *
from MenuItems as out_table
where Type = 'Starters'
	and exists (
		select *
        from MenuItems
        where out_table.Name = Name
			and Type = 'Starters'
			and Price >= 7
    );

-- test subquery: get all starter that have the name in the list of all item with a price lesser than 7
select *
from MenuItems as out_table
where Type = 'Starters'
	and not exists (
		select *
        from MenuItems
        where out_table.Name = Name
			and Type = 'Starters'
			and Price >= 7
    );

-- test is finished. Drop the database
-- drop database little_lemon; 
