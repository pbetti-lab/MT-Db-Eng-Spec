# this file contain a set of common command used in SQL 

-- this command allow to create a database and it's part of the DDL (Data Definition Language)
CREATE DATABASE TEST_COMMAND_DB;

-- this command set the database as the default database for the following queries
USE TEST_COMMAND_DB;

-- this command allow to create a table in the current database and it's part of the DDL (Data Definition Language)
-- field are defined by name type [opt: default_value] [opt: definition_of_primary_key]
CREATE TABLE CUSTOMER (
	Id int not null primary key,
    FullName varchar(50) default 'Unknown User',
    ActivationDate date default null
);

-- this command allow to modify a table to add/delete a column in and it's part of the DDL (Data Definition Language)
ALTER TABLE CUSTOMER ADD COLUMN Age int not null default 0;

ALTER TABLE CUSTOMER DROP COLUMN ActivationDate;

-- this command allow to insert single or multiple data row in a table and it's part of the DML (Data Manipulation Language)
INSERT INTO CUSTOMER 
VALUES (1, "Jhon Smith", 34);

INSERT INTO CUSTOMER 
VALUES (2, "Adrian Black", 29),
	(3, "Paul Green", 32),
    (4, "Adam Purple", 27),
    (5, "Rose Red", 25);

-- this command retrieve the list of all data in a table and it's part of the DML (Data Manipulation Language)
SELECT * 
FROM CUSTOMER;

-- this command allow to edit data in a table and it's part of the DML (Data Manipulation Language)
UPDATE CUSTOMER 
SET FullName = "Paul Greenleaf"
WHERE Id = 3;

-- this command allow to delete data from a table and it's part of the DML (Data Manipulation Language)
DELETE FROM CUSTOMER 
WHERE Id = 3;

DELETE FROM CUSTOMER; -- without any condition allow to delete all the data in the table 

-- note previous command from the DML that allow to insert, read, update and delete 
-- are also known as CRUD (create or insert, read or select, update delete)

-- this commands allow to delete all the data of a table and it's part of the DDL (Data Definition Language)
TRUNCATE CUSTOMER;

-- this commands allow to delete the table and it's part of the DDL (Data Definition Language)
DROP TABLE CUSTOMER;

-- this commands allow to delete the database and it's part of the DDL (Data Definition Language)
DROP DATABASE test_command_db;

/*
	note: other command that will be testd in the future are contained in other command subset like 
	DCL (Data Control Language) who contains commands used to manage privileges for the database users like:
		- GRANT Command to provide the user of the database with the privileges required to allow users to access and manipulate the database;
		- REVOKE Command to remove permissions from any user;
	TCL (Transaction Control Language) who contains commands used to manage transactions in the database like:
		- COMMIT Command to save all the work you have already done in the database. 
		- ROLLBACK Command to restore a database to the last committed state.	
*/
