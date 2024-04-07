Use AdventureWorks2019;


/*
 ASSIGNMENT 1
 -------------------------------------
 Write queries for following scenarios - Using AdventureWorks Database
Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter. 
Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, excludes the rows that ListPrice is 0.
Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are NULL for the Color column.
Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.
Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
Write a query that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.
Write a query that generates the following result set  from Production.Product:
NAME: LL Crankarm  --  COLOR: Black
NAME: ML Crankarm  --  COLOR: Black
NAME: HL Crankarm  --  COLOR: Black
NAME: Chainring Bolts  --  COLOR: Silver
NAME: Chainring Nut  --  COLOR: Silver
NAME: Chainring  --  COLOR: Black
Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
Write a query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and blue
Write a query to get a result set on products that begins with the letter S. 
Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
Name                                               ListPrice
Seat Lug                                              0,00
Seat Post                                             0,00
Seat Stays                                            0,00
Seat Tube                                            0,00
Short-Sleeve Classic Jersey, L           53,99
Short-Sleeve Classic Jersey, M          53,99
 Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'
Name                                               ListPrice
Adjustable Race                                   0,00
All-Purpose Bike Stand                       159,00
AWC Logo Cap                                      8,99
Seat Lug                                                 0,00
Seat Post                                                0,00
Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.
Write a query that retrieves unique colors from the table Production.Product. Order the results  in descending  manner
Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result.


*/

/*
ANS 1. 
*/

Select ProductID, Name, Color, ListPrice 
from Production.Product;

/*
Ans 2
*/
Select ProductID, Name, Color, ListPrice 
from Production.Product where ListPrice != 0;

/*
Ans 3
*/
Select ProductID, Name, Color, ListPrice 
from Production.Product where Color is Null;

/*
Ans 4
*/

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL;


/*
Ans 5
*/

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL
AND ListPrice > 0;


/*
Ans 6
*/

Select Name + ' ' + Color as "Product Color" 
from production.Product
where Color is not null;

/*
Ans 7
*/

Select 'NAME: ' + Name + ' ' + '---' + ' ' + 'COLOR:' + ' ' + Color
from production.Product
where color is not null;

/*
Ans 8
*/

SELECT ProductID, Name
FROM Production.Product
WHERE ProductID Between 400 and 500;

/*
Ans 9
*/

SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IN ('Black', 'Blue');

/*
Ans 10
*/

Select * from Production.Product
where Name like 'S%';

/*
Ans 11
*/
Select Name, ListPrice from Production.Product
where Name like 'S%'
order by Name ASC;

/*
Ans 12
*/

Select Name, ListPrice from Production.Product
where Name like 'S%' or Name like'A%'
order by Name ASC;

/*
Ans 13
*/

SELECT *
FROM Production.Product
WHERE Name LIKE 'SPO[^K]%'
ORDER BY Name;

/*
Ans 14
*/

Select distinct Color
FROM Production.Product
where Color is not null
order by Color DESC;


/*
15
*/

SELECT DISTINCT ProductSubcategoryID, Color
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL AND Color IS NOT NULL
ORDER BY ProductSubcategoryID, Color;

