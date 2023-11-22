use NORTHWND
-- en pahalý ürünü getirme
select top 1 UnitsInStock 
from products
order by unitprice desc
---------------------------------employees---------------------------------
--çalýþan sayýsýný listeleme
select * from employees
select count(*) as [çalýþan sayýsý] from employees

--çalýþanlarýn adýný soyadýný getirme
select firstname as adý ,lastname as soyadý
from employees
--yada 
select firstname+' ' + lastname as [Adý Soyadý]
from employees

-- dr yi listele
select firstname+' ' + lastname as [Adý Soyadý] from employees 
where TitleOfCourtesy = 'Dr.'

-- dr yi ve kadýnlarý listele
select firstname + ' ' + lastname as [Adý Soyadý] from employees
where TitleOfCourtesy = 'Dr.' or TitleOfCourtesy in ('Ms.') or TitleOfCourtesy ='Mrs.'
--yada 
select firstname + ' ' + lastname as [Adý Soyadý] from employees
where TitleOfCourtesy in ('Dr.' , 'Ms.' , 'Mrs.' )

--çalýþan erkekleri listeme
select * from employees 
where TitleOfCourtesy = 'Mr.'

--çalýþan erkek ve kadýnlarýn sayýsýný bulma
select count(*) as [çalýþanlarýn sayýsý] from employees
where TitleOfCourtesy in ('Ms.', 'Mrs.','Mr.')

--çalýþanlar kaç farklý þehirde çalýþýyor
select count(distinct city)
from employees 

--doðum tarihi 1960-05-29 dan büyük olanlarý listeme
select * from employees 
where BirthDate > '1960-05-29'

--adresinin içinde house geçenleri listeleme
select * from employees 
where [Address] like '%house%'

--extension kolonu 3 haneli olanlarý listeleyelim
select * from employees
where extension like '___'
-- yada
select * from employees 
where len(extension)= 3

--çalýþanarýn yaþlarýný bulma
select firstname+' '+lastname as [Adý soyadý] ,datediff(year, birthdate,getdate()) as yaþý from employees

--en genç çalýþanýn yaþý
select top 1 firstname+' '+lastname as [Adý soyadý] , datediff(year, birthdate,getdate()) as yaþý 
from employees
order by  datediff(year, birthdate,getdate()) asc

--çalýþanlarýn iþe kaç yaþýnda baþladýklarýný bulma
select firstname+' '+lastname as [Adý soyadý] ,datediff(year, BirthDate,hiredate) as [Ýþe baþlama yaþý] from employees

--en genç iþe baþlayan
select top 1 firstname+' '+lastname as [Adý soyadý] ,datediff(year, BirthDate,hiredate) as [Ýþe baþlama yaþý] from employees
order by datediff(year, BirthDate,hiredate) asc

--region kolonunu null olanlarý listeleme
select * from employees
where Region is null

--region kolonunu null olmayanlarý listeleme
select * from employees
where Region is not null

--çalýþanlarýn adlarýný a dan z ye ve z den a ya listeleme
select firstname,lastname from employees
order by firstname asc
--ve 
select firstname,lastname from employees
order by firstname desc

--çalýþanlarýn adlarýný a dan z ye soyadlarýný z den a ya listeleme
select firstname,lastname from employees
order by firstname asc , lastname desc

--þirket çalýþanlarýnýn ortalama yaþýný bulma
select avg(datediff(year, BirthDate,getdate())) as [çalýþanlarýn yaþ ortalamasý] from employees

---------------------------------customers---------------------------------
select * from Customers

--müþteri adý a ile baþlayan þirketler
select * from Customers
where companyname like 'a%'

--fax ve region kýsmý null olan müþteriler
select * from Customers
where region is null and fax is null

--fax ya da region kýsmý null olan müþteriler
select * from Customers
where region is null or fax is null

--customerid si aa ile biten müþteriler
select * from customers
where CustomerID like '%aa'

--müþterilerin ülkelere göre sayýlarýný veren sorgu
select count(country) as [sayý] ,country from customers
group by country

--brazilde bulunan müþterilerin þirket adý temsilci adý, adres, þehir ve ülke bilgileri
select companyname as [Þirket Adý],
ContactName as [Temsilci Adý],
[Address] as adres,
city as þehir,
country as ülke
from customers
where country = 'Brazil'

---------------------------------product---------------------------------
select * from products

--ürünlerin kdv dahil ve kdv hariç fiyatlarýný listeleme
select productname as [ürün adý] ,unitprice as [kdv hariç] ,unitprice+unitprice*0.18 as [kdv dahil]
from products
order by unitprice asc

--kdv si 10 tl den düþük olanlarý listeleme
select productname as [ürün adý],unitprice+unitprice*0.18 as [kdv dahil],unitprice*0.18 as [kdv deðeri]
from products
where unitprice*0.18 < 10
order by unitprice asc


--en pahalý 5 ürün
select top 5 productname as [ürün adý] ,unitprice+unitprice*0.18 as [kdv dahil]
from products
order by [kdv dahil] desc

---------------**************
--------------****************
-------------******************
--en ucuz 5 ürünün ortalama fiyatý nedir
select avg(tablo.unitprice) as [ortalama fiyat] from(
select top 5 unitprice from products
order by unitprice asc) as tablo
-------------******************
--------------****************
---------------**************

--ürün adlarýný büyüterek getir
select upper(ProductName) as [Ürün Adý], ProductID from products

--stoðu olmayan ürünler kaç tanedir
select * from products
where UnitsInStock = 0

--stok adedi 20 ile 50 arasýndaki ürünleri getir
select * from products
where UnitsInStock > 20 and UnitsInStock <50
order by UnitsInStock asc
--ya da
select * from products 
where UnitsInStock between 20 and 50
order by UnitsInStock asc

--en pahalý ürünü getir
select top 1 ProductName as [ürün adý],unitprice as [en pahalý ürün]from products
order by UnitPrice desc
--ya da	
select max(unitprice) as [en pahalý ürün] from products 

--kaç çeþit ürün var
select count(productname) from products

--en pahalý ürünün adý nedir
select top 1 ProductName as [ürün adý]from products
order by UnitPrice desc
--ya da
select productname from products
where unitprice = (select max(unitprice) from products)

-- 100 tlden büyük ürünleri görme
select ProductName ,unitprice from products 
where unitprice > 100

--unitinstock stok deðeri 15 in altýnda olan ürünlerin adý fiyatý ve stok bilgileri
select productname as adý,
unitprice as fiyatý,
UnitsInStock as stok
from products
where UnitsInStock < 15 

---------------------------------karýþýk kullaným---------------------------------

---------------**************
--------------****************
-------------******************
--her kategoriden kaç tane ürün var
select c.CategoryName,count(p.ProductID) as [Toplam Adet]from products p inner join categories c
on c.CategoryID=p.CategoryID
group by c.CategoryName
-------------******************
--------------****************
---------------**************

--çalýþanlar ne kadarlýk satýþ yapmýþlar
select e.firstname+' ' +e.lastname as [Çalýþan Adý Soyadý], 
sum(od.unitprice*od.Quantity) as [toplam satýþ]
from employees e inner join orders o 
on o.EmployeeID=e.EmployeeID
inner join [Order Details] od 
on o.OrderID=od.OrderID
group by e.firstname+' ' +e.lastname

--hangi sipariþ bana ne kadar kazandýrmýþ
select OrderID,
sum(unitprice*quantity*(1-Discount)) 
as [siparþilerin kazandýrdýklarý] 
from [Order Details]
group by OrderID

--50 den fazla satýþý olan çalýþanlarý bulma
select e.firstname+' ' +e.lastname  as [Çalýþan Adý Soyadý] ,count(o.OrderID) as [satýþ miktarý]
from employees e inner join orders o 
on o.EmployeeID=e.EmployeeID 
group by e.firstname+' ' +e.lastname
having count(o.OrderID) > 50  

--londra ve pariste bulunan müþlerileri listeleme
select * from customers
where city = 'London' or city = 'Paris'

--adý a harfi ile baþlayan çaýþan müþterileri sýralama
select * from customers
where companyname like 'a%'
--
select * from customers
where ContactName like 'a%'
--
select * from customers
where ContactName like 'a%' and companyname like 'a%'

--50 tl ile 100 tl arasýnda bulunan tüm ürünlerin adlarý ve fiyatlarýný neler
select productname,unitprice 
from products 
where UnitPrice > 50 and unitprice < 100
--ya da
select productname,unitprice 
from products 
where unitprice between 50 and 100

--brezilyada olmayan müþteriler
select * from customers
where country !='Brazil'

--hem mexico d.f de ikamet edenler hem de contactitle bilgisi 'owner' olan müþteriler
select * from customers
where city = 'México D.F.' and ContactTitle = 'owner'

--satýþý yapýlmayan ürün listesi
select * from Products
where Discontinued = 1 and UnitsInStock !=0

--sipariþ tarihleri 1 haziran 1996 ile 31 kasým 1996 tarihleri arasýndaki sipariþlerin orders ,ordersýd bilgileri
select orderId,ShipCountry from orders
where OrderDate between '1996-06-01' and '1996-11-30'

--kaç farklý ülkeye sipariþ yapýldýðý
select count(distinct ShipCountry) as sayý from orders


--alfký customerýd sine sahip müþterinin sipariþ sayýsý nedir
select count(*) as [alfký sayýsý] from orders
where CustomerID = 'ALFKI'

--müþterilerin içinde en uzun isimli müþteri harf sayýsý
select max(len(companyname)) as sayý from customers

--hangi ürünlerden toplam kaç adet alýnmýþ
select productId,sum(quantity) as [kaç adet] from [Order Details]
group by productId
order by [kaç adet] desc


--1000 adetten fazla satýlan ürünler
select productId,sum(quantity) as [kaç adet] from [Order Details]
group by productId
having sum(quantity) > 1000

--ortalamanýn altýnda bir fiyata sahip ürünlerin adý ve fiyatý
select productname,unitprice from products
where unitprice < (select avg(UnitPrice) from products)

--hangi müþteri hiç sipariþ vermemiþ
select * from customers 
where customerId not in (select distinct CustomerId from orders)

--hangi ürün hangi kategoridedir
select p.ProductName,c.CategoryID,c.CategoryName from products p inner join categories c 
on p.CategoryID=c.CategoryID

--bütün nakliyecilerin listesi
select companyname from Shippers

--hangi çalýþan hangi bölgeden sorumlu
select firstname+lastname  as isim ,t.TerritoryDescription from Territories t inner join EmployeeTerritories et on t.TerritoryID = et.TerritoryID
inner join Employees e on e.EmployeeID=et.EmployeeID

--hangi tedarikçi hangi ürünü saðlýyor
select ProductName,CompanyName from Products p 
inner join Suppliers s on 
s.supplierId=p.SupplierID

--bevareges kategorisine ait ürünlerin listesi
--iki sýnýfý birleþtirerek
select * from products p inner join categories c on c.CategoryID=p.CategoryID
where CategoryName='Beverages'
--birleþtirmeden
select * from products where categoryId=(select categoryId from categories where categoryname='Beverages')

--michalein ya da lauranýn hemþerisi olan çalýþanlar
select * from employees where city in (select city from employees where firstname in ('Michael','Laura')) 

--ürünlerin karþýsýna kategori getirme
--birleþtirerek
select p.ProductName,c.CategoryName from products p inner join categories c on c.CategoryID=p.CategoryID
--birleþtirmeden
select p.productname,
(select c.categoryname from Categories c where c.CategoryID=p.CategoryID) as categoryname
from products p
