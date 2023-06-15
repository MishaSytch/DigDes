-- 7 +
-- Написать хранимую процедуру с тремя параметрами и результирующим набором данных
-- входные параметры - две даты (from, to)
-- выходной параметр - кол-во найденных запесей
-- Результирующий набор содержии записи всех холостых мужчин-сотрудников, родившихся в диапозон (from, to)
create procedure FreeMen (
	@from date, 
	@to date,
	@size int output
) 
as
begin
	select a.BusinessEntityID, NationalIDNumber, LoginID, OrganizationLevel, OrganizationNode, a.JobTitle, BirthDate, HireDate, LastName, FirstName, MiddleName
	into src
	from AdventureWorks2017.HumanResources.Employee a
	join AdventureWorks2017.HumanResources.vEmployee b
	on a.BusinessEntityID = b.BusinessEntityID
	where BirthDate between @from and @to and Gender = 'M' and MaritalStatus = 'S'

	select *
	from src
	select @size = (select count(*) from src)
	drop table src
end;


-- Проверка
declare @size int
exec FreeMen '1945', '1978-02-24', @size output;
select @size 'Кол-во мужчин'

drop procedure FreeMen



-- 2 +-
-- Вывести общую сумму продаж с разбивкой по годам и месяцам, за все время работы компании
select YEAR(ModifiedDate) as "year", MONTH(ModifiedDate) as "month", Sum(TotalDue) as "sum" -- полная сумма, полученная от продаж
from AdventureWorks2017.Sales.SalesOrderHeader
group by YEAR(ModifiedDate), MONTH(ModifiedDate)
order by YEAR(ModifiedDate), MONTH(ModifiedDate);

select YEAR(ModifiedDate) as "year", MONTH(ModifiedDate) as "month", Sum(UnitPrice * OrderQty) as "sum" -- цена * количество, т.е. сумма с продаж (как себестоимость)
from AdventureWorks2017.Sales.SalesOrderDetail
group by YEAR(ModifiedDate), MONTH(ModifiedDate)
order by YEAR(ModifiedDate), MONTH(ModifiedDate);

-- 3 +
-- Выбрать 10 самых приоритетных городов для следующего магазина 
-- Столбцы: Город | Приоритет (кол-во покупателей в городе)
-- В городе не должно быть магазина	
select top(10) City Город, count(City) Приоритет
from (
	select b.City
	from AdventureWorks2017.Sales.vStoreWithAddresses a
	right join (
		select  b.BusinessEntityID, City
		from (
			select b.BusinessEntityID, City
			from AdventureWorks2017.Person.Address a
			join AdventureWorks2017.Person.BusinessEntityAddress b
			on a.AddressID = b.AddressID
		) a
		join AdventureWorks2017.Person.Person b
		on a.BusinessEntityID = b.BusinessEntityID
		where PersonType <> 'EM'
	) b
	on a.BusinessEntityID = b.BusinessEntityID
	where a.BusinessEntityID is Null and b.City not in (select City from AdventureWorks2017.Sales.vStoreWithAddresses)
) a
group by City
order by count(*) desc

-- 4 +
--Выбрать покупателей, купивших больше 15 единиц одного и того же продукта за все время работы компании
--Столбцы: Фамилия покупателя | Имя покупателя | Название продукта | Кол-во купленных штук
--Упорядочить по кол-ву шт по убыванию, затем по ФИ без О по возрастанию
select LastName 'Фамилия покупателя', FirstName 'Имя покупателя', Name 'Название продукта', sum(OrderQty) 'Кол-во купленных штук'
from (
	select OrderQty, a.ProductID, LastName, FirstName, Name, BusinessEntityID
	from (
		select OrderQty, a.ProductID, LastName, FirstName, BusinessEntityID
		from (
			select OrderQty, a.CustomerID, PersonID, ProductID
			from (
				select OrderQty, b.CustomerID, ProductID
				from AdventureWorks2017.Sales.SalesOrderDetail a
				join AdventureWorks2017.Sales.SalesOrderHeader b
				on a.SalesOrderID= b.SalesOrderID
			) a
			join AdventureWorks2017.Sales.Customer b
			on a.CustomerID = b.CustomerID
		) a
		join AdventureWorks2017.Person.Person b
		on a.PersonID = b.BusinessEntityID
	) a
	join AdventureWorks2017.Production.Product b
	on a.ProductID = b.ProductID
) a
group by BusinessEntityID, LastName, FirstName, Name
having sum(OrderQty) > 15
order by sum(OrderQty) desc, concat(LastName, ' ', FirstName) asc;


