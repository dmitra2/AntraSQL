Use Northwind;

/*
Write queries for following scenarios
All scenarios are based on Database NORTHWIND.

1.      List all cities that have both Employees and Customers.
*/

Select * from Employees
Select * from Customers

Select distinct e.City from Employees e 
inner Join 
Customers c
on e.City = c.City;

/*
2. 2.      List all cities that have Customers but no Employee.

a.      Use sub-query

b.      Do not use sub-query
*/

Select distinct City from Customers
where city not in (select city from Employees);

Select distinct c.City
from Customers as c
left join 
Employees e
on c.City = e.City
where e.City is Null;

/*
3. List all products and their total order quantities throughout all orders.
*/

Select Top 5 * from Products;
Select Top 5 * from [Order Details];

Select P.ProductID, p.ProductName, sum(od.Quantity) as "Total Order Quantity"
from Products p
left join [Order Details] od
on p.ProductID = od.ProductID
group by P.ProductID, p.ProductName
order by p.ProductID;

/*
4. List all Customer Cities and total products ordered by that city.
*/

Select Top 5 * from Customers
Select Top 5 * from Products
Select Top 5 * from Orders
Select Top 5 * from [Order Details]


Select  c.City, sum(od.ProductID) as "Total Products" from Customers c
left join Orders o on
c.CustomerID = o.CustomerID
left join  [Order Details] od
on o.OrderID = od.OrderID
Group by c.City
order by c.City asc;

/*
5. List all Customer Cities that have at least two customers.

a.      Use union

b.      Use sub-query and no union

NOTE : I THINK THAT THE QUESTION IS WRONG
*/

Select * from Customers

Select City, COUNT(CustomerID) as "Total Customers"  from Customers
group by City
having COUNT(CustomerID) >=  2;

/*
6.      List all Customer Cities that have ordered at least two different kinds of products.
*/

Select Top 5 * from Customers
Select Top 5 * from Orders
Select Top 5 * from [Order Details]
Select Top 5 * from Products

Select c.City, count(p.ProductID)
from Customers c
join Orders o
on c.CustomerID = o.CustomerID
join [Order Details] od
on o.OrderID = od.OrderID
join Products p
on od.ProductID = p.ProductID
group by c.City
having count(distinct p.ProductID) > 2;

/*
7. List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
*/
Select Top 5 * from Customers
Select Top 5 * from Orders
select top 5 * from [Order Details];

Select c.CustomerID, c.ContactName, o.OrderID, p.ProductID, c.City as "Customer City", o.ShipCity as "Shipping City"
from Customers c
Left Join 
Orders o
on c.CustomerID = o.CustomerID
join [Order Details] od
on o.OrderID = od.OrderID 
join Products p
on od.ProductID = p.ProductID
WHERE c.City != o.ShipCity;

/*
8. List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
*/

Select Top 5 * from Products;
Select Top 5 * from [Order Details];


WITH PopularProduct AS(
	Select top 5 p.ProductID, p.ProductName, avg(od.UnitPrice) as "Average Price"
	from Products p
	join
	[Order Details] od
	on p.ProductID = od.ProductID
	group by  p.ProductID, p.ProductName
	order by COUNT(od.OrderID) DESC
)
Select 
pp.ProductID, pp.ProductName, pp.[Average Price], od.Quantity, c.City as "Cuctomer City with maximum order"
from PopularProduct pp
join [Order Details] od
on pp.ProductID = od.ProductID
join Orders o
on od.OrderID = o.OrderID
join Customers c
on o.CustomerID = c.CustomerID
order by (od.Quantity) DESC;

/*
9.      List all cities that have never ordered something but we have employees there.

a.      Use sub-query

b.      Do not use sub-query
*/

Select Distinct City
from Employees
where City not in (
Select City
from Customers c 
join Orders o
on c.CustomerID = o.CustomerID);

Select e.City
from Employees e
left join (
Select City
from Customers c 
join Orders o
on c.CustomerID = o.CustomerID) as cte
on e.City = cte.City
where cte.City is null;


/*
10.  List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, 
and also the city of most total quantity of products ordered from. (tip: join  sub-query)
*/

