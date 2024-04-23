--1 delete orders and update price 

BEGIN TRANSACTION

DELETE FROM Sales.SalesOrderHeader
WHERE CustomerID = 30067

UPDATE Production.Product
SET ListPrice += 178.99

COMMIT TRANSACTION


--2 Product Price adjustment

BEGIN TRANSACTION;

UPDATE Production.Product
SET ListPrice = 102.99
WHERE ProductID = 1;

COMMIT TRANSACTION;

--3 Update product Prices

BEGIN TRANSACTION;

UPDATE Sales.SalesOrderDetail
SET UnitPrice = UnitPrice * 1.1
WHERE ProductID IN (
    SELECT ProductID
    FROM Production.Product
    WHERE Color = 'Red'
);
COMMIT TRANSACTION;

--4 Reduce product prices for old products

BEGIN TRANSACTION;

UPDATE Production.Product
SET ListPrice = ListPrice * 0.5
WHERE ProductID IN (
    SELECT ProductID
    FROM Production.Product
    WHERE SellStartDate < '2011-10-01' 
);
COMMIT TRANSACTION;

--5 Employee by updating job title

BEGIN TRANSACTION;

UPDATE HumanResources.Employee
SET JobTitle = 'Senior Sales Representative'
WHERE BusinessEntityID = 280; 

COMMIT TRANSACTION;

--6 Remove created order and order details

BEGIN TRANSACTION;

DECLARE @DeleteOrderID INT;
SET @DeleteOrderID = 75136;

DELETE FROM Sales.SalesOrderDetail 
WHERE SalesOrderID = @DeleteOrderID;
     
DELETE FROM Sales.SalesOrderHeader
WHERE SalesOrderID = @DeleteOrderID;

COMMIT TRANSACTION;

--7  Delete a Customer

BEGIN TRANSACTION 
DECLARE @BusinessEntityID INT;
SET @BusinessEntityID = 20781;

DELETE FROM Person.PersonPhone
WHERE BusinessEntityID = @BusinessEntityID;

DELETE FROM Person.EmailAddress
WHERE BusinessEntityID = @BusinessEntityID;

DELETE FROM Person.BusinessEntity
WHERE BusinessEntityID = @BusinessEntityID;

COMMIT TRANSACTION;
  

--8 Create a new customer

BEGIN TRANSACTION;
DECLARE @NewBusinessEntityID INT;
    
INSERT INTO Person.BusinessEntity (ModifiedDate)
 VALUES (getdate());
 SET @NewBusinessEntityID = SCOPE_IDENTITY();

INSERT INTO Person.Person (BusinessEntityID, PersonType, NameStyle, FirstName, LastName, EmailPromotion)
  VALUES (@NewBusinessEntityID, 'IN', 0, 'Monica', 'Adina', 0);

COMMIT TRANSACTION;