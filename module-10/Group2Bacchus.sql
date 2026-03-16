/*
    Title: Group2_Bacchus.sql
    Author: Noah McCarthy, Jasmine Fontus, Suresh Shrestha
    Group: Group 2
    Date: 3-13-2026
    Description: Bacchus database initialization script and supplier delivery reports.
*/

-- drop database user if exists
DROP USER IF EXISTS 'bacchus_user'@'localhost';

-- create bacchus_user and grant them all privileges to the bacchus database
CREATE USER 'bacchus_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'wine';

-- grant all privileges to the bacchus database to user bacchus_user on localhost
GRANT ALL PRIVILEGES ON bacchus.* TO 'bacchus_user'@'localhost';
FLUSH PRIVILEGES;

DROP DATABASE IF EXISTS bacchus;
CREATE DATABASE bacchus;
USE bacchus;

-- drop tables if they are present
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Distributor_Orders;
DROP TABLE IF EXISTS Supply_Orders;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS DistributorWine;
DROP TABLE IF EXISTS EmployeeDepartment;
DROP TABLE IF EXISTS Time_Record;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Wine;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Distributor;

-- create the department table
CREATE TABLE Department (
    DepartmentID INT NOT NULL AUTO_INCREMENT,
    DepartmentName VARCHAR(75) NOT NULL,
    PRIMARY KEY (DepartmentID)
);

-- create the wine table
CREATE TABLE Wine (
    WineID INT NOT NULL AUTO_INCREMENT,
    WineName VARCHAR(75) NOT NULL,
    QuantityStocked INT NOT NULL,
    PRIMARY KEY (WineID)
);

-- create the supplier table
CREATE TABLE Supplier (
    SupplierID INT NOT NULL AUTO_INCREMENT,
    SupplierName VARCHAR(75) NOT NULL,
    PRIMARY KEY (SupplierID)
);

-- create the distributor table
CREATE TABLE Distributor (
    DistributorID INT NOT NULL AUTO_INCREMENT,
    DistributorName VARCHAR(75) NOT NULL,
    PRIMARY KEY (DistributorID)
);

-- create the distributorWine table
CREATE TABLE DistributorWine (
    DistributorID INT NOT NULL,
    WineID INT NOT NULL,
    PRIMARY KEY (DistributorID, WineID),
    FOREIGN KEY (DistributorID) REFERENCES Distributor(DistributorID),
    FOREIGN KEY (WineID) REFERENCES Wine(WineID)
);

-- create the Employee table
CREATE TABLE Employee (
    EmployeeID INT NOT NULL AUTO_INCREMENT,
    EmployeeFirstName VARCHAR(75) NOT NULL,
    EmployeeLastName VARCHAR(75) NOT NULL,
    PRIMARY KEY (EmployeeID)
);