SELECT 
    EmployeeCity,
    CustomerCity
FROM (
    SELECT 
        e.City AS EmployeeCity,
        c.City AS CustomerCity,
        ROW_NUMBER() OVER (ORDER BY OrdersSold DESC) AS EmployeeOrderRank,
        ROW_NUMBER() OVER (ORDER BY TotalQuantity DESC) AS CustomerQuantityRank
    FROM Employees e
    LEFT JOIN (
        SELECT 
            EmployeeID,
            COUNT(*) AS OrdersSold
        FROM Orders
        GROUP BY EmployeeID
    ) AS EmployeeOrders ON e.EmployeeID = EmployeeOrders.EmployeeID
    LEFT JOIN (
        SELECT 
            o.EmployeeID,
            SUM(od.Quantity) AS TotalQuantity
        FROM Orders o
        INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
        GROUP BY o.EmployeeID
    ) AS EmployeeQuantity ON e.EmployeeID = EmployeeQuantity.EmployeeID
    LEFT JOIN Customers c ON e.City = c.City
) AS RankedCities
WHERE EmployeeOrderRank = 1 OR CustomerQuantityRank = 1;


/*
11. How do you remove the duplicates record of a table?
*/

/*
	We can use the ROW_NUMBER() function in combination with a common table expression (CTE) 
	to identify and delete duplicate rows.
*/

/* STEP 1 : Create a table "Demoemployee" with dublicate records (NAME, EMAIL ID, CITY)*/

Create Table Demoemployee (
 ID int Primary key Not Null,
 NAME varchar(20), 
 EMAIID varchar(20),
 CITY varchar(10)
);

/* STEP 2 : Insert values and duplicate values in the table */

Insert into Demoemployee
values 
(1, 'Debayan Mitra', 'dmitra2@hawk.iit,edu', 'Chicago'),
(2, 'Ajay', 'abc@gmail.com', 'Washington'),
(3, 'Peter', 'bcs@gmail.com', 'Newyork'),
(4, 'Peter', 'bcs@gmail.com', 'Newyork'),
(5, 'Debayan Mitra', 'dmitra2@hawk.iit,edu', 'Chicago'),
(6, 'David', 'bvc@gami;.com', 'Boston'),
(7, 'Tim', 'tim@gmail.com', 'Dallas'),
(8, 'Debayan Mitra', 'dmitra2@hawk.iit,edu', 'Chicago'),
(9, 'Hardik', 'Hh@gmail.com', 'Chicago');



/* STEP 3 : Select Records from the table */

Select * from Demoemployee;

/* We can see the duplicate records from the following table 

ID	EMPLOYEENAME	EMALID					CITY
1	Debayan Mitra	dmitra2@hawk.iit,edu	Chicago
2	Ajay			abc@gmail.com			Washington
3	Peter			bcs@gmail.com			Newyork
4	Peter			bcs@gmail.com			Newyork             --Duplicate record        
5	Debayan Mitra	dmitra2@hawk.iit,edu	Chicago             --Duplicate record  
6	David			bvc@gami;.com			Boston
7	Tim				tim@gmail.com			Dallas
8	Debayan Mitra	dmitra2@hawk.iit,edu	Chicago				--Duplicate Record
9	Hardik			Hh@gmail.com			Chicago
*/

/* STEP 4 : Identification of Duplicate Records */

with dum as (
Select *,
ROW_NUMBER() over (partition by EMPLOYEENAME, EMAILID, CITY order by(Select Null)) as rowno 
from Demoemployee
)
/*Duplicate Records Deleted */
Delete from dum where rowno > 1;

/*After deletion of the dummy records */

Select * from Demoemployee;

/*
ID	EMPLOYEENAME	EMAILID					CITY
2	Ajay			abc@gmail.com			Washington
3	Peter			bcs@gmail.com			Newyork
6	David			bvc@gami;.com			Boston
7	Tim				tim@gmail.com			Dallas
8	Debayan Mitra	dmitra2@hawk.iit.edu	Chicago
9	Hardik			Hh@gmail.com			Chicago
*/
