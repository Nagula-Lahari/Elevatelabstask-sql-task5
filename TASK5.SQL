mysql> CREATE DATABASE SQLTASK5;
Query OK, 1 row affected (0.01 sec)

mysql> USE SQLTASK5;
Database changed
mysql> -- SQL DEVELOPER INTERNSHIP - TASK 5
mysql> -- SCRIPT 1: CREATE TABLES
mysql> -- This script creates the 'Customers' and 'Orders' tables.
mysql>
mysql> -- Drop tables if they already exist to start fresh
mysql> DROP TABLE IF EXISTS Orders;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> DROP TABLE IF EXISTS Customers;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql>
mysql> -- Create the Customers table to store customer information
mysql> CREATE TABLE Customers (
    ->     CustomerID INT PRIMARY KEY,
    ->     CustomerName VARCHAR(255) NOT NULL,
    ->     ContactName VARCHAR(255),
    ->     Country VARCHAR(255)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> -- Create the Orders table to store order information
mysql> -- A foreign key is established to link orders to customers
mysql> CREATE TABLE Orders (
    ->     OrderID INT PRIMARY KEY,
    ->     CustomerID INT,
    ->     OrderDate DATE,
    ->     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> -- A simple confirmation message
mysql> SELECT 'Tables Customers and Orders created successfully.' AS Status;
+---------------------------------------------------+
| Status                                            |
+---------------------------------------------------+
| Tables Customers and Orders created successfully. |
+---------------------------------------------------+
1 row in set (0.00 sec)

mysql> -- SQL DEVELOPER INTERNSHIP - TASK 5
mysql> -- SCRIPT 2: INSERT DATA
mysql> -- This script populates the 'Customers' and 'Orders' tables with sample data.
mysql>
mysql> -- Insert 5 records into the Customers table
mysql> INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country) VALUES
    -> (1, 'Alfreds Futterkiste', 'Maria Anders', 'Germany'),
    -> (2, 'Ana Trujillo Emparedados', 'Ana Trujillo', 'Mexico'),
    -> (3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mexico'),
    -> (4, 'Around the Horn', 'Thomas Hardy', 'UK'),
    -> (5, 'Berglunds snabbköp', 'Christina Berglund', 'Sweden');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Insert 4 records into the Orders table
mysql> -- Note that some customers have orders, some do not.
mysql> -- One order (for CustomerID 6) does not have a matching customer to demonstrate outer joins.
mysql> INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
    -> (10308, 2, '1996-09-18'),
    -> (10309, 1, '1996-09-19'),
    -> (10310, 2, '1996-09-20'),
    -> (10311, 6, '1996-09-21');
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`sqltask5`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`))
mysql>
mysql> -- A simple confirmation message
mysql> SELECT 'Sample data inserted successfully.' AS Status;
+------------------------------------+
| Status                             |
+------------------------------------+
| Sample data inserted successfully. |
+------------------------------------+
1 row in set (0.00 sec)

mysql> -- SQL DEVELOPER INTERNSHIP - TASK 5
mysql> -- SCRIPT 3: JOIN QUERIES
mysql> -- This script demonstrates INNER, LEFT, RIGHT, and FULL OUTER joins.
mysql> -- Use table aliases (e.g., 'c' for Customers, 'o' for Orders) for cleaner code.
mysql>
mysql> -- -------------------------------------------------
mysql> -- Query 1: INNER JOIN
mysql> -- Returns only the records with matching CustomerIDs in both tables.
mysql> -- -------------------------------------------------
mysql> SELECT 'INNER JOIN' AS JoinType, c.CustomerName, o.OrderID, o.OrderDate
    -> FROM Customers c
    -> INNER JOIN Orders o ON c.CustomerID = o.CustomerID;
Empty set (0.00 sec)

mysql>
mysql>
mysql> -- -------------------------------------------------
mysql> -- Query 2: LEFT JOIN (or LEFT OUTER JOIN)
mysql> -- Returns all records from the left table (Customers) and matching records from the right table (Orders).
mysql> -- If there's no match, the columns from the right table will be NULL.
mysql> -- -------------------------------------------------
mysql> SELECT 'LEFT JOIN' AS JoinType, c.CustomerName, o.OrderID, o.OrderDate
    -> FROM Customers c
    -> LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;
+-----------+--------------------------+---------+-----------+
| JoinType  | CustomerName             | OrderID | OrderDate |
+-----------+--------------------------+---------+-----------+
| LEFT JOIN | Alfreds Futterkiste      |    NULL | NULL      |
| LEFT JOIN | Ana Trujillo Emparedados |    NULL | NULL      |
| LEFT JOIN | Antonio Moreno Taquería  |    NULL | NULL      |
| LEFT JOIN | Around the Horn          |    NULL | NULL      |
| LEFT JOIN | Berglunds snabbköp       |    NULL | NULL      |
+-----------+--------------------------+---------+-----------+
5 rows in set (0.00 sec)

mysql>
mysql>
mysql> -- -------------------------------------------------
mysql> -- Query 3: RIGHT JOIN (or RIGHT OUTER JOIN)
mysql> -- Returns all records from the right table (Orders) and matching records from the left table (Customers).
mysql> -- If there's no match, the columns from the left table will be NULL.
mysql> -- Note: SQLite does not support RIGHT JOIN. This query is for MySQL or other standard SQL databases.
mysql> -- -------------------------------------------------
mysql> SELECT 'RIGHT JOIN' AS JoinType, c.CustomerName, o.OrderID, o.OrderDate
    -> FROM Customers c
    -> RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;
Empty set (0.00 sec)

mysql>
mysql>
mysql> -- -------------------------------------------------
mysql> -- Query 4: FULL OUTER JOIN
mysql> -- Returns all records from both tables.
mysql> -- If there's no match for a record, the columns from the other table will be NULL.
mysql> -- Note: MySQL and SQLite do not have a dedicated FULL OUTER JOIN command.
mysql> -- We simulate it by combining a LEFT JOIN and a RIGHT JOIN with UNION.
mysql> -- -------------------------------------------------
mysql>
mysql> -- This version works in MySQL and PostgreSQL
mysql> SELECT 'FULL OUTER JOIN (Simulated)' AS JoinType, c.CustomerName, o.OrderID, o.OrderDate
    -> FROM Customers c
    -> LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    -> UNION
    -> SELECT c.CustomerName, o.OrderID, o.OrderDate
    -> FROM Customers c
    -> RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;
