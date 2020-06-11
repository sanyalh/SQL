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

# 20 - 31
select b.CategoryName, count(b.CategoryName) as TotalProducts from products a inner join categories b 
on a.CategoryID = b.CategoryID
group by b.CategoryName order by TotalProducts desc;
select country,city, count(city) as TotalCustomers from customers group by country, city order by TotalCustomers desc;
select ProductID, ProductName, UnitsInStock, ReorderLevel from products where UnitsInStock <= ReorderLevel order by ProductID;
select ProductID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued from products where (((UnitsInStock + UnitsOnOrder) <= ReorderLevel) 
and (Discontinued = 0)) order by ProductID;
select CustomerID, CompanyName, Region from customers order by case when Region is null then 1 else 0 end, Region, CustomerID;
select ShipCountry, avg(Freight) as AverageFreight from orders group by ShipCountry order by AverageFreight desc limit 3;

