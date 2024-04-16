
--1 : calculates the percentage of sales for each category

SELECT pc.Name AS NumeCategorie,
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Production.Product) AS ProcentVanzari
FROM Production.Product p
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY pc.Name;

--2: find the total number of orders for each product category

SELECT 
    ProductCategoryID,
    Name AS CategoryName,
    (SELECT COUNT(*) FROM Sales.SalesOrderDetail sod WHERE sod.ProductID IN (SELECT ProductID FROM Production.Product WHERE ProductCategoryID = pc.ProductCategoryID)) AS TotalOrders
FROM 
    Production.ProductCategory pc;

--3: identify products with a unit price higher than the average unit price

SELECT 
    ProductID,
    Name,
    ListPrice
FROM 
    Production.Product
WHERE 
    ListPrice > (SELECT AVG(ListPrice) FROM Production.Product);

--4 :  retrieve products that have never been ordered

SELECT 
    ProductID,
    Name
FROM 
    Production.Product
WHERE 
    ProductID NOT IN (SELECT ProductID FROM Sales.SalesOrderDetail);

--5: Find customers who have placed orders

SELECT *
FROM Sales.Customer
WHERE CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Sales.SalesOrderHeader
    WHERE TotalDue > 1000
);


--6: find customers who have placed orders more than once

SELECT *
FROM Sales.Customer
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
    HAVING COUNT(*) > 1
);


--7: find the average order 

SELECT AVG(TotalDue) AS AvgOrderAmount
FROM (
    SELECT TotalDue
    FROM Sales.SalesOrderHeader
) AS Subquery;

--8: find the products with the highest list price:

SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE ListPrice = (
    SELECT MAX(ListPrice)
    FROM Production.Product
);
