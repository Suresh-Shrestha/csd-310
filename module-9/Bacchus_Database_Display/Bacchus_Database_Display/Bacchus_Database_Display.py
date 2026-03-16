""" import statements """
import mysql.connector # to connect
from mysql.connector import errorcode
 
import dotenv # to use .env file
from dotenv import dotenv_values
from setuptools import Distribution

#using our .env file
secrets = dotenv_values(r"C:\Users\Noah\Documents\GitHub\csd-310\module-9\Secret.env")
 
""" database config object """
config = {
    "user": secrets["USER"],
    "password": secrets["PASSWORD"],
    "host": secrets["HOST"],
    "database": secrets["DATABASE"],
    "raise_on_warnings": True #not in .env file
}
try:
    """ try/catch block for handling potential MySQL database errors """
    db = mysql.connector.connect(**config)
    cursor = db.cursor()
    # output the connection status 
    print("\n  Database user {} connected to MySQL on host {} with database {}".format(config["user"], config["host"], config["database"]))
 
    input("\n\n  Press any key to continue...\n")
    query1 = "SELECT * FROM Employee;" 
    query2 = "SELECT * FROM Department;"
    query3 = "SELECT * FROM Wine;"
    query4 = "SELECT * FROM Supplier;"
    query5 = "SELECT * FROM Time_Record;"
    query6 = "SELECT * FROM Distributor;"
    query7 = "SELECT * FROM Supplies;"
    query8 = "SELECT * FROM Distributor_Orders;"
    query9 = "SELECT * FROM OrderItems;"
    query10 = "SELECT * FROM Supply_Orders;"
    
    cursor.execute(query1)
    results = cursor.fetchall()
    print("-- Displaying Employee RECORDS --")
    for EmployeeID, EmployeeFirstName, EmployeeLastName, DepartmentID in results:
     print(f"Employee ID: {EmployeeID} \n Employee First Name: {EmployeeFirstName} \n Employee Last Name: {EmployeeLastName} \n Department ID: {DepartmentID}")

    cursor.execute(query2)
    results = cursor.fetchall()
    print("\n-- Displaying Department RECORDS --")
    for DepartmentID, DepartmentName in results:
     print(f"Department ID: {DepartmentID} \n Department Name: {DepartmentName}")

    cursor.execute(query3)
    results = cursor.fetchall()
    print("\n-- Displaying Wine RECORDS --")
    for WineID, WineName, QuantityStocked in results:
     print(f"Wine ID: {WineID} \n Wine Name: {WineName} \n Quantity in Stock: {QuantityStocked}")

    cursor.execute(query4)
    results = cursor.fetchall()
    print("\n-- Displaying Supplier RECORDS --")
    for SupplierID, SupplierName in results:
     print(f"Supplier ID: {SupplierID} \n Supplier Name: {SupplierName}")

    cursor.execute(query5)
    results = cursor.fetchall()
    print("\n-- Displaying Time_Record RECORDS --")
    for TimeRecordID, EmployeeID, WorkDate, HoursWorked in results:
     print(f"Time Record ID: {TimeRecordID} \n Employee ID: {EmployeeID} \n Work Date: {WorkDate} \n Hours Worked: {HoursWorked}")

    cursor.execute(query6)
    results = cursor.fetchall()
    print("\n-- Displaying Distributor RECORDS --")
    for DistributorID, DistributorName in results:
     print(f"DistributorID: {DistributorID} \n Distributor Name: {DistributorName}")

    cursor.execute(query7)
    results = cursor.fetchall()
    print("\n-- Displaying Supplies RECORDS --")
    for ItemID, ItemName, QuantityStocked, SupplierID in results:
     print(f"Item ID: {ItemID} \n Item Name: {ItemName} \n Quantity in Stock: {QuantityStocked} \n Supplier ID: {SupplierID}")


    cursor.execute(query8)
    results = cursor.fetchall()
    print("\n-- Displaying Distributor_Orders RECORDS --")
    for OrderID, DistributorID, OrderDate, ShipmentStatus, TrackingNumber in results:
     print(f"Order ID: {ItemID} \n Distributor ID: {DistributorID} \n Shipment Status: {ShipmentStatus} \n Tracking Number: {TrackingNumber}")

    cursor.execute(query9)
    results = cursor.fetchall()
    print("\n-- Displaying OrderItems RECORDS --")
    for OrderItemsID, WineID, OrderQuantity, DistributorID in results:
     print(f"Order Item ID: {OrderItemsID} \n Wine ID: {WineID} \n Amount Ordered: {OrderQuantity} \n Distributor ID: {DistributorID}")

    cursor.execute(query10)
    results = cursor.fetchall()
    print("\n-- Displaying Supply_Orders RECORDS --")
    for SupplyOrderID, SupplierID, ItemID, QuantityOrdered, ExpectedDeliveryDate, ActualDeliveryDate in results:
     print(f"Supply Order ID: {SupplyOrderID} \n Supplier ID: {SupplierID}  \n Item ID: {ItemID} \n Quantity Ordered: {QuantityOrdered} \n Expected Delivery: {ExpectedDeliveryDate}  \n Actual Delivery: {ActualDeliveryDate}")
 
 
  
 
 
 
except mysql.connector.Error as err:
    """ on error code """
 
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("  The supplied username or password are invalid")
 
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("  The specified database does not exist")
 
    else:
        print(err)
 
finally:
    """ close the connection to MySQL """
 
    db.close()