-- create the Employee Department table
CREATE TABLE EmployeeDepartment (
    EmployeeID INT NOT NULL,
    DepartmentID INT NOT NULL,
    PRIMARY KEY (EmployeeID, DepartmentID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- create the Supplies table
CREATE TABLE Supplies (
    ItemID INT NOT NULL AUTO_INCREMENT,
    SupplierID INT NOT NULL,
    QuantityStocked INT NOT NULL,
    ItemName VARCHAR(75) NOT NULL,
    PRIMARY KEY (ItemID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- create the Distributor_Orders table
CREATE TABLE Distributor_Orders (
    OrderID INT NOT NULL AUTO_INCREMENT,
    DistributorID INT NOT NULL,
    OrderDate DATE NOT NULL,
    ShipmentStatus ENUM('Pending','Shipped','Delivered','Cancelled','Returned') NOT NULL,
    TrackingNumber VARCHAR(75),
    PRIMARY KEY (OrderID),
    FOREIGN KEY (DistributorID) REFERENCES Distributor(DistributorID)
);

-- create the Time_Record table
CREATE TABLE Time_Record (
    TimeRecordID INT NOT NULL AUTO_INCREMENT,
    EmployeeID INT NOT NULL,
    WorkDate DATE NOT NULL,
    HoursWorked INT NOT NULL,
    PRIMARY KEY (TimeRecordID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- create the OrderItems table
CREATE TABLE OrderItems (
    OrderItemsID INT NOT NULL AUTO_INCREMENT,
    WineID INT NOT NULL,
    OrderID INT NOT NULL,
    OrderQuantity INT NOT NULL,
    PRIMARY KEY (OrderItemsID),
    FOREIGN KEY (WineID) REFERENCES Wine(WineID),
    FOREIGN KEY (OrderID) REFERENCES Distributor_Orders(OrderID)
);

-- create the Supply_Orders table
CREATE TABLE Supply_Orders (
    SupplierOrderID INT NOT NULL AUTO_INCREMENT,
    SupplierID INT NOT NULL,
    ItemID INT NOT NULL,
    OrderDate DATE NOT NULL,
    QuantityOrdered INT NOT NULL,
    ExpectedDeliveryDate DATE NOT NULL,
    ActualDeliveryDate DATE,
    PRIMARY KEY (SupplierOrderID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (ItemID) REFERENCES Supplies(ItemID)
);

-- insert Department records
INSERT INTO Department (DepartmentName) VALUES ('Finances');
INSERT INTO Department (DepartmentName) VALUES ('Payroll');
INSERT INTO Department (DepartmentName) VALUES ('Marketing');
INSERT INTO Department (DepartmentName) VALUES ('Production Line');
INSERT INTO Department (DepartmentName) VALUES ('Distribution');
INSERT INTO Department (DepartmentName) VALUES ('Supply and Inventory');

-- insert Employee records
INSERT INTO Employee (EmployeeFirstName, EmployeeLastName) VALUES ('Janet','Collins');
INSERT INTO Employee (EmployeeFirstName, EmployeeLastName) VALUES ('Roz','Murphy');
INSERT INTO Employee (EmployeeFirstName, EmployeeLastName) VALUES ('Bob','Ulrich');
INSERT INTO Employee (EmployeeFirstName, EmployeeLastName) VALUES ('Henry','Doyle');
INSERT INTO Employee (EmployeeFirstName, EmployeeLastName) VALUES ('Maria','Constanza');
INSERT INTO Employee (EmployeeFirstName, EmployeeLastName) VALUES ('Stan','Bub');
INSERT INTO Employee (EmployeeFirstName, EmployeeLastName) VALUES ('Davis','Bub');

-- insert EmployeeDepartment records
INSERT INTO EmployeeDepartment (EmployeeID, DepartmentID) VALUES (1,1);
INSERT INTO EmployeeDepartment (EmployeeID, DepartmentID) VALUES (1,2);
INSERT INTO EmployeeDepartment (EmployeeID, DepartmentID) VALUES (2,3);
INSERT INTO EmployeeDepartment (EmployeeID, DepartmentID) VALUES (3,3);
INSERT INTO EmployeeDepartment (EmployeeID, DepartmentID) VALUES (4,4);
INSERT INTO EmployeeDepartment (EmployeeID, DepartmentID) VALUES (5,5);
INSERT INTO EmployeeDepartment (EmployeeID, DepartmentID) VALUES (6,6);
INSERT INTO EmployeeDepartment (EmployeeID, DepartmentID) VALUES (7,6);

-- insert Time_Record records
INSERT INTO Time_Record (EmployeeID, WorkDate, HoursWorked) VALUES (1,'2026-02-20',12);
INSERT INTO Time_Record (EmployeeID, WorkDate, HoursWorked) VALUES (2,'2026-02-20',10);
INSERT INTO Time_Record (EmployeeID, WorkDate, HoursWorked) VALUES (3,'2026-02-20',18);
INSERT INTO Time_Record (EmployeeID, WorkDate, HoursWorked) VALUES (4,'2026-02-20',16);
INSERT INTO Time_Record (EmployeeID, WorkDate, HoursWorked) VALUES (5,'2026-02-20',8);
INSERT INTO Time_Record (EmployeeID, WorkDate, HoursWorked) VALUES (6,'2026-02-20',7);
INSERT INTO Time_Record (EmployeeID, WorkDate, HoursWorked) VALUES (7,'2026-02-20',5);
INSERT INTO Time_Record (EmployeeID, WorkDate, HoursWorked) VALUES (1,'2026-02-21',6);

-- insert Distributor records
INSERT INTO Distributor (DistributorName) VALUES ('Walmart');
INSERT INTO Distributor (DistributorName) VALUES ('Target');
INSERT INTO Distributor (DistributorName) VALUES ('Wegmans');
INSERT INTO Distributor (DistributorName) VALUES ('Kroger');
INSERT INTO Distributor (DistributorName) VALUES ('Buc-ee''s');
INSERT INTO Distributor (DistributorName) VALUES ('Sheetz');

-- insert Wine records
INSERT INTO Wine (WineName, QuantityStocked) VALUES ('Chardonnay', 12);
INSERT INTO Wine (WineName, QuantityStocked) VALUES ('Merlot', 45);
INSERT INTO Wine (WineName, QuantityStocked) VALUES ('Cabernet', 792);
INSERT INTO Wine (WineName, QuantityStocked) VALUES ('Chablis', 0);

-- insert DistributorWine records
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (1,1);
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (1,4);
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (2,1);
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (2,2);
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (3,2);
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (3,4);
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (4,3);
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (4,1);
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (5,3);
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (5,2);
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (6,3);
INSERT INTO DistributorWine (DistributorID, WineID) VALUES (6,4);

-- insert Supplier records
INSERT INTO Supplier (SupplierName) VALUES ('Bottles and Corks INC');
INSERT INTO Supplier (SupplierName) VALUES ('Labels and Boxes INC');
INSERT INTO Supplier (SupplierName) VALUES ('Vats and Tubing INC');

-- insert Supplies records
INSERT INTO Supplies (ItemName, QuantityStocked, SupplierID) VALUES ('Bottles', 500, 1);
INSERT INTO Supplies (ItemName, QuantityStocked, SupplierID) VALUES ('Corks', 1000, 1);
INSERT INTO Supplies (ItemName, QuantityStocked, SupplierID) VALUES ('Labels', 200, 2);
INSERT INTO Supplies (ItemName, QuantityStocked, SupplierID) VALUES ('Boxes', 230, 2);
INSERT INTO Supplies (ItemName, QuantityStocked, SupplierID) VALUES ('Vats', 20, 3);
INSERT INTO Supplies (ItemName, QuantityStocked, SupplierID) VALUES ('Tubes', 100, 3);

-- insert Supply_Orders records
INSERT INTO Supply_Orders (SupplierID, ItemID, OrderDate, QuantityOrdered, ExpectedDeliveryDate, ActualDeliveryDate)
VALUES (1, 1, '2026-03-01', 15, '2026-03-14', NULL);

INSERT INTO Supply_Orders (SupplierID, ItemID, OrderDate, QuantityOrdered, ExpectedDeliveryDate, ActualDeliveryDate)
VALUES (1, 2, '2026-03-01', 2, '2026-03-03', NULL);

INSERT INTO Supply_Orders (SupplierID, ItemID, OrderDate, QuantityOrdered, ExpectedDeliveryDate, ActualDeliveryDate)
VALUES (2, 3, '2026-03-02', 50, '2026-03-07', NULL);

INSERT INTO Supply_Orders (SupplierID, ItemID, OrderDate, QuantityOrdered, ExpectedDeliveryDate, ActualDeliveryDate)
VALUES (2, 4, '2026-02-20', 100, '2026-03-01', '2026-02-27');

INSERT INTO Supply_Orders (SupplierID, ItemID, OrderDate, QuantityOrdered, ExpectedDeliveryDate, ActualDeliveryDate)
VALUES (3, 5, '2026-03-04', 19, '2026-03-10', NULL);

INSERT INTO Supply_Orders (SupplierID, ItemID, OrderDate, QuantityOrdered, ExpectedDeliveryDate, ActualDeliveryDate)
VALUES (3, 6, '2026-03-05', 26, '2026-03-10', NULL);

-- insert Distributor_Orders records
INSERT INTO Distributor_Orders (DistributorID, OrderDate, ShipmentStatus, TrackingNumber)
VALUES (1,'2026-02-27','Pending', NULL);

INSERT INTO Distributor_Orders (DistributorID, OrderDate, ShipmentStatus, TrackingNumber)
VALUES (2,'2026-02-24','Shipped','ifdg78df6gdfg78dfg4554667');

INSERT INTO Distributor_Orders (DistributorID, OrderDate, ShipmentStatus, TrackingNumber)
VALUES (3,'2026-02-03','Delivered','sdf76786dsfsd7f6786h7645');

INSERT INTO Distributor_Orders (DistributorID, OrderDate, ShipmentStatus, TrackingNumber)
VALUES (4,'2026-02-13','Cancelled',NULL);

INSERT INTO Distributor_Orders (DistributorID, OrderDate, ShipmentStatus, TrackingNumber)
VALUES (5,'2026-02-11','Returned','ofguds9s78f6gd8f76g78546546');

INSERT INTO Distributor_Orders (DistributorID, OrderDate, ShipmentStatus, TrackingNumber)
VALUES (6,'2026-02-24','Shipped','dfg98fdg786df87g6d8f7g6df87g656');

-- insert OrderItems records
INSERT INTO OrderItems (WineID, OrderID, OrderQuantity) VALUES (1,1,10);
INSERT INTO OrderItems (WineID, OrderID, OrderQuantity) VALUES (1,2,20);
INSERT INTO OrderItems (WineID, OrderID, OrderQuantity) VALUES (2,3,20);
INSERT INTO OrderItems (WineID, OrderID, OrderQuantity) VALUES (3,4,50);
INSERT INTO OrderItems (WineID, OrderID, OrderQuantity) VALUES (3,5,2);
INSERT INTO OrderItems (WineID, OrderID, OrderQuantity) VALUES (3,6,30);

-- SUPPLIER DELIVERY REPORTS

-- example actual delivery dates
UPDATE Supply_Orders SET ActualDeliveryDate = '2026-03-16' WHERE SupplierOrderID = 1;
UPDATE Supply_Orders SET ActualDeliveryDate = '2026-03-03' WHERE SupplierOrderID = 2;
UPDATE Supply_Orders SET ActualDeliveryDate = '2026-03-20' WHERE SupplierOrderID = 3;
UPDATE Supply_Orders SET ActualDeliveryDate = '2026-03-10' WHERE SupplierOrderID = 5;
UPDATE Supply_Orders SET ActualDeliveryDate = '2026-03-12' WHERE SupplierOrderID = 6;

-- Report 1: Supplier delivery time and delivery status
SELECT
    Supplier.SupplierName,
    Supply_Orders.SupplierOrderID,
    Supplies.ItemName,
    Supply_Orders.OrderDate,
    Supply_Orders.ExpectedDeliveryDate,
    Supply_Orders.ActualDeliveryDate,
    DATEDIFF(Supply_Orders.ActualDeliveryDate, Supply_Orders.OrderDate) AS DeliveryTimeDays,
    DATEDIFF(Supply_Orders.ActualDeliveryDate, Supply_Orders.ExpectedDeliveryDate) AS DeliveryDifferenceDays,
    CASE
        WHEN Supply_Orders.ActualDeliveryDate IS NULL THEN NULL
        WHEN Supply_Orders.ActualDeliveryDate > Supply_Orders.ExpectedDeliveryDate
            THEN DATEDIFF(Supply_Orders.ActualDeliveryDate, Supply_Orders.ExpectedDeliveryDate)
        ELSE 0
    END AS DaysLate,
    CASE
        WHEN Supply_Orders.ActualDeliveryDate IS NULL THEN 'Not Delivered Yet'
        WHEN Supply_Orders.ActualDeliveryDate > Supply_Orders.ExpectedDeliveryDate THEN 'Late'
        WHEN Supply_Orders.ActualDeliveryDate = Supply_Orders.ExpectedDeliveryDate THEN 'On Time'
        ELSE 'Early'
    END AS DeliveryStatus
FROM Supply_Orders
JOIN Supplier ON Supply_Orders.SupplierID = Supplier.SupplierID
JOIN Supplies ON Supply_Orders.ItemID = Supplies.ItemID
ORDER BY Supplier.SupplierName, Supply_Orders.OrderDate;

-- Report 2: Large delivery gap (more than 7 days late)
SELECT
    Supplier.SupplierName,
    Supply_Orders.SupplierOrderID,
    Supplies.ItemName,
    Supply_Orders.OrderDate,
    Supply_Orders.ExpectedDeliveryDate,
    Supply_Orders.ActualDeliveryDate,
    DATEDIFF(Supply_Orders.ActualDeliveryDate, Supply_Orders.OrderDate) AS DeliveryTimeDays,
    DATEDIFF(Supply_Orders.ActualDeliveryDate, Supply_Orders.ExpectedDeliveryDate) AS DaysLate
FROM Supply_Orders
JOIN Supplier ON Supply_Orders.SupplierID = Supplier.SupplierID
JOIN Supplies ON Supply_Orders.ItemID = Supplies.ItemID
WHERE Supply_Orders.ActualDeliveryDate IS NOT NULL
  AND DATEDIFF(Supply_Orders.ActualDeliveryDate, Supply_Orders.ExpectedDeliveryDate) > 7
ORDER BY DaysLate DESC;

-- Report 3: Month-by-month supplier problem report
SELECT
    DATE_FORMAT(Supply_Orders.ExpectedDeliveryDate, '%Y-%m') AS Month,
    COUNT(*) AS TotalOrders,
    SUM(
        CASE
            WHEN Supply_Orders.ActualDeliveryDate > Supply_Orders.ExpectedDeliveryDate
            THEN 1
            ELSE 0
        END
    ) AS LateOrders
FROM Supply_Orders
GROUP BY DATE_FORMAT(Supply_Orders.ExpectedDeliveryDate, '%Y-%m')
ORDER BY Month;