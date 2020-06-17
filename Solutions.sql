# 1 -20
select * from shippers; 
select ProductID, ProductName from products where ProductName like '%queso%';
select OrderID, CustomerID, ShipCountry from orders where ShipCountry in ('France', 'Belgium');
select OrderID, CustomerID, ShipCountry from orders where ShipCountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela');
select FirstName, LastName, Title, BirthDate from employees order by BirthDate;
select FirstName, LastName, Title, date(BirthDate) as DateOnlyBirthdate from employees order by BirthDate;
select FirstName, LastName, concat(FirstName, " ", LastName) as FullName from employees;
#13
select OrderID, ProductID, UnitPrice, Quantity, (UnitPrice * Quantity) as TotalPrice from orderdetails order by OrderID, ProductID;

#14
select count(*) as TotalCustomers from customers;

#15
SELECT 
    MIN(OrderDate)
FROM
    orders;

#16
select distinct country from customers order by Country;


#17
SELECT 
    ContactTitle, COUNT(ContactTitle) AS TotalContactTitle
FROM
    customers
GROUP BY ContactTitle
ORDER BY TotalContactTitle DESC;

#18
SELECT 
    a.ProductID, a.ProductName, b.CompanyName
FROM
    products a
        INNER JOIN
    suppliers b ON a.SupplierID = b.SupplierID
ORDER BY ProductID;

#19
SELECT 
    OrderID, date(OrderDate) as OrderDate, ShipName
FROM
    orders inner join shippers
on orders.ShipVia = shippers.ShipperID
where OrderID < 10270
ORDER BY OrderID; 

# 20 - 31

#20
SELECT 
    b.CategoryName, COUNT(b.CategoryName) AS TotalProducts
FROM
    products a
        INNER JOIN
    categories b ON a.CategoryID = b.CategoryID
GROUP BY b.CategoryName
ORDER BY TotalProducts DESC;

#21
SELECT 
    country, city, COUNT(city) AS TotalCustomers
FROM
    customers
GROUP BY country , city
ORDER BY count(city) DESC;

#22
SELECT 
    ProductID, ProductName, UnitsInStock, ReorderLevel
FROM
    products
WHERE
    UnitsInStock <= ReorderLevel
ORDER BY ProductID;

#23
SELECT 
    ProductID,
    ProductName,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel,
    Discontinued
FROM
    products
WHERE
    (((UnitsInStock + UnitsOnOrder) <= ReorderLevel)
        AND (Discontinued = 0))
ORDER BY ProductID;

#24
SELECT 
    CustomerID, CompanyName, Region
FROM
    customers
ORDER BY CASE
    WHEN Region IS NULL THEN 1
    ELSE 0
END , Region , CustomerID;

#25
SELECT 
    ShipCountry, AVG(Freight) AS AverageFreight
FROM
    orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;

#26
SELECT 
    ShipCountry, AVG(Freight) AS AverageFreight
FROM
    orders
where 
        #year(OrderDate) = 2015    --this is slower, existing indexes won't be used  
        OrderDate > '2015-01-01' 
        and OrderDate < '2016-01-01'
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;

#27
Select
#ShipCountry,freight, OrderDate
*
From Orders
Where
OrderDate not between '2015-01-01' and '2015-12-31'
and year(OrderDate) = 2015
and ShipCountry = 'France';


SELECT 
    *
FROM
    orders
WHERE
    OrderID = 10806
        AND OrderDate BETWEEN '2015-01-01' AND '2015-12-31';

#28
SELECT 
    ShipCountry, AVG(Freight) AS AverageFreight
FROM
    orders
WHERE
    OrderDate >= (SELECT 
            DATE_ADD(MAX(OrderDate),
                    INTERVAL - 12 MONTH)
        FROM
            orders)
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;

#29
SELECT 
    Employees.EmployeeID,
    Employees.LastName,
    Orders.OrderID,
    Products.ProductName,
    OrderDetails.Quantity
FROM
    Employees
        JOIN
    Orders ON Orders.EmployeeID = Employees.EmployeeID
        JOIN
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
        JOIN
    Products ON Products.ProductID = OrderDetails.ProductID
ORDER BY Orders.OrderID , Products.ProductID;

#30
# https://www.codeproject.com/Articles/33052/Visual-Representation-of-SQL-Joins
SELECT 
    a.CustomerID AS Customers_Customers_ID,
    b.CustomerID AS Orders_CustomerID
FROM
    customers a
        LEFT JOIN
    orders b ON a.CustomerID = b.CustomerID
WHERE
    b.CustomerID IS NULL;
    
#Option 2
SELECT 
    CustomerID
FROM
    Customers
WHERE
    CustomerID NOT IN (SELECT 
            CustomerID
        FROM
            Orders);
            
#Option3
Select CustomerID
From Customers
Where Not Exists
(
Select CustomerID
from Orders
where
Orders.CustomerID = Customers.CustomerID
);

#31
SELECT 
    a.CustomerID,
    b.CustomerID,
    b.EmployeeID
FROM
    customers a
        LEFT JOIN
    orders b ON a.CustomerID = b.CustomerID 
    and b.EmployeeID=4
WHERE
    b.CustomerID IS NULL;
    
#option 2
SELECT 
    CustomerID
FROM
    Customers
WHERE
    CustomerID NOT IN (SELECT 
            CustomerID
        FROM
            Orders
        WHERE
            EmployeeID = 4);

#Option 3
SELECT 
    CustomerID
FROM
    Customers
WHERE
    NOT EXISTS( SELECT 
            CustomerID
        FROM
            Orders
        WHERE
            Orders.CustomerID = Customers.CustomerID
                AND EmployeeID = 4);
    
