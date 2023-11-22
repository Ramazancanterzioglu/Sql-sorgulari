use NORTHWND
-- en pahal� �r�n� getirme
select top 1 UnitsInStock 
from products
order by unitprice desc
---------------------------------employees---------------------------------
--�al��an say�s�n� listeleme
select * from employees
select count(*) as [�al��an say�s�] from employees

--�al��anlar�n ad�n� soyad�n� getirme
select firstname as ad� ,lastname as soyad�
from employees
--yada 
select firstname+' ' + lastname as [Ad� Soyad�]
from employees

-- dr yi listele
select firstname+' ' + lastname as [Ad� Soyad�] from employees 
where TitleOfCourtesy = 'Dr.'

-- dr yi ve kad�nlar� listele
select firstname + ' ' + lastname as [Ad� Soyad�] from employees
where TitleOfCourtesy = 'Dr.' or TitleOfCourtesy in ('Ms.') or TitleOfCourtesy ='Mrs.'
--yada 
select firstname + ' ' + lastname as [Ad� Soyad�] from employees
where TitleOfCourtesy in ('Dr.' , 'Ms.' , 'Mrs.' )

--�al��an erkekleri listeme
select * from employees 
where TitleOfCourtesy = 'Mr.'

--�al��an erkek ve kad�nlar�n say�s�n� bulma
select count(*) as [�al��anlar�n say�s�] from employees
where TitleOfCourtesy in ('Ms.', 'Mrs.','Mr.')

--�al��anlar ka� farkl� �ehirde �al���yor
select count(distinct city)
from employees 

--do�um tarihi 1960-05-29 dan b�y�k olanlar� listeme
select * from employees 
where BirthDate > '1960-05-29'

--adresinin i�inde house ge�enleri listeleme
select * from employees 
where [Address] like '%house%'

--extension kolonu 3 haneli olanlar� listeleyelim
select * from employees
where extension like '___'
-- yada
select * from employees 
where len(extension)= 3

--�al��anar�n ya�lar�n� bulma
select firstname+' '+lastname as [Ad� soyad�] ,datediff(year, birthdate,getdate()) as ya�� from employees

--en gen� �al��an�n ya��
select top 1 firstname+' '+lastname as [Ad� soyad�] , datediff(year, birthdate,getdate()) as ya�� 
from employees
order by  datediff(year, birthdate,getdate()) asc

--�al��anlar�n i�e ka� ya��nda ba�lad�klar�n� bulma
select firstname+' '+lastname as [Ad� soyad�] ,datediff(year, BirthDate,hiredate) as [��e ba�lama ya��] from employees

--en gen� i�e ba�layan
select top 1 firstname+' '+lastname as [Ad� soyad�] ,datediff(year, BirthDate,hiredate) as [��e ba�lama ya��] from employees
order by datediff(year, BirthDate,hiredate) asc

--region kolonunu null olanlar� listeleme
select * from employees
where Region is null

--region kolonunu null olmayanlar� listeleme
select * from employees
where Region is not null

--�al��anlar�n adlar�n� a dan z ye ve z den a ya listeleme
select firstname,lastname from employees
order by firstname asc
--ve 
select firstname,lastname from employees
order by firstname desc

--�al��anlar�n adlar�n� a dan z ye soyadlar�n� z den a ya listeleme
select firstname,lastname from employees
order by firstname asc , lastname desc

--�irket �al��anlar�n�n ortalama ya��n� bulma
select avg(datediff(year, BirthDate,getdate())) as [�al��anlar�n ya� ortalamas�] from employees

---------------------------------customers---------------------------------
select * from Customers

--m��teri ad� a ile ba�layan �irketler
select * from Customers
where companyname like 'a%'

--fax ve region k�sm� null olan m��teriler
select * from Customers
where region is null and fax is null

--fax ya da region k�sm� null olan m��teriler
select * from Customers
where region is null or fax is null

--customerid si aa ile biten m��teriler
select * from customers
where CustomerID like '%aa'

--m��terilerin �lkelere g�re say�lar�n� veren sorgu
select count(country) as [say�] ,country from customers
group by country

--brazilde bulunan m��terilerin �irket ad� temsilci ad�, adres, �ehir ve �lke bilgileri
select companyname as [�irket Ad�],
ContactName as [Temsilci Ad�],
[Address] as adres,
city as �ehir,
country as �lke
from customers
where country = 'Brazil'

---------------------------------product---------------------------------
select * from products

--�r�nlerin kdv dahil ve kdv hari� fiyatlar�n� listeleme
select productname as [�r�n ad�] ,unitprice as [kdv hari�] ,unitprice+unitprice*0.18 as [kdv dahil]
from products
order by unitprice asc

--kdv si 10 tl den d���k olanlar� listeleme
select productname as [�r�n ad�],unitprice+unitprice*0.18 as [kdv dahil],unitprice*0.18 as [kdv de�eri]
from products
where unitprice*0.18 < 10
order by unitprice asc


--en pahal� 5 �r�n
select top 5 productname as [�r�n ad�] ,unitprice+unitprice*0.18 as [kdv dahil]
from products
order by [kdv dahil] desc

---------------**************
--------------****************
-------------******************
--en ucuz 5 �r�n�n ortalama fiyat� nedir
select avg(tablo.unitprice) as [ortalama fiyat] from(
select top 5 unitprice from products
order by unitprice asc) as tablo
-------------******************
--------------****************
---------------**************

--�r�n adlar�n� b�y�terek getir
select upper(ProductName) as [�r�n Ad�], ProductID from products

--sto�u olmayan �r�nler ka� tanedir
select * from products
where UnitsInStock = 0

--stok adedi 20 ile 50 aras�ndaki �r�nleri getir
select * from products
where UnitsInStock > 20 and UnitsInStock <50
order by UnitsInStock asc
--ya da
select * from products 
where UnitsInStock between 20 and 50
order by UnitsInStock asc

--en pahal� �r�n� getir
select top 1 ProductName as [�r�n ad�],unitprice as [en pahal� �r�n]from products
order by UnitPrice desc
--ya da	
select max(unitprice) as [en pahal� �r�n] from products 

--ka� �e�it �r�n var
select count(productname) from products

--en pahal� �r�n�n ad� nedir
select top 1 ProductName as [�r�n ad�]from products
order by UnitPrice desc
--ya da
select productname from products
where unitprice = (select max(unitprice) from products)

-- 100 tlden b�y�k �r�nleri g�rme
select ProductName ,unitprice from products 
where unitprice > 100

--unitinstock stok de�eri 15 in alt�nda olan �r�nlerin ad� fiyat� ve stok bilgileri
select productname as ad�,
unitprice as fiyat�,
UnitsInStock as stok
from products
where UnitsInStock < 15 

---------------------------------kar���k kullan�m---------------------------------

---------------**************
--------------****************
-------------******************
--her kategoriden ka� tane �r�n var
select c.CategoryName,count(p.ProductID) as [Toplam Adet]from products p inner join categories c
on c.CategoryID=p.CategoryID
group by c.CategoryName
-------------******************
--------------****************
---------------**************

--�al��anlar ne kadarl�k sat�� yapm��lar
select e.firstname+' ' +e.lastname as [�al��an Ad� Soyad�], 
sum(od.unitprice*od.Quantity) as [toplam sat��]
from employees e inner join orders o 
on o.EmployeeID=e.EmployeeID
inner join [Order Details] od 
on o.OrderID=od.OrderID
group by e.firstname+' ' +e.lastname

--hangi sipari� bana ne kadar kazand�rm��
select OrderID,
sum(unitprice*quantity*(1-Discount)) 
as [sipar�ilerin kazand�rd�klar�] 
from [Order Details]
group by OrderID

--50 den fazla sat��� olan �al��anlar� bulma
select e.firstname+' ' +e.lastname  as [�al��an Ad� Soyad�] ,count(o.OrderID) as [sat�� miktar�]
from employees e inner join orders o 
on o.EmployeeID=e.EmployeeID 
group by e.firstname+' ' +e.lastname
having count(o.OrderID) > 50  

--londra ve pariste bulunan m��lerileri listeleme
select * from customers
where city = 'London' or city = 'Paris'

--ad� a harfi ile ba�layan �a��an m��terileri s�ralama
select * from customers
where companyname like 'a%'
--
select * from customers
where ContactName like 'a%'
--
select * from customers
where ContactName like 'a%' and companyname like 'a%'

--50 tl ile 100 tl aras�nda bulunan t�m �r�nlerin adlar� ve fiyatlar�n� neler
select productname,unitprice 
from products 
where UnitPrice > 50 and unitprice < 100
--ya da
select productname,unitprice 
from products 
where unitprice between 50 and 100

--brezilyada olmayan m��teriler
select * from customers
where country !='Brazil'

--hem mexico d.f de ikamet edenler hem de contactitle bilgisi 'owner' olan m��teriler
select * from customers
where city = 'M�xico D.F.' and ContactTitle = 'owner'

--sat��� yap�lmayan �r�n listesi
select * from Products
where Discontinued = 1 and UnitsInStock !=0

--sipari� tarihleri 1 haziran 1996 ile 31 kas�m 1996 tarihleri aras�ndaki sipari�lerin orders ,orders�d bilgileri
select orderId,ShipCountry from orders
where OrderDate between '1996-06-01' and '1996-11-30'

--ka� farkl� �lkeye sipari� yap�ld���
select count(distinct ShipCountry) as say� from orders


--alfk� customer�d sine sahip m��terinin sipari� say�s� nedir
select count(*) as [alfk� say�s�] from orders
where CustomerID = 'ALFKI'

--m��terilerin i�inde en uzun isimli m��teri harf say�s�
select max(len(companyname)) as say� from customers

--hangi �r�nlerden toplam ka� adet al�nm��
select productId,sum(quantity) as [ka� adet] from [Order Details]
group by productId
order by [ka� adet] desc


--1000 adetten fazla sat�lan �r�nler
select productId,sum(quantity) as [ka� adet] from [Order Details]
group by productId
having sum(quantity) > 1000

--ortalaman�n alt�nda bir fiyata sahip �r�nlerin ad� ve fiyat�
select productname,unitprice from products
where unitprice < (select avg(UnitPrice) from products)

--hangi m��teri hi� sipari� vermemi�
select * from customers 
where customerId not in (select distinct CustomerId from orders)

--hangi �r�n hangi kategoridedir
select p.ProductName,c.CategoryID,c.CategoryName from products p inner join categories c 
on p.CategoryID=c.CategoryID

--b�t�n nakliyecilerin listesi
select companyname from Shippers

--hangi �al��an hangi b�lgeden sorumlu
select firstname+lastname  as isim ,t.TerritoryDescription from Territories t inner join EmployeeTerritories et on t.TerritoryID = et.TerritoryID
inner join Employees e on e.EmployeeID=et.EmployeeID

--hangi tedarik�i hangi �r�n� sa�l�yor
select ProductName,CompanyName from Products p 
inner join Suppliers s on 
s.supplierId=p.SupplierID

--bevareges kategorisine ait �r�nlerin listesi
--iki s�n�f� birle�tirerek
select * from products p inner join categories c on c.CategoryID=p.CategoryID
where CategoryName='Beverages'
--birle�tirmeden
select * from products where categoryId=(select categoryId from categories where categoryname='Beverages')

--michalein ya da lauran�n hem�erisi olan �al��anlar
select * from employees where city in (select city from employees where firstname in ('Michael','Laura')) 

--�r�nlerin kar��s�na kategori getirme
--birle�tirerek
select p.ProductName,c.CategoryName from products p inner join categories c on c.CategoryID=p.CategoryID
--birle�tirmeden
select p.productname,
(select c.categoryname from Categories c where c.CategoryID=p.CategoryID) as categoryname
from products p
