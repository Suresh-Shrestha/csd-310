/*
    Title: SupplierDeliveryReport.sql
    Author: Noah McCarthy, Jasmine Fontus, Suresh Shrestha
    Group: Group 2
    Date: 3-5-2026
    Description: Report to determine if suppliers are delivering on time,
                 identify large delivery gaps, and show month-by-month issues.
*/



USE bacchus;

-- Adding example ActualDeliveryDate values (so the report shows Late/On Time/Early)
UPDATE Supply_Orders SET ActualDeliveryDate = '2026-03-16' WHERE SupplierOrderID = 1;
UPDATE Supply_Orders SET ActualDeliveryDate = '2026-03-03' WHERE SupplierOrderID = 2;
UPDATE Supply_Orders SET ActualDeliveryDate = '2026-03-20' WHERE SupplierOrderID = 3;
UPDATE Supply_Orders SET ActualDeliveryDate = '2026-03-10' WHERE SupplierOrderID = 5;
UPDATE Supply_Orders SET ActualDeliveryDate = '2026-03-12' WHERE SupplierOrderID = 6;

-- REPORT 1A: Are suppliers delivering on time?
SELECT
    Supplier.SupplierName,
    Supply_Orders.SupplierOrderID,
    Supplies.ItemName,
    Supply_Orders.ExpectedDeliveryDate,
    Supply_Orders.ActualDeliveryDate,
    DATEDIFF(Supply_Orders.ActualDeliveryDate, Supply_Orders.ExpectedDeliveryDate) AS DaysLate,
    CASE
        WHEN Supply_Orders.ActualDeliveryDate IS NULL THEN 'Not Delivered Yet'
        WHEN Supply_Orders.ActualDeliveryDate > Supply_Orders.ExpectedDeliveryDate THEN 'Late'
        WHEN Supply_Orders.ActualDeliveryDate = Supply_Orders.ExpectedDeliveryDate THEN 'On Time'
        ELSE 'Early'
    END AS DeliveryStatus
FROM Supply_Orders
JOIN Supplier ON Supply_Orders.SupplierID = Supplier.SupplierID
JOIN Supplies ON Supply_Orders.ItemID = Supplies.ItemID
ORDER BY Supplier.SupplierName, Supply_Orders.ExpectedDeliveryDate;

-- REPORT 1B: Large delivery gap (more than 7 days late)
SELECT
    Supplier.SupplierName,
    Supply_Orders.SupplierOrderID,
    Supply_Orders.ExpectedDeliveryDate,
    Supply_Orders.ActualDeliveryDate,
    DATEDIFF(Supply_Orders.ActualDeliveryDate, Supply_Orders.ExpectedDeliveryDate) AS DaysLate
FROM Supply_Orders
JOIN Supplier ON Supply_Orders.SupplierID = Supplier.SupplierID
WHERE Supply_Orders.ActualDeliveryDate IS NOT NULL
  AND DATEDIFF(Supply_Orders.ActualDeliveryDate, Supply_Orders.ExpectedDeliveryDate) > 7
ORDER BY DaysLate DESC;

-- REPORT 1C: Month-by-month delivery problem report
SELECT
    DATE_FORMAT(Supply_Orders.ExpectedDeliveryDate, '%Y-%m') AS Month,
    COUNT(*) AS TotalOrders,
    SUM(CASE
        WHEN Supply_Orders.ActualDeliveryDate IS NOT NULL
         AND Supply_Orders.ActualDeliveryDate > Supply_Orders.ExpectedDeliveryDate
        THEN 1
        ELSE 0
    END) AS LateOrders,
    SUM(CASE
        WHEN Supply_Orders.ActualDeliveryDate IS NULL THEN 1
        ELSE 0
    END) AS NotDeliveredYet
FROM Supply_Orders
GROUP BY DATE_FORMAT(Supply_Orders.ExpectedDeliveryDate, '%Y-%m')
ORDER BY Month;