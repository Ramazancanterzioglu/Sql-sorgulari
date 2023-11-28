use NORTHWND
---------------------------------Employees---------------------------------
--1--Calisanlarin sayisini listeleme
select * from Employees
select count(*) as [Calisan sayisi] from Employees

--2--Calisanlarin adini ve soyadini getirme
select firstname as Adi ,lastname as Soyadi
from Employees
--2.1--Ya da isimleri birlestirerek getirme
select firstname + ' ' + lastname as [Adi Soyadi]
from employees

--3--TitleOfCourtesy'i 'Dr.' olanlarin adi ve soyadini getirme
select firstname+' ' + lastname as [Adi Soyadi] from Employees 
where TitleOfCourtesy = 'Dr.'

--4--TitleOfCourtesy'i 'Dr.','Ms.','Mrs.' olanlarin adi ve soyadini getirme
select firstname + ' ' + lastname as [Adi Soyadi] from Employees
where TitleOfCourtesy = 'Dr.' or TitleOfCourtesy = ('Ms.') or TitleOfCourtesy ='Mrs.'
--4.1--Ya da in kullanarak birlestirip getirme
select firstname + ' ' + lastname as [Adi Soyadi] from Employees
where TitleOfCourtesy in ('Dr.' , 'Ms.' , 'Mrs.' )

--5--TitleOfCourtesy'i 'Mr.' olanlari getirme
select * from employees 
where TitleOfCourtesy = 'Mr.'

--6--TitleOfCourtesy'i 'Mr.','Ms.','Mrs.' olan kac kisi vardir 
select count(*) as [Calisanlarin Sayisi] from Employees
where TitleOfCourtesy in ('Ms.', 'Mrs.','Mr.')

--7--kac farkli sehirde calisan var
select count(distinct city) [Farkli Sehirde Calisan Sayisi]
from employees 

--8--Dogum tarihi 1960-05-29 dan buyuk olan calisanlarin adini soyadini ve dogum tarihini getirme
select firstname + ' ' + lastname as [Adi Soyadi] ,BirthDate as [Dogum Tarihi] from Employees 
where BirthDate > '1960-05-29'

--9--Address'in icinde house gecen calisanlarin adini soyadini ve adresini getirme
select firstname + ' ' + lastname as [Adi Soyadi] ,Address from Employees 
where [Address] like '%house%'

--10--Extension kolonu 3 haneli olanlarin adini soyadini ve extension kismini getirme
select firstname + ' ' + lastname as [Adi Soyadi] ,Extension from Employees
where Extension like '___'
--10.1--Ya da farkli bir yoldan
select firstname + ' ' + lastname as [Adi Soyadi] ,Extension from Employees 
where len(extension)= 3

--11--Calisanlarin yaslarini bulup kucukten buyuge siralama
select firstname+' '+lastname as [Adi Soyadi] ,datediff(year, birthdate,getdate()) as [Calisanlarin Yaslari] from Employees
order by [Calisanlarin Yaslari]

--12--En genc calisanin adini,soyadini ve yasini getirme
select top 1 firstname+' '+lastname as [Adi Soyadi] , datediff(year, birthdate,getdate()) as [En Genc Calisan Yasi] 
from Employees
order by  datediff(year, birthdate,getdate()) asc

--13--calisanlarin ise kac yasinda basladiklarini bulup kucukten buyuge siralama
select firstname+' '+lastname as [Adi Soyadi] ,datediff(year, BirthDate,hiredate) as [Ise Baslama Yasi] from Employees
order by [Ise Baslama Yasi]

--14--En genc ise baslayan calisanin adini,soyadini ve yasini getirme
select top 1 firstname+' '+lastname as [Adi Soyadi] ,datediff(year, BirthDate,hiredate) as [En Genc Ise Baslayanin Yasi] from Employees
order by datediff(year, BirthDate,hiredate) asc

--15--Region kismi null olan calisanlari listeleme
select * from Employees
where Region is null

--16--Region kolonunu null olmayan calisanlari listeleme
select * from Employees
where Region is not null

--17--Calisanlarin adlarini A'dan Z'ye siralama
select firstname as Ad,lastname as Soyad from Employees
order by firstname asc

--18--Calisanlarin adlarini Z'den A'ya siralama 
select firstname as Ad,lastname as Soyad from Employees
order by firstname desc

--19--Calisanlarin adlarini A'dan Z'ye soyadlarini Z'den A'ya siralama
select firstname as Ad,lastname as Soyad from Employees
order by firstname asc , lastname desc

--20--Sirket calisanlarinin yaslarinin ortalamasini bulma
select avg(datediff(year, BirthDate,getdate())) as [Calisanlarin Yas Ortalamasi] from Employees

--21--'Michael' ya da 'Laura' ile ayni sehirde yasayan calisanlar
select * from Employees where city in (select city from employees where firstname in ('Michael','Laura')) 

--22--Calisanlarin adlarini buyultulmus sekilde getirme
select upper (FirstName) as ad from Employees

--23--Calisanlarin adlarini kucultulmus sekilde getirme
select lower (FirstName) as ad from Employees

--24--TitleOfCourtesy'i 'Mr.' olanin yerine 'Erkek','Ms.' ve 'Mrs.' olanin yerine 'Kadin' ,'Dr.' olanin yerine 'Doktor' koy
select firstname, lastname,
case titleofcourtesy when 'Ms.' then 'Kadin'
when 'Mr.' then 'Erkek'
when 'Mrs.' then 'Kadin'
else 'Doktor' end as [Durum]
from employees

---------------------------------Customers---------------------------------
select * from Customers

--1--Musterilerin sirket adi 'A' ile baslayan musterileri getirme
select * from Customers
where companyname like 'a%'

--2--Fax ve region kismi null olan musterileri getirme
select * from Customers
where region is null and fax is null

--3--Fax ya da region kismi null olan musterileri getirme
select * from Customers
where region is null or fax is null

--4--CustomerID'si 'AA' ile biten musterileri getirme
select * from customers
where CustomerID like '%AA'

--5--Musterilerin ulkelere gore sayilarini veren sorgu
select count(country) as [Kac adet var] ,country from customers
group by country

--6--'Brazil' de bulunan musterilerin sirket adi temsilci adi, adres, sehir ve ulke bilgilerini getirme 
select companyname as [Sirket Adi],
ContactName as [Temsilci Adi],
[Address] as Adres,
city as sehir,
country as ulke
from customers
where country = 'Brazil'

--7--'London' ve 'Paris' de bulunan musterileri listeleme
select * from Customers
where city = 'London' or city = 'Paris'

--8--Musterilerin icinde en uzun CompanyName'li musteriyi getirme
select * from customers
where CompanyName=(select (max(companyname))from customers)

--9--Musterilerin icinde en uzun isimli musterinin harf sayisi
select max(len(companyname)) as sayi from customers

--10--'Brazil'de olmayan musterileri getirme
select * from customers
where country !='Brazil'

--11--Hem 'México D.F.' bulunanlar hem de ContactTitle bilgisi 'owner' olan musterileri getirme
select * from customers
where city = 'México D.F.' and ContactTitle = 'owner'

--12--Musterilerden ContactName'i ve CompanyName'i 'A' harfi ile baslayanlari getirme 
select * from customers
where ContactName like 'a%' and CompanyName like 'a%'

--13--Hangi ulkeden kac adet var
select country ,Count(*) as SAYI
from customers
group by country

--14--Hangi ulkeden kac adet var 5'den buyuk olanlari getir
select country ,Count(*) as SAYI
from customers
group by country
having Count(*) > 5
---------------------------------product---------------------------------
select * from products

--1--Urunlerin kdv haric fiyatlarini productname ile birlikte getirme ve ucrete gore siralama
select productname as [Urun Adi] ,unitprice as [Kdv Haric] from products
order by unitprice asc

--2--Urunlerin kdv dahil fiyatlarini productname ile birlikte getirme ve ucrete gore siralama
select productname as [Urun Adi] ,unitprice+unitprice*0.18 as [Kdv Dahil] from products
order by unitprice asc

--3--Kdv degeri 10 Tl'den az olanlari getirme ve ucrete gore siralama
select productname as [Urun Adi],unitprice+unitprice*0.18 as [kdv dahil],unitprice*0.18 as [kdv degeri]
from products
where unitprice*0.18 < 10
order by unitprice asc

--4--En pahali 5 urunu urun adi ve kdv dahil fiyatiyla getirme
select top 5 productname as [Urun Adi] ,unitprice+unitprice*0.18 as [kdv dahil]
from products
order by [kdv dahil] desc

--******************
--5--En ucuz 5 urunun ortalama fiyati nedir
select avg(tablo.unitprice) as [ortalama fiyat] from(
select top 5 unitprice from products
order by unitprice asc) as tablo

--6--Urun adlarini urun adi buyuk bir sekilde ProductID ile bitlikte getir ve ProductID'ye gore kucukten buyuge sirala
select upper(ProductName) as [Urun Adi], ProductID from products
order by ProductID

--7--Stogu olmayan urunleri siralama
select * from products
where UnitsInStock = 0

--8--Stogu olmayan urunlerin sayisini getirme
select count(*) as [Stogu Olmayan Urun Sayisi] from products
where UnitsInStock = 0

--9--Stok adedi 20 ile 50 arasindaki urunleri getir ve UnitsInStock'a gore sirala
select * from products
where UnitsInStock > 20 and UnitsInStock <50
order by UnitsInStock asc
--9.1--Ya da farkli bir yol ile yapma
select * from products 
where UnitsInStock between 20 and 50
order by UnitsInStock asc

--10--Stok adedi en pahali urunu urun ismiyle getir 
select top 1 ProductName as [Urun Adi],UnitPrice as [En Pahali Urun] from products
order by UnitPrice desc
--10.1--Ya da farkli bir yol ile yapma	
select max(UnitPrice) as [En Pahali Urun] from products 
--10.2--Ya da farkli bir yol ile yapma
select ProductName as [Urun Adi],UnitPrice as [En Pahali Urun] from products
where UnitPrice = (select max(UnitPrice) from products)
order by UnitPrice desc

--11--Kac cesit urun var
select count(productname) from products

--12--En pahali urunun adini getirme
select top 1 ProductName as [Urun Adi] from products
order by UnitPrice desc
--12.1--Ya da farkli bir yol ile yapma
select ProductName as [Urun Adi] from products
where UnitPrice = (select max(UnitPrice) from products)

--13--100 Tl'den buyuk urunleri ProductName ve UnitPrice ile gosterme
select ProductName ,UnitPrice from products 
where UnitPrice > 100

--14--UnitsInStock degeri 15'in altinda olan urunlerin adi fiyati ve stok bilgileri
select productname as adi,
UnitPrice as Fiyati,
UnitsInStock as Stok
from products
where UnitsInStock < 15 
order by UnitPrice

--15--Ortalamanin altinda bir fiyata sahip urunlerin adi ve fiyatini getirme ve UnitPrice'a gore siralama
select productname,unitprice from products
where unitprice < (select avg(UnitPrice) from products)
order by UnitPrice

--16--Satisi yapilmayan urun listesi (Discontinued degeri ve UnitsInStock degeri sifir olmayan)
select * from Products
where Discontinued = 1 and UnitsInStock !=0

--17--50 Tl ile 100 Tl arasinda bulunan tum urunlerin adlari ve fiyatlarini getirme
select productname,unitprice 
from products 
where UnitPrice > 50 and unitprice < 100
--17.1--Ya da farkli bir yol ile
select productname,unitprice 
from products 
where unitprice between 50 and 100

--18--En pahali urunun stok bilgisini getirme
select top 1 UnitsInStock 
from products
order by unitprice desc

--19--UnitPrice degeri 30 dan buyuk olanlarin ProductName bilgilerini getir
select [ProductName] from Products
where [UnitPrice] > 30

--20--Stok bilgisi 0 olan degerlerin yerine 'Stokta yok' yaz ve ProductName, UnitPrice ve yeni UnitsInStock bilgilerini getir
select [ProductName] as [Urun Adi],
[UnitPrice] as Ucret,
case [UnitsInStock] when 0 then 'Stokta yok'
else convert(varchar,UnitsInStock) end as stok
from products

--21--Stok bilgisi 0 olan degerlerin yerine 'Stokta yok' yaz ve ProductName getir UnitPrice degerini 50 den yuksek al ve getir 
--ve yeni UnitsInStock bilgilerini getir
select [ProductName] as [Urun Adi],
[UnitPrice] as Ucret,
case [UnitsInStock] when 0 then 'Stokta yok'
else convert(varchar,UnitsInStock) end as Stok
from products
where [UnitPrice] > 50

--22--Urunlerin ucretlerini 'CategoryID'ye gore ortalamasini alma
select CategoryID,avg(UnitPrice) as ortalama from products
group by CategoryID
---------------------------------Orders---------------------------------
select * from orders 

--1--'ALFKI' CustomerID'sine sahip musterinin siparis sayisi nedir
select count(*) as [ALFKI Sayisi] from orders
where CustomerID = 'ALFKI'

--2--Kac farkli ulkeye siparis yapidiginin sayisini getirme
select count(distinct ShipCountry) as [Kac Farkli Ulkeye Siparis Yapildi] from orders

--3--Siparis tarihleri '1996-07-01' ile '1996-12-31' tarihleri arasindaki siparislerin OrderID,CustomerID ve OrderDate ini getirme
select OrderID,CustomerID,OrderDate from orders
where OrderDate between '1996-06-01' and '1996-12-31'
--3.1--Ya da farkli bir yol ile 
select OrderID,CustomerID,OrderDate from orders
where orderdate> '1996-07-01' and orderdate<'1996-12-31'

--4--Urunlerin OrderDate,RequiredDate bilgilerine 1 ay ekle ve ShippedDate bilgisine 10 gun ekle
select CustomerID,dateadd(month,1,OrderDate),dateadd(month,1,RequiredDate),dateadd(day,10,ShippedDate) from orders

--5--Urunlerin OrderDate tarihlerinin yilini ve RequiredDate tarihlerindeki gunu getirme
select CustomerID,datepart(year,OrderDate),datepart(day,RequiredDate) from orders
--5.1--Ya da farkli bir yol ile
select CustomerID,year(OrderDate),day(RequiredDate) from orders

--6--Urunleri shipname'ine gore Freight toplamini alip toplam degeri 300'den buyuk olanlari getir
select shipname,shipcity,sum(freight) as toplam from orders 
group by shipname ,shipcity
having sum(freight) > 300

--7--Calisanlarin kac adet urun sattiginin sayisini EmployeeID'si ile getir ve
--80'den fazla satana 'Yuksek' 80'den az satana 'Dusuk' yaz
select EmployeeID,count(*) as sayi , 
case 
	when count(*)>80 then 'Yuksek' 
	else 'Dusuk' end as tablo
from Orders
group by EmployeeID
order by sayi
---------------------------------Order Details---------------------------------
select * from [Order Details]

--1--Hangi siparis bana ne kadar kazandirmis (UnitPrice*Quantity*(1-Discount)
select OrderID,sum(UnitPrice*Quantity*(1-Discount)) as [Siparislerin Kazandirdiklari] from [Order Details]
group by OrderID

--2--Hangi urunlerden toplam kac adet alinmis
select productId,sum(quantity) as [Kac Adet] from [Order Details]
group by productId
order by [kac adet] desc

--3--1000 adetten fazla satilan urunler
select productId,sum(quantity) as [Kac Adet] from [Order Details]
group by productId
having sum(quantity) > 1000

---------------------------------Karisik Kullanim---------------------------------

--******************
--1--Her kategoriden kac tane urun var (products,categories)
select c.CategoryName,count(p.ProductID) as [Toplam Adet]from products p inner join categories c
on c.CategoryID=p.CategoryID
group by c.CategoryName

--2--Calisanlar ne kadarlik satis(unitprice*Quantity) yapmislar (orders,employees,[Order Details])
select e.firstname+' ' +e.lastname as [Calisan Adi Soyadi], 
sum(od.unitprice*od.Quantity) as [Toplam Satis]
from employees e inner join orders o 
on o.EmployeeID=e.EmployeeID
inner join [Order Details] od 
on o.OrderID=od.OrderID
group by e.firstname+' ' +e.lastname

--3--50'den fazla satisi olan calisanlari bulma (orders,employees)
select e.firstname+' ' +e.lastname  as [Calisan Adi Soyadi] ,count(o.OrderID) as [Satis Miktari]
from employees e inner join orders o 
on o.EmployeeID=e.EmployeeID 
group by e.firstname+' ' +e.lastname
having count(o.OrderID) > 50  

--4--Hangi musteri hic siparis vermemis(customers,alt fonksiyon orders)
select * from customers 
where customerId not in (select distinct CustomerId from orders)

--5--Hangi urun hangi kategoridedir (products,categories)
select p.ProductName,c.CategoryID,c.CategoryName from products p inner join categories c 
on p.CategoryID=c.CategoryID

--6--Hangi calisan hangi bolgeden sorumlu(Territories,EmployeeTerritories)
select firstname+lastname  as isim ,t.TerritoryDescription from Territories t inner join EmployeeTerritories et on t.TerritoryID = et.TerritoryID
inner join Employees e on e.EmployeeID=et.EmployeeID

--7--Hangi tedarikci hangi urunu sagliyor (Products,Suppliers)
select ProductName,CompanyName from Products p 
inner join Suppliers s on 
s.supplierId=p.SupplierID

--8--Beverages kategorisine ait urunlerin listesi (categories,products)
select * from products p inner join categories c on c.CategoryID=p.CategoryID
where CategoryName='Beverages'
--Birlestirmeden alt sinif ile
select * from products where categoryId=(select categoryId from categories where categoryname='Beverages')

--9--Urunlerin karsisina kategori getirme (categories,products)
select p.ProductName,c.CategoryName from products p inner join categories c on c.CategoryID=p.CategoryID
--Birlestirmeden alt sinif ile
select p.productname,(select c.categoryname from Categories c where c.CategoryID=p.CategoryID) as categoryname
from products p

--10--CategoryID'si 1 olan urunde kac urun oldugunu getirme (Products,Categories)
select c.CategoryID as id,c.CategoryName as names,COUNT(p.ProductName) adet from Products as p
join Categories as c on p.CategoryID = c.CategoryID
where c.CategoryID=1
group by c.CategoryName,c.CategoryID

--11--Hangi urunden toplam kac adet alindigini getirme ([Order Details],Products)
select p.ProductID,p.ProductName,sum(od.Quantity) from [Order Details] as od
join Products as p on p.ProductID=od.ProductID
group by p.ProductID,p.ProductName
order by p.ProductID,p.ProductName

--12--Hangi kategoride(CategoryName) toplam kac adet urun bulundugunu getirme (Categories,Products)
select c.CategoryID as category_Id, c.CategoryName as Category_Name, count(p.ProductName) as adet from Products as p
join Categories as c on c.CategoryID=p.CategoryID
group by c.CategoryID,c.CategoryName
order by category_Id

--13--1000 Adetten fazla satilan urunleri toplam satilan urunlere gore siralama (Products,[Order Details])
select distinct od.ProductID,p.ProductName ,sum(od.Quantity) as [Toplam Satilan Adet] from Products as p
join [Order Details] as od on od.ProductID=p.ProductID
group by od.ProductID,p.ProductName
having sum(od.Quantity)>1000
order by [Toplam Satilan Adet] asc

--14--Hangi urun hangi kategoride ve SupplierID'ye gore siralama (Products,Categories)
select p.ProductName [Urun Adi], c.CategoryName as [Kategori] from Products as p
join Categories as c on c.CategoryID=p.CategoryID
order by c.CategoryName asc

--15--Hangi tedarikci hangi urunu sagladigi bilgisini getirme (Products,Suppliers)
select s.SupplierID [Tedarikci Id], s.CompanyName [Tedarikci Firma], p.ProductName as [Tedarikcinin Sagladigi Urun] from Products as p
join Suppliers as s on s.SupplierID=p.SupplierID
order By s.SupplierID

--16--Hangi siparis hangi kargo sirketi ile ne zaman gonderildigi bilgisi (orders,Shippers)
select o.OrderID as SipariþNo ,s.CompanyName [Kargo Firmasi], convert(date,o.ShippedDate) as [Siparis Tarihi] from orders as o
join Shippers as s on s.ShipperID=o.ShipVia

--17--Hangi siparisi hangi musteri verirdiginin bilgisi (Customers,Orders)
select o.OrderID Sipariþ_ID, c.CompanyName as Musteri from Customers as c
join Orders as o on o.CustomerID=c.CustomerID
order by o.OrderID

--18--Hangi calisan, toplam kac siparis aldiginin bilgisi (Orders,Employees)
select CONCAT(e.FirstName,' ',e.LastName) as [Calisan Bilgileri], count(o.EmployeeID) [Toplam Alinan Siparis] from Orders as o
join Employees as e on e.EmployeeID=o.EmployeeID
group by  CONCAT(e.FirstName,' ',e.LastName),e.EmployeeID
order by e.EmployeeID

--19--En fazla siparisi alan calisani getirme (Orders,Employees)
select top 1 CONCAT(e.FirstName,' ',e.LastName) as [Calisan Bilgileri], count(o.EmployeeID) [Toplam Alinan Siparis] from Orders as o
join Employees as e on e.EmployeeID=o.EmployeeID
group by  CONCAT(e.FirstName,' ',e.LastName),e.EmployeeID
order by [Toplam Alinan Siparis] desc

--20--Hangi siparisi, hangi calisan, hangi musteri verdiginin bilgisi (Orders,Customers)
select o.OrderID [Siparis No],CONCAT(e.FirstName,' ',e.LastName) as [Calisan Bilgileri], c.CompanyName Musteri  from Orders as o
join Customers as c on c.CustomerID=o.CustomerID
join Employees as e on e.EmployeeID=o.EmployeeID
order by o.OrderID

--21--Hangi urun, hangi kategoride bulunmaktadir ve bu urunu kimin tedarik ettigi bilgisi
select p.ProductName as [Urun Adi], c.CategoryName [Urun Kategorisi], s.CompanyName Tedarikci from Products as p
join Categories as c on c.CategoryID=p.CategoryID
join Suppliers as s on s.SupplierID=p.SupplierID
order by p.ProductID

--22--Hangi siparisi hangi musteri vermis, hangi calisan almis, hangi tarihte, hangi kargo sirketi tarafindan gonderilmis hangi urunden kac adet alinmis
--hangi fiyattan alinmis, urun hangi kategorideymis bu urunu hangi tedarikci saglamis
select o.OrderID [Siparis ID],c.CompanyName [Musteri Bilgisi],concat(e.FirstName,' ',e.LastName) as [Siparisi Alan Calisan Bilgileri], 
cast(o.ShippedDate as date) [Siparis Tarihi], s.CompanyName [Kargo Firmass],p.ProductName as [Urun Adi],sum(od.Quantity) [Satilan Adet], od.UnitPrice as Fiyat, cat.CategoryName,
sup.CompanyName Tedarikci from Orders as o
join Customers as c on c.CustomerID=o.CustomerID
join Employees as e on e.EmployeeID=o.EmployeeID
join Shippers as s on s.ShipperID=o.ShipVia
join [Order Details] as od on od.OrderID=o.OrderID
join Products as p on p.ProductID=od.ProductID
join Suppliers as sup on sup.SupplierID = p.SupplierID
join Categories as cat on cat.CategoryID = p.CategoryID
group by o.OrderID, c.CompanyName, concat(e.FirstName,' ',e.LastName), cast(o.ShippedDate as date),s.CompanyName, p.ProductName, od.UnitPrice, cat.CategoryName,sup.CompanyName
order by [Siparis ID]

--23--Hangi calisan simdiye kadar toplam kac siparis aldiginin bilgisi
select CONCAT(FirstName, ' ',LastName) as [Calisan Adi Soyadi], count(o.EmployeeID) [Aldigi Siparis Sayisi] from Employees as e
join Orders as o on o.EmployeeID=e.EmployeeID
group by CONCAT(FirstName, ' ',LastName),e.EmployeeID
order by e.EmployeeID