--1: Total purchases per customer

SELECT TOP 5 c.CustomerID AS NumeClient,
       SUM(soh.TotalDue) AS TotalAchizitii
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalAchizitii DESC;

--2 : Average quantity per city

SELECT a.City AS StatProvinciaClient,
       AVG(sod.OrderQty) AS CantitateMedieComanda
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
GROUP BY a.City;

--3 Total revenue per region

SELECT st.Name AS TerritoryRegion,
       SUM(soh.TotalDue) AS TotalRevenue
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY TotalRevenue DESC;

--4 Customers monthly orders

SELECT c.CustomerID AS NumeClient
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE soh.OrderDate >= 2021/11/25
GROUP BY c.CustomerID 
HAVING COUNT(DISTINCT DATEPART(month, soh.OrderDate)) = 12;


--5 Max and min orders

SELECT MAX( sh.TotalDue) as MaxComanda,
      Min(sh.TotalDue) as MinComanda
From Sales.SalesOrderHeader sh
WHERE sh.OrderDate >= 2014-04-06;


--6 Average sales per rep

SELECT sp.BusinessEntityID,
       AVG(soh.TotalDue) AS AvgSalesAmountPerOrder
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
GROUP BY sp.BusinessEntityID;


--7 Total freight per territory

SELECT
    SUM(Freight) as TotalFreight,
   TerritoryID
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID
HAVING SUM(Freight) > 200000

--8 Total sales per category
 
SELECT pc.Name AS NumeCategorieProdus,
       SUM(sod.LineTotal) AS TotalVanzari
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY pc.Name;