--5 +
--Вывести содержимое первого заказа каждого клиента
--Столбцы: Дата заказа | Фамилия покупателя | Имя покупателя | Содержимое заказа |
--Упорядочить по дате заказа от новых к старым
--В ячейку содержимого заказа нужно объединить все элементы заказа покупателся в следущем формате:
--<Имя товара> кол-во: <кол-во в заказе> шт
select min(OrderDate) 'Дата заказа', LastName 'Фамилия покупателя', FirstName 'Имя покупателя' , string_agg(concat(Name, ' ', 'qty of: ', OrderQty, ' pieces'), ', ')  'Содержимое заказа'
from (
	select LastName, FirstName, CustomerID, ProductID, OrderDate, OrderQty
	from (
		select LastName, FirstName, SalesOrderID, a.CustomerID, OrderDate
		from (
			select LastName, FirstName, CustomerID
			from (
				select a.BusinessEntityID, LastName, FirstName
				from AdventureWorks2017.Sales.vIndividualCustomer a
				join AdventureWorks2017.Person.BusinessEntity b
				on a.BusinessEntityID = b.BusinessEntityID
			) a
			join AdventureWorks2017.Sales.Customer b
			on a.BusinessEntityID = b.PersonID
		) a
		join AdventureWorks2017.Sales.SalesOrderHeader b
		on a.CustomerID= b.CustomerID
	) a
	join AdventureWorks2017.Sales.SalesOrderDetail b
	on a.SalesOrderID = b.SalesOrderID
) a
join AdventureWorks2017.Production.Product b
on a.ProductID = b.ProductID
group by LastName, FirstName, CustomerID
having min(OrderDate) = (
    select min(OrderDate)
    from AdventureWorks2017.Sales.SalesOrderHeader
    where CustomerID = a.CustomerID
)
order by min(OrderDate) desc;






-- 6 +
-- Вывести список сотрудников, непосредственный руководитель которых младше сотрудника и меньше работает в компании
-- Столбцы: Имя руководителя | Дата приема руководителя на работу | Дата рождения руководителя | Имя сотрудника | Дата приема сотрудника на работу | День рождения сотрудника
-- Имя - Фамилия И.О.
-- Упорядочить по иерархии от директора вниз к рядовым сотрудникам
-- Внутри одного уровня иерархии упорядочить по фамилии руководителя, затем по фамилии сотрудника 
-- (жесть)

select FirstName, LastName, MiddleName, HireDate, BirthDate, a.BusinessEntityID, OrganizationNode, OrganizationLevel
into #Tree
from AdventureWorks2017.HumanResources.Employee a
join AdventureWorks2017.HumanResources.vEmployee b
on a.BusinessEntityID = b.BusinessEntityID

select concat(a.LastName,' ', substring(a.FirstName, 1, 1),'.', substring(a.MiddleName, 1, 1)) as 'Руководство', a.HireDate 'День принятия на работу', a.BirthDate 'День рождяния', concat(b.LastName,' ', substring(b.FirstName, 1, 1),'.',SUBSTRING(b.MiddleName, 1, 1)) as 'Подчиненный', b.HireDate 'День принятия на работу', b.BirthDate 'День рождяния'
from #Tree a
join #Tree b 
on a.OrganizationNode.GetAncestor(1) = b.OrganizationNode -- соединяем по предкам
where a.BirthDate > b.BirthDate and a.HireDate > b.HireDate
order by a.OrganizationLevel desc, a.LastName asc, b.LastName asc;


--уничтожение всего!!!
drop table #Tree;