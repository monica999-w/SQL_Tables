
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
SELECT 
    ROW_NUMBER() OVER(PARTITION BY a.PostalCode ORDER BY sp.SalesYTD DESC) AS RowNum,
    p.LastName,
    sp.SalesYTD,
    a.PostalCode
FROM 
    Sales.SalesPerson sp
JOIN 
    Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID
JOIN 
    Person.Address a ON sp.BusinessEntityID = a.AddressID
WHERE 
    sp.TerritoryID IS NOT NULL 
    AND sp.SalesYTD <> 0
ORDER BY 
    a.PostalCode ASC,
    sp.SalesYTD DESC;

--4
SELECT SalesOrderId, SUM(LineTotal) as TotalSum 
From Sales.SalesOrderDetail
Group by SalesOrderID
Having SUM(LineTotal) >10000
