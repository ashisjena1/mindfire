Create a table named tblEmp and insert some data by using following script:

CREATE TABLE [dbo].[tblEmp](
    [ntEmpID] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [vcName] [varchar](100) NULL,
    [vcMobieNumer] [varchar](15) NULL,
    [vcSkills] [varchar](max) NULL,
    [moSalary] [money] DEFAULT(0) NOT NULL,
    [ntLevel] [bit] DEFAULT(0) NOT NULL
)

--Inserting demo data
INSERT [dbo].[tblEmp] VALUES
    ('abc','123-456-3456','CF,HTML,JavaScript',50,0),
    ('Greg',NULL,'HTML5,JavaScript,Jquery',80,0),
    ('David','123-456-3458','Sql,JavaScript',30,1),
    ('Alan','123-456-3459','C#,VB,XQuery',60,1),
    ('Jhon',NULL,'XML,HTML',80,1),
    ('Alan','123-456-3461','Sql,Oracle,DB2',70,1)
        

/*Assignment:*/

/* SELECT Clause  

1. Write a single sql query with following information's:

a. Total number number of employees
b. Minimum salary received by any employees.
c. Total distinct ntLevel
*/
	select count(*) ,min(moSalary),count(distinct ntLevel) from tblEmp;
            
/* FROM clause */

2. Correct this query:

    SELECT [ntEmpID], E.[vcName],tblEmp.[vcMobieNumer]
    FROM tblEmp E

	SELECT E.[ntEmpID], E.[vcName],E.[vcMobieNumer] FROM tblEmp E;        
/* WHERE clause 
        
3. Write a single select query which satisfies the following conditions:
    a. If any employee does not have a phone number then select that employee if ntLevel  equal to 1
    b. else select those employees whose ntLevel is equal to 0   
*/	
	
	select * from tblEmp where (vcMobieNumer is null and ntLevel=1) or (vcMobieNumer is not null and ntLevel=0)
		
	         
/*  ORDER BY clause 

4.  Write a sql query which displays those employee data first, who knows javascript.
*/
	
	 select ntEmpId,vcName,vcMobieNumer,vcSkills,moSalary,ntLevel from tblEmp 
	 order by case when vcSkills not like '%JavaScript%' Then ntEmpId END;    
	     
/* TOP  clause */
    
5. Explain the TOP clause in the following sql queries?
    
    a. SELECT TOP(1) * FROM tblEmp 
		it will fetch the first row of the relation.
		SELECT 3/2
    b. SELECT TOP(SELECT 3/2) * FROM tblEmp 
		slect 3/2 will return 1. so this query is same as previous one. it will fetch the 1st row.
    c. SELECT TOP(1) PERCENT * FROM tblEmp
		it will fetch only one row because the fractional value will rounded up to whole number.
    d. SELECT TOP(1) WITH TIES * FROM tblEmp ORDER BY vcName
		it will sort the relation data by vcName then fetch 1st row and check other row for same vcName if match then fetch that row. 
        
/* GROUP BY/HAVING I know we did not discuss this, but do if you can!*/

	group by is used to implement aggregate function using two or more columns.
	having is used as a filter for the select row after implementing group by.

6. When I executed this query:
           
   SELECT [vcName],[vcMobieNumer] FROM [dbo].[tblEmp] GROUP BY [vcName]
           
    I got following error message:
    Column 'dbo.tblEmp.vcMobieNumer' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.

    Can you explain above error message? Write at least two possible solutions. 

    A) in group by clause we need to add all the selected columnns in the select clause except the aggregate function.
	1st solution
	------------
	we can add [vcMobieNumer] to the group by clause.
	SELECT [vcName],[vcMobieNumer] FROM [dbo].[tblEmp] GROUP BY [vcName],[vcMobieNumer]
    2nd solution
	------------
	we can remove [vcMobieNumer] from the select clause.
	SELECT [vcName] FROM [dbo].[tblEmp] GROUP BY [vcName]

	
	SELECT [vcName],max(vcMobieNumer) FROM [dbo].[tblEmp] GROUP BY [vcName]
/*
7. Write a sql query to get the ntLevel of the employees getting salary greater than average salary.
 */
          SELECT ntLevel from tblEmp where moSalary>(select avg(moSalary) from tblEmp)

/*
Do the following questions using AdventureWorks DB
-------------------------------------------------------
8. Write a query to get the count of employees with a valid Suffix 
*/
	select count(*)  from [Person].[Person] where suffix is not null

/*
9. Using BusinessEntityAddress table (and other tables as required), list the full name of people living in the state of Florida
*/

	select concat(isnull(FirstName,''),' ',isnull(LastName,'')) as Fullname from [Person].[Person] pp join 
	[Person].[BusinessEntityAddress] PBEA on PBEA.BusinessEntityID=pp.BusinessEntityID join
	[Person].[Address] PA on PBEA.AddressID = PA.AddressID join [Person].[StateProvince] PSP on
	PA.StateProvinceID=PSP.StateProvinceID where PSP.Name='Florida'

/*
10. Show the CompanyName for James D. Kramer
*/

/*
11. "Single Item Order" is a customer order where only one item is ordered. Show the SalesOrderID and the UnitPrice for every Single Item Order.
*/

	select salesOrderID,UnitPrice from [Sales].[SalesOrderDetail] where orderQty=1
	
/*
12. Show the product description for culture 'fr' for product with ProductID 736.
*/
	select pd.Description from [Production].[ProductDescription] pd join [Production].[ProductModelProductDescriptionCulture] pmpdc on
	pd.ProductDescriptionID=pmpdc.ProductDescriptionID join [Production].[Product] pp on pp.ProductModelID=pmpdc.ProductModelID
	where pp.ProductID=736 and  pmpdc.CultureID='fr' 

/*
13. Show OrdeQty, the Name and the ListPrice of the order made by CustomerID 635
*/

	select sod.OrderQty,pp.Name,sod.UnitPrice from [Sales].[SalesOrderDetail] sod join [Production].[Product] pp 
	on sod.ProductID=pp.ProductID join [Sales].[SalesOrderHeader] soh 
	on soh.SalesOrderID=sod.SalesOrderID where soh.CustomerID=635

/*
14. How many products in ProductSubCategory 'Cranksets' have been sold to an address in 'London'?
*/
	select sum(sod.OrderQty) from [Sales].[SalesOrderDetail] sod join [Production].[Product] pp on sod.ProductID=pp.ProductID join
	[Production].[ProductSubcategory] ps on pp.ProductSubcategoryID = ps.ProductSubcategoryID join [Sales].[SalesOrderHeader] soh on
	sod.SalesOrderID=soh.SalesOrderID join [Person].[Address] pa on soh.ShipToAddressID=pa.AddressID where pa.City='London'
	and ps.name='Cranksets'


/*
15. Describe Char, Varchar and NVarChar datatypes with examples. 
*/
	char adds trailing space
	varchar does not add any trailing space it takes 1 byte for each character
	NVARCHAR Used to store Unicode characters it takes 2 bytes for each character
