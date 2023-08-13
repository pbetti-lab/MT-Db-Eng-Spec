/*
	This file contains queries that allow to test the replace command.
    Firsts queries create the database, the table and the data used to test SQL commands
*/


CREATE DATABASE IF NOT EXISTS little_lemon; 

USE little_lemon;

CREATE TABLE Starters (
	StarterName VARCHAR(100) NOT NULL PRIMARY KEY
    ,Cost Decimal(3,2)
    ,StaterType VARCHAR(100) DEFAULT 'Mediterranean'
);


-- test replace command used as insert command
REPLACE INTO Starters (StarterName, Cost)
VALUES ('Salmon and butter', 8.50);
-- note: when all the field aren't specified in the values, column names are mandatory

REPLACE INTO Starters
VALUES ('Olive Bruschetta', 6.50, 'Meditteranean');
-- note: when all the field aren't specified in the values, column names are mandatory

-- test replace command used as update command. Cost will be replaced because of the primary key StarterName
REPLACE INTO Starters
VALUES ('Olive Bruschetta', 7.50, 'Meditteranean');
-- note: using replace into in a table without primary or unique key the result is the same as the insert into 

-- test replace command used as update command with set
REPLACE INTO Starters
set StarterName = 'Olive Bruschetta';
-- note: Cost value became null and StarterType became Meditteranean because it is setting with default value

REPLACE INTO Starters
set StarterName = 'Olive Bruschetta', Cost = 8.90;
-- note: Cost value now became 8.90 and StarterType became Meditteranean because it is setting with default value

REPLACE INTO Starters
set StarterName = 'Tomato Bruschetta', Cost = 6.90;
-- note: StarterName doesn't exist so a new record has been added


-- test is finished. Drop the database
DROP DATABASE little_lemon;