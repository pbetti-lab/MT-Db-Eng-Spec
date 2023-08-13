/*
	This file contains queries that allow to test how to SQL manage altering e copying actions.
    Firsts queries create the database, the table and the data used to test SQL commands.
*/

create database little_lemon;

use little_lemon;

create table Customers (
	Id int not null primary key
    ,FullName varchar(50) not null
    ,PhoneNumber varchar(10) 
    ,Age int not null
);

-- test rename column from FullName to Name and change valuetype
alter table Customers change FullName Name varchar(30) not null;

-- test modify valuetype and add constraint
alter table Customers modify PhoneNumber int not null unique;

-- note: change e modify are similar but change allow also to rename column

-- test add column for Surname
alter table Customers add Surname varchar(50) not null;
    
-- test drop column for Age
alter table Customers drop Age;

-- test alter table with multiple actions 
alter table Customers add Email varchar(100) not null unique
	,add Address varchar(100) 
    ,drop index PhoneNumber	-- to remove the previous unique constraint
    ,modify PhoneNumber varchar(20) unique
	,drop Id
    ,add CustomerId int not null primary key;

-- add values to the table to test 
insert into Customers(CustomerId, Name, Surname, PhoneNumber, Email, Address)
values (1, 'Jhon', 'Smith', '1234567', 'jsmith@mail.com', null)
	,(2, 'Rose', 'Red', '1234568', 'rred@mail.com', null) 
	,(3, 'Adam', 'Black', '1234569', 'ablack@mail.com', null) 
	,(4, 'Daphne', 'Green', '1234577', 'dgreen@mail.com', null) 
	,(5, 'Roland', 'Gray', '1234587', 'rgray@mail.com', null);

-- test simple table copy. note this command do not copy the key and unique constraint
create table CustomersBackup 
select * 
from Customers;

-- test partial table copy. note this command do not copy key and unique constraint
create table CustomersPartialBackup 
select Name
	,Surname
    ,Email 
from Customers
where CustomerId in (1,2,3);

-- test copy the entire structure of the table (with key and unique constraints) and all data 
create table CustomersCompleteBackup like Customers;
insert into CustomersCompleteBackup 
select * 
from Customers;

-- test copy tables between databases. Note that the create/select command behaviour is the same as the commmands used 
-- inside the same database so key and unique are not created without using create/like command
create database little_lemon_backup;

create table little_lemon_backup.Customers 
select * 
from little_lemon.Customers;

create table little_lemon_backup.Customers2 like little_lemon.Customers;
insert into little_lemon_backup.Customers2 
select * 
from little_lemon.Customers;

-- test is finished. Drop the database
-- drop database little_lemon; 
-- drop database little_lemon_backup; 