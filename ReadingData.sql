
--1
SELECT FirstName,LastName, BusinessEntityID as Employee_id
FROM Person.Person
Order By LastName ASC;

--2
SELECT p.LastName,p.FirstName, ph.BusinessEntityID,ph.PhoneNumber
FROM Person.PersonPhone ph
Join Person.Person p On p.BusinessEntityID=ph.BusinessEntityID
Where p.LastName LIKE 'L%'
Order By p.LastName,p.FirstName

--3
WITH RankedSales AS (
    SELECT 
        ROW_NUMBER() OVER (PARTITION BY a.PostalCode ORDER BY s.SalesYTD DESC) AS RowNum,
        p.LastName,
        s.SalesYTD,
        a.PostalCode
    FROM 
        Sales.SalesPerson s
    JOIN 
        Person.Person p ON s.BusinessEntityID = p.BusinessEntityID
    JOIN 
        Person.Address a ON s.TerritoryID = a.AddressID
    WHERE 
        s.TerritoryID IS NOT NULL
        AND s.SalesYTD <> 0
)
   SELECT 
     RowNum,
     LastName,
     SalesYTD,
     PostalCode
   FROM 
    RankedSales
   ORDER BY 
    PostalCode ASC, 
    SalesYTD DESC;

--4
SELECT SalesOrderId, SUM(LineTotal) as TotalSum 
From Sales.SalesOrderDetail
Group by SalesOrderID
Having SUM(LineTotal) >10000
