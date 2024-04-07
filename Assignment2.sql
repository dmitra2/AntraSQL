Use AdventureWorks2019;

Select * from Production.Product;

/*
ASSIGNMENT 2
-----------------------------------
*/

/*
1.      How many products can you find in the Production.Product table?
*/

Select count(ProductID) as "Total Products"
from Production.Product;

/*
2.      Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. 
The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
*/

Select count(ProductID) as "Total Products With Product Subcategory"
from Production.Product
where ProductSubcategoryID is not null;

/*
3.      How many Products reside in each SubCategory? Write a query to display the results with the following titles.

ProductSubcategoryID CountedProducts

-------------------- ---------------
*/

Select ProductSubcategoryID, count(ProductID) as "CountedProducts"
from Production.Product
where ProductSubcategoryID is not null
Group by ProductSubcategoryID;

/*
4. How many products that do not have a product subcategory.
*/

Select count(ProductID) as "Product with no Subcategory"
from Production.Product
where ProductSubcategoryID is null;

/*
5.      Write a query to list the sum of products quantity in the Production.ProductInventory table.
*/
Select * from Production.ProductInventory;

Select Sum(Quantity) as "Total Products Quantity"
from Production.ProductInventory;

/*
6.    Write a query to list the sum of products in the 
Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.

              ProductID    TheSum

              -----------        ----------
*/

Select ProductID, count(ProductID)
from Production.ProductInventory
Where LocationID = 40
Group by ProductID
having Sum(Quantity) < 100;

/*
7.    Write a query to list the sum of products with the shelf information in the Production.ProductInventory table 
and LocationID set to 40 and limit the result to include just summarized quantities less than 100

    Shelf      ProductID    TheSum

    ----------   -----------        -----------
*/

Select Shelf, ProductID , count(ProductID) as TheSum
from Production.ProductInventory
Where LocationID = 40 and Shelf != 'N/A'
Group by Shelf, ProductId
having Sum(Quantity) < 100;

/*
8. Write the query to list the average quantity for products where column LocationID has the value of 10 from the table 
Production.ProductInventory table.
*/

Select Avg(Quantity)
from Production.ProductInventory
where LocationID = 10;


/*
9.    Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory

    ProductID   Shelf      TheAvg

    ----------- ---------- -----------
*/


Select ProductID, Shelf, Avg(Quantity) as "The Avg"
from Production.ProductInventory
Group by ProductID, Shelf
Order by ProductID;

/*
10. Write query  to see the average quantity  of  products by shelf excluding rows that has 
 the value of N/A in the column Shelf from the table Production.ProductInventory

    ProductID   Shelf      TheAvg

    ----------- ---------- -----------
*/

Select ProductID, Shelf, Avg(Quantity) as "The Avg"
from Production.ProductInventory
Where Shelf != 'N/A'
Group by ProductID, Shelf
Order by ProductID;

/*
11.  List the members (rows) and average list price in the Production.Product table. 
This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.

    Color                        Class              TheCount          AvgPrice

    -------------- - -----    -----------            ---------------------
*/

Select * from Production.Product

Select Color, Class, count(*) as "TheCount", Avg(ListPrice) as "AvgPrice"
from Production.Product
where Color is not null and Class is not null
Group by Color,Class
order by Color;

/*
Joins:

12.   Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. 
Join them and produce a result set similar to the following.

    Country                        Province

    ---------                          ----------------------
*/

Select Top 5* from Person.CountryRegion
Select Top 5 * from Person.StateProvince;

Select Country.Name as "Country", State.StateProvinceCode as "Province" 
from Person.CountryRegion  Country
Join
Person.StateProvince  State
on Country.CountryRegionCode = State.CountryRegionCode
Order by Country;

/*
Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables 
and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.

 

    Country                        Province

    ---------                          ----------------------
*/

Select Country.Name as "Country", State.StateProvinceCode as "Province" 
from Person.CountryRegion  Country
Join
Person.StateProvince  State
on Country.CountryRegionCode = State.CountryRegionCode
Where Country.Name in ('Germany','Canada')
Order by Country;

/*
Using Northwnd Database: (Use aliases for all the Joins)

14.  List all Products that has been sold at least once in last 26 years
*/
use Northwind;

Select  Top 5 * from Products

Select Top 5 * from Orders

Select Top 5 * from [Order Details]

Select Distinct  P.ProductID, P.ProductName
From Products p Inner Join [Order Details] od
on p.ProductID = od.ProductID
Inner Join Orders as o
on od.OrderID = o.OrderID
where o.OrderDate >= DATEADD(year, -26, GETDATE());

/*
15.  List top 5 locations (Zip Code) where the products sold most.
*/

Select Top 5 o.ShipPostalCode as ZipCode, count(P.ProductId) as "No of Product Sold"
From Products p Inner Join [Order Details] od
on p.ProductID = od.ProductID
Inner Join Orders as o
on od.OrderID = o.OrderID
Where o.ShipPostalCode is not null
Group by o.ShipPostalCode
Order by "No of Product Sold" DESC;

/*
16.  List top 5 locations (Zip Code) where the products sold most in last 26 years.
*/

Select Top 5 o.ShipPostalCode as ZipCode, count(P.ProductId) as "No of Product Sold"
From Products p Inner Join [Order Details] od
on p.ProductID = od.ProductID
Inner Join Orders as o
on od.OrderID = o.OrderID
Where o.ShipPostalCode is not null 
and 
o.OrderDate >= DATEADD(year, -26, GETDATE())
Group by o.ShipPostalCode
Order by "No of Product Sold" DESC;


/*
17.   List all city names and number of customers in that city.    
*/

Select City, count(CustomerID) as TotalCustomers from Customers 
Group by City
order by City asc;

/*
18.  List city names which have more than 2 customers, and number of customers in that city
*/

Select City, count(CustomerID) as TotalCustomers from Customers 
Group by City
having count(CustomerID) > 2
order by City asc;

/*
19.  List the names of customers who placed orders after 1/1/98 with order date.
*/

Select  Top 5 * from Customers

Select Top 5 * from Orders

SELECT distinct c.ContactName as "Customer Name"
FROM Customers c
INNER JOIN Orders o 
ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01';

/*
20.  List the names of all customers with most recent order dates
*/
SELECT c.ContactName as "Customer Name", o.OrderDate
FROM Customers c
INNER JOIN Orders o 
ON c.CustomerID = o.CustomerID
order by o.OrderDate DESC;

/*

21.  Display the names of all customers  along with the  count of products they bought
*/

Select Top 5 * from Customers;
Select Top 5 * from Products;

Select c.ContactName as "Customer Name", COUNT(p.ProductID) as "Product Count"
from Customers c left join 
orders o 
on c.CustomerID = o.CustomerID inner join 
[Order Details] od
on o.OrderID = od.OrderID
inner join
Products p on
od.ProductID = p.ProductID 
Group by c.ContactName
order by c.ContactName ASC;


/*
22.  Display the customer ids who bought more than 100 Products with count of products.
*/
Select c.CustomerID as "Customer ID"
from Customers c left join 
orders o 
on c.CustomerID = o.CustomerID inner join 
[Order Details] od
on o.OrderID = od.OrderID
inner join
Products p on
od.ProductID = p.ProductID 
Group by c.CustomerID
having COUNT(p.ProductID) > 100
order by c.CustomerID DESC;

/*
23.  List all of the possible ways that suppliers can ship their products. Display the results as below

    Supplier Company Name                Shipping Company Name

    ---------------------------------            ----------------------------------
*/

Select Top 5 * from Suppliers
Select top 5 * from Shippers
Select top 5 * from Products
Select  * from Orders where ShipAddress is null


Select s.CompanyName as "Supplier Company Name", sh.CompanyName as "Shipping Company Name"
from Suppliers as s 
join Products as p
on s.SupplierID = p.SupplierID
join [Order Details] as od
on p.ProductID = od.ProductID
join Orders as o
on od.OrderID = o.OrderID
join Shippers as sh
on o.ShipVia = sh.ShipperID;

/*
24. Display the products order each day. Show Order date and Product Name.
*/

Select top 5 * from Products
Select top 5 * from [Order Details]
Select top 5 * from Orders

Select  o.OrderDate , p.ProductName
from Products as p
 join [Order Details] as od
on p.ProductID = od.ProductID
join
Orders as o
on od.OrderID = o.OrderID
order by o.OrderDate;


/*
25.  Displays pairs of employees who have the same job title.
*/

Select Top 10 EmployeeID, LastName, FirstName, Title, ReportsTo  from Employees

SELECT DISTINCT e1.EmployeeID AS EmployeeID1, e1.FirstName + ' ' + e1.LastName AS "Employee Name1", e1.Title AS Title,
                e2.EmployeeID AS EmployeeID2, e2.FirstName + ' ' + e2.LastName AS "Employee Name2"
FROM Employees e1
JOIN Employees e2 ON e1.Title = e2.Title AND e1.EmployeeID < e2.EmployeeID
ORDER BY e1.Title, e1.EmployeeID, e2.EmployeeID;


/*
26. Display all the Managers who have more than 2 employees reporting to them.
*/

SELECT DISTINCT e1.EmployeeID, e1.LastName, e1.FirstName, e1.Title
FROM Employees e1
JOIN Employees e2 ON e1.EmployeeID = e2.ReportsTo
GROUP BY e1.EmployeeID, e1.LastName, e1.FirstName, e1.Title
HAVING COUNT(e2.EmployeeID) > 2;


/*
27. Display the customers and suppliers by city. The results should have the following columns

City

Name

Contact Name,

Type (Customer or Supplier)
*/
SELECT City, CompanyName AS Name, ContactName, 'Customer' AS Type
FROM Customers
UNION 
SELECT City, CompanyName, ContactName, 'Supplier'
FROM Suppliers
ORDER BY City;

