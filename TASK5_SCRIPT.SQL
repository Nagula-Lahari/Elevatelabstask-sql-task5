-- SQL DEVELOPER INTERNSHIP - TASK 5
-- SCRIPT 1: CREATE TABLES
-- This script creates the 'Customers' and 'Orders' tables.

-- Drop tables if they already exist to start fresh
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

-- Create the Customers table to store customer information
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(255),
    Country VARCHAR(255)
);

-- Create the Orders table to store order information
-- A foreign key is established to link orders to customers
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- A simple confirmation message
SELECT 'Tables Customers and Orders created successfully.' AS Status;
-- SQL DEVELOPER INTERNSHIP - TASK 5
-- SCRIPT 2: INSERT DATA
-- This script populates the 'Customers' and 'Orders' tables with sample data.

-- Insert 5 records into the Customers table
INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country) VALUES
(1, 'Alfreds Futterkiste', 'Maria Anders', 'Germany'),
(2, 'Ana Trujillo Emparedados', 'Ana Trujillo', 'Mexico'),
(3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mexico'),
(4, 'Around the Horn', 'Thomas Hardy', 'UK'),
(5, 'Berglunds snabbköp', 'Christina Berglund', 'Sweden');

-- Insert 4 records into the Orders table
-- Note that some customers have orders, some do not.
-- One order (for CustomerID 6) does not have a matching customer to demonstrate outer joins.
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(10308, 2, '1996-09-18'),
(10309, 1, '1996-09-19'),
(10310, 2, '1996-09-20'),
(10311, 6, '1996-09-21');

-- A simple confirmation message
SELECT 'Sample data inserted successfully.' AS Status;
-- SQL DEVELOPER INTERNSHIP - TASK 5
-- SCRIPT 3: JOIN QUERIES
-- This script demonstrates INNER, LEFT, RIGHT, and FULL OUTER joins.
-- Use table aliases (e.g., 'c' for Customers, 'o' for Orders) for cleaner code.

-- -------------------------------------------------
-- Query 1: INNER JOIN
-- Returns only the records with matching CustomerIDs in both tables.
-- -------------------------------------------------
SELECT 'INNER JOIN' AS JoinType, c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;


-- -------------------------------------------------
-- Query 2: LEFT JOIN (or LEFT OUTER JOIN)
-- Returns all records from the left table (Customers) and matching records from the right table (Orders).
-- If there's no match, the columns from the right table will be NULL.
-- -------------------------------------------------
SELECT 'LEFT JOIN' AS JoinType, c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;


-- -------------------------------------------------
-- Query 3: RIGHT JOIN (or RIGHT OUTER JOIN)
-- Returns all records from the right table (Orders) and matching records from the left table (Customers).
-- If there's no match, the columns from the left table will be NULL.
-- Note: SQLite does not support RIGHT JOIN. This query is for MySQL or other standard SQL databases.
-- -------------------------------------------------
SELECT 'RIGHT JOIN' AS JoinType, c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;


-- -------------------------------------------------
-- Query 4: FULL OUTER JOIN
-- Returns all records from both tables.
-- If there's no match for a record, the columns from the other table will be NULL.
-- Note: MySQL and SQLite do not have a dedicated FULL OUTER JOIN command.
-- We simulate it by combining a LEFT JOIN and a RIGHT JOIN with UNION.
-- -------------------------------------------------

-- This version works in MySQL and PostgreSQL
SELECT 'FULL OUTER JOIN (Simulated)' AS JoinType, c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
UNION
SELECT c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- This version is more compatible and avoids duplicates that might arise from the central matching part.
-- (Use this for a more robust simulation)
-- SELECT 'FULL OUTER JOIN (Robust)' AS JoinType, c.CustomerName, o.OrderID, o.OrderDate
-- FROM Customers c
-- LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
-- UNION ALL
-- SELECT c.CustomerName, o.OrderID, o.OrderDate
-- FROM Orders o
-- LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
-- WHERE c.CustomerID IS NULL;
