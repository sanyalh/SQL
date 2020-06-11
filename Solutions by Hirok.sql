# 1 -20
select * from shippers;
select ProductID, ProductName from products where ProductName like '%queso%';
select OrderID, CustomerID, ShipCountry from orders where ShipCountry in ('France', 'Belgium');
select OrderID, CustomerID, ShipCountry from orders where ShipCountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela');
select FirstName, LastName, Title, BirthDate from employees order by BirthDate;
select FirstName, LastName, Title, date(BirthDate) as DateOnlyBirthdate from employees order by BirthDate;
select FirstName, LastName, concat(FirstName, " ", LastName) as FullName from employees;
select OrderID, ProductID, UnitPrice, Quantity, (UnitPrice * Quantity) as TotalPrice from orderdetails order by OrderID, ProductID;
select min(OrderDate) from orders;
select distinct country from customers order by Country;
select ContactTitle, count(ContactTitle) as TotalContactTitle from customers group by ContactTitle order by TotalContactTitle desc;
select a.ProductID, a.ProductName, b.CompanyName from products a inner join suppliers b on a.SupplierID = b.SupplierID order by ProductID;
select OrderID, OrderDate, ShipName from orders where OrderID < 10270 order by OrderID; 

# 1 -20

