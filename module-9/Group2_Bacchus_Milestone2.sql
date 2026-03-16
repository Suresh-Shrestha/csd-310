/*
    Title: Group2Bacchus.sql
    Author: Noah McCarthy, Jasmine Fontus, Suresh Shrestha
    Date: 3-2-2026
    Description: bacchus database initialization script.
*/

-- drop database user if exists 
DROP USER IF EXISTS 'bacchus_user'@'localhost';

-- create bacchus_user and grant them all privileges to the bacchus database 
CREATE USER 'bacchus_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'wine';

-- create database
CREATE DATABASE IF NOT EXISTS bacchus;

-- grant all privileges to the bacchus database to user bacchus_user on localhost 
GRANT ALL PRIVILEGES ON bacchus.* TO 'bacchus_user'@'localhost';

FLUSH PRIVILEGES;

USE bacchus;

-- drop tables if they are present
DROP TABLE IF EXISTS Supply_Orders;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Time_Record;
DROP TABLE IF EXISTS Distributor_Orders;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Wine;
DROP TABLE IF EXISTS Distributor;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Department;

-- create the department table 
CREATE TABLE Department (
    DepartmentID INT NOT NULL AUTO_INCREMENT,
    DepartmentName VARCHAR(75) NOT NULL,
    PRIMARY KEY(DepartmentID)
); 

-- create the wine table
CREATE TABLE Wine (
    WineID INT NOT NULL AUTO_INCREMENT,
    WineName VARCHAR(75) NOT NULL,
    QuantityStocked INT NOT NULL,
    PRIMARY KEY(WineID)
);

-- create the supplier table
CREATE TABLE Supplier (
    SupplierID INT NOT NULL AUTO_INCREMENT,
    SupplierName VARCHAR(75) NOT NULL,
    PRIMARY KEY(SupplierID)
);

-- create the distributor table
CREATE TABLE Distributor (
    DistributorID INT NOT NULL AUTO_INCREMENT,
    DistributorName VARCHAR(75) NOT NULL,
    PRIMARY KEY(DistributorID)
);

-- create the Employee table 
CREATE TABLE Employee (
    EmployeeID INT NOT NULL AUTO_INCREMENT,
    EmployeeFirstName VARCHAR(75) NOT NULL,
    EmployeeLastName VARCHAR(75) NOT NULL,
    DepartmentID INT NOT NULL,
    PRIMARY KEY(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
); 

-- create the Supplies table
CREATE TABLE Supplies (
    ItemID INT NOT NULL AUTO_INCREMENT,
    SupplierID INT NOT NULL,
    QuantityStocked INT NOT NULL,
    ItemName VARCHAR(75) NOT NULL,
    PRIMARY KEY(ItemID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- create the Distributor_Orders table
CREATE TABLE Distributor_Orders (
    OrderID INT NOT NULL AUTO_INCREMENT,
    DistributorID INT NOT NULL,
    OrderDate DATE NOT NULL,
    ShipmentStatus ENUM('Pending','Shipped','Delivered','Cancelled','Returned') NOT NULL,
    TrackingNumber VARCHAR(75),
    PRIMARY KEY(OrderID),
    FOREIGN KEY (DistributorID) REFERENCES Distributor(DistributorID)
);

-- create the Time_Record table
CREATE TABLE Time_Record (
    TimeRecordID INT NOT NULL AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    WorkDate DATE NOT NULL,
    HoursWorked INT NOT NULL,
    PRIMARY KEY(TimeRecordID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- create the OrderItems table
CREATE TABLE OrderItems (
    OrderItemsID INT NOT NULL AUTO_INCREMENT,
    WineID INT NOT NULL,
    OrderID INT NOT NULL,
    OrderQuantity INT NOT NULL,
    PRIMARY KEY(OrderItemsID),
    FOREIGN KEY (WineID) REFERENCES Wine(WineID),
    FOREIGN KEY (OrderID) REFERENCES Distributor_Orders(OrderID)
);

-- create the Supply_Orders table
CREATE TABLE Supply_Orders (
    SupplierOrderID INT NOT NULL AUTO_INCREMENT,
    SupplierID INT NOT NULL,
    ItemID INT NOT NULL,
    QuantityOrdered INT NOT NULL,
    ExpectedDeliveryDate DATE NOT NULL,
    ActualDeliveryDate DATE,
    PRIMARY KEY(SupplierOrderID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (ItemID) REFERENCES Supplies(ItemID)
);

-- insert Department records
INSERT INTO Department (DepartmentName) VALUES ('Finance');
INSERT INTO Department (DepartmentName) VALUES ('Marketing');
INSERT INTO Department (DepartmentName) VALUES ('Production');
INSERT INTO Department (DepartmentName) VALUES ('Distribution');
INSERT INTO Department (DepartmentName) VALUES ('Human Resources');
INSERT INTO Department (DepartmentName) VALUES ('IT');

-- insert Employee records
INSERT INTO Employee (EmployeeFirstName, EmployeeLastName, DepartmentID)
VALUES('Janet','Collins',1);

INSERT INTO Employee (EmployeeFirstName, EmployeeLastName, DepartmentID)
VALUES('Roz','Murphy',2);

INSERT INTO Employee (EmployeeFirstName, EmployeeLastName, DepartmentID)
VALUES('Bob','Ulrich',3);

INSERT INTO Employee (EmployeeFirstName, EmployeeLastName, DepartmentID)
VALUES('Henry','Doyle',4);

INSERT INTO Employee (EmployeeFirstName, EmployeeLastName, DepartmentID)
VALUES('Maria','Costanza',5);

INSERT INTO Employee (EmployeeFirstName, EmployeeLastName, DepartmentID)
VALUES('Noah','McCarthy',6);

-- insert Time_Record records 
INSERT INTO Time_Record(EmployeeID,WorkDate,HoursWorked)
VALUES(1,'2026-03-02',12);  

INSERT INTO Time_Record(EmployeeID,WorkDate,HoursWorked)
VALUES(2,'2026-03-02',10);  

INSERT INTO Time_Record(EmployeeID,WorkDate,HoursWorked)
VALUES(3,'2026-03-02',8);  

INSERT INTO Time_Record(EmployeeID,WorkDate,HoursWorked)
VALUES(4,'2026-03-02',9);  

INSERT INTO Time_Record(EmployeeID,WorkDate,HoursWorked)
VALUES(5,'2026-03-02',7);  

INSERT INTO Time_Record(EmployeeID,WorkDate,HoursWorked)
VALUES(6,'2026-03-02',11);