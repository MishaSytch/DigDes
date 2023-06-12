-- 6
-- �������� �������� ��������� � ����� ����������� � �������������� ������� ������
-- ������� ��������� - ��� ���� (from, to)
-- �������� �������� - ���-�� ��������� �������
-- �������������� ����� �������� ������ ���� �������� ������-�����������, ���������� � �������� (from, to)
create procedure FreeMen (
	@from date, 
	@to date
) 
as
begin
	declare @size int = (
		select count(*)
		from AdventureWorks2017.HumanResources.Employee a
		join AdventureWorks2017.HumanResources.vEmployee b
		on a.BusinessEntityID = b.BusinessEntityID
		where BirthDate between @from and @to and Gender = 'M' and MaritalStatus = 'S'
	)
	select *
		from AdventureWorks2017.HumanResources.Employee a
		join AdventureWorks2017.HumanResources.vEmployee b
		on a.BusinessEntityID = b.BusinessEntityID
		where BirthDate between @from and @to and Gender = 'M' and MaritalStatus = 'S'
	select @size '���-�� ������'
end;


-- ��������
exec FreeMen '1945', '1978-02-24';
drop procedure FreeMen


-- 1
-- ������� ����� ����� ������ � ��������� �� ����� � �������, �� ��� ����� ������ ��������
select Sum(UnitPrice) as "sum", YEAR(ModifiedDate) as "year", MONTH(ModifiedDate) as "month"
from AdventureWorks2017.Sales.SalesOrderDetail
group by YEAR(ModifiedDate), MONTH(ModifiedDate)
order by YEAR(ModifiedDate), MONTH(ModifiedDate);



-- 2
-- ������� 10 ����� ������������ ������� ��� ���������� �������� 
-- �������: ����� | ��������� (���-�� ����������� � ������)
-- � ������ �� ������ ���� ��������	
select top(10) City �����, count(City) ���������
from (
	select b.City
	from AdventureWorks2017.Sales.vStoreWithAddresses a
	right join (
		select b.BusinessEntityID, City
		from AdventureWorks2017.Person.Address a
		join AdventureWorks2017.Person.BusinessEntityAddress b
		on a.AddressID = b.BusinessEntityID
	) b
	on a.BusinessEntityID = b.BusinessEntityID
	where a.BusinessEntityID is Null and b.City not in (select City from AdventureWorks2017.Sales.vStoreWithAddresses)
) a
group by City
order by count(*) desc




-- 3
--������� �����������, �������� ������ 15 ������ ������ � ���� �� �������� �� ��� ����� ������ ��������
--�������: ������� ���������� | ��� ���������� | �������� �������� | ���-�� ��������� ����
--����������� �� ���-�� �� �� ��������, ����� �� �� ��� � �� �����������
select LastName '������� ����������', FirstName '��� ����������', Name '�������� ��������', OrderQty '���-�� ��������� ����'
from (
	select LastName , FirstName, Name, sum(OrderQty) as OrderQty
	from ( --�������, ���-��, �������� ��������
		select ProductID, OrderQty, Name
		from ( --�������� ��������
			select PurchaseOrderID, a.ProductID, OrderQty, Name
			from AdventureWorks2017.Purchasing.PurchaseOrderDetail a
			join AdventureWorks2017.Production.Product b
			on a.ProductID = b.ProductID
		) a
		join AdventureWorks2017.Purchasing.PurchaseOrderHeader b
		on a.PurchaseOrderID = b.PurchaseOrderID
	) a
	join ( -- ��� ����������
		select * 
		from AdventureWorks2017.Person.Person b
	) b
	on a.ProductID = b.BusinessEntityID
	group by LastName, FirstName, Name
) a
where OrderQty >= 15
order by OrderQty desc, concat(LastName, ' ', FirstName) asc;




--4
--������� ���������� ������� ������ ������� �������
--�������: ���� ������ | ������� ���������� | ��� ���������� | ���������� ������ |
--����������� �� ���� ������ �� ����� � ������
--� ������ ����������� ������ ����� ���������� ��� �������� ������ ����������� � �������� �������:
--<��� ������> ���-��: <���-�� � ������> ��
select OrderDate '���� ������', LastName '������� ����������', FirstName '��� ����������' , info '���������� ������'
from (
	select OrderDate, LastName, FirstName, string_agg(concat(Name, ' qty of: ',OrderQty, ' pieces'), ', ') info
	from 
	(
		select OrderDate, a.PurchaseOrderID, Name, ShipMethodID, OrderQty
		from
		(
			select OrderDate, a.PurchaseOrderID, ProductID, ShipMethodID, OrderQty
			from AdventureWorks2017.Purchasing.PurchaseOrderHeader a
			join AdventureWorks2017.Purchasing.PurchaseOrderDetail b
			on a.PurchaseOrderID = b.PurchaseOrderID
		) a
		join AdventureWorks2017.Production.Product b
		on a.ProductID = b.ProductID
	) a
	join AdventureWorks2017.Person.Person b
	on a.PurchaseOrderID = b.BusinessEntityID
	group by OrderDate, LastName, FirstName
) a
where OrderDate = (
	select min(OrderDate)
	from (
		select OrderDate, LastName L, FirstName F, string_agg(concat(Name, ' qty of: ',OrderQty, ' pieces'), ', ') info
		from 
		(
			select OrderDate, a.PurchaseOrderID, Name, ShipMethodID, OrderQty
			from
			(
				select OrderDate, a.PurchaseOrderID, ProductID, ShipMethodID, OrderQty
				from AdventureWorks2017.Purchasing.PurchaseOrderHeader a
				join AdventureWorks2017.Purchasing.PurchaseOrderDetail b
				on a.PurchaseOrderID = b.PurchaseOrderID
			) a
			join AdventureWorks2017.Production.Product b
			on a.ProductID = b.ProductID
		) a
		join AdventureWorks2017.Person.Person b
		on a.PurchaseOrderID = b.BusinessEntityID
		group by OrderDate, LastName, FirstName
	) a
	where a.L = LastName and a.F = FirstName 	
)
order by OrderDate desc;




-- 5
-- ������� ������ �����������, ���������������� ������������ ������� ������ ���������� � ������ �������� � ��������
-- �������: ��� ������������ | ���� ������ ������������ �� ������ | ���� �������� ������������ | ��� ���������� | ���� ������ ���������� �� ������ | ���� �������� ����������
-- ��� - ������� �.�.
-- ����������� �� �������� �� ��������� ���� � ������� �����������
-- ������ ������ ������ �������� ����������� �� ������� ������������, ����� �� ������� ���������� 
-- (�����)

-- �������� ������� �� ����� �����������
select LastName, FirstName, MiddleName, HireDate, BirthDate, OrganizationLevel, DepartmentID, a.BusinessEntityID, PersonType
into #src
from (
	select a.BusinessEntityID, BirthDate, HireDate, PersonType, LastName, FirstName, MiddleName, OrganizationLevel
	from AdventureWorks2017.HumanResources.Employee a
	join AdventureWorks2017.Person.Person b
	on a.BusinessEntityID = b.BusinessEntityID
) a
join AdventureWorks2017.HumanResources.EmployeeDepartmentHistory b
on a.BusinessEntityID = b.BusinessEntityID;


-- ������� �� ����������
-- ����
select LastName, FirstName, MiddleName, HireDate, BirthDate, OrganizationLevel, DepartmentID
into #firstT
from #src
where OrganizationLevel = 1;
-- ����
select LastName, FirstName, MiddleName, HireDate, BirthDate, OrganizationLevel, DepartmentID
into #secondT
from #src
where OrganizationLevel = 2;
-- ����
select LastName, FirstName, MiddleName, HireDate, BirthDate, OrganizationLevel, DepartmentID
into #thirdT
from #src
where OrganizationLevel = 3;
-- ������� ��������
select LastName, FirstName, MiddleName, HireDate, BirthDate, OrganizationLevel, DepartmentID
into #fourthT
from #src
where OrganizationLevel = 4;

-- ��� ������...
select CONCAT(LastName_1, ' ', SUBSTRING(FirstName_1, 1, 1), '.', SUBSTRING(MiddleName_1, 1, 1), '.') '��� ��������� ������ ��������', HireDate_1 '���� ������ �� ������', BirthDate_1 '���� ��������',
CONCAT(LastName_2, ' ', SUBSTRING(FirstName_2, 1, 1), '.', SUBSTRING(MiddleName_2, 1, 1), '.') '��� ��������� ������ ��������', HireDate_2 '���� ������ �� ������', BirthDate_2 '���� ��������',
CONCAT(LastName_3, ' ', SUBSTRING(FirstName_3, 1, 1), '.', SUBSTRING(MiddleName_3, 1, 1), '.') '��� ��������� ������ ��������', HireDate_3 '���� ������ �� ������', BirthDate_3 '���� ��������',
CONCAT(LastName_4, ' ', SUBSTRING(FirstName_4, 1, 1), '.', SUBSTRING(MiddleName_4, 1, 1), '.') '��� ��������� ��������� ��������', HireDate_4 '���� ������ �� ������', BirthDate_4 '���� ��������'
from (
	select LastName_1, FirstName_1, MiddleName_1, HireDate_1, BirthDate_1,
			LastName_2, FirstName_2, MiddleName_2, HireDate_2, BirthDate_2,
			LastName_3, FirstName_3, MiddleName_3, HireDate_3, BirthDate_3, 
			LastName_4, FirstName_4, MiddleName_4, HireDate_4, BirthDate_4
	from (
		select LastName_1, FirstName_1, MiddleName_1, HireDate_1, BirthDate_1, OrganizationLevel_1, DepartmentID_1, 
				LastName_2, FirstName_2, MiddleName_2, HireDate_2, BirthDate_2, OrganizationLevel_2, DepartmentID_2,
				LastName_3, FirstName_3, MiddleName_3, HireDate_3, BirthDate_3, OrganizationLevel_3, DepartmentID_3, 
				#fourthT.LastName LastName_4, #fourthT.FirstName FirstName_4, #fourthT.MiddleName MiddleName_4, #fourthT.HireDate HireDate_4, #fourthT.BirthDate BirthDate_4, #fourthT.OrganizationLevel OrganizationLevel_4, #fourthT.DepartmentID DepartmentID_4
		from (
			select LastName_1, FirstName_1, MiddleName_1, HireDate_1, BirthDate_1, OrganizationLevel_1, DepartmentID_1, 
			LastName_2, FirstName_2, MiddleName_2, HireDate_2, BirthDate_2, OrganizationLevel_2, DepartmentID_2, 
			#thirdT.LastName LastName_3, #thirdT.FirstName FirstName_3, #thirdT.MiddleName MiddleName_3, #thirdT.HireDate HireDate_3, #thirdT.BirthDate BirthDate_3, #thirdT.OrganizationLevel OrganizationLevel_3, #thirdT.DepartmentID DepartmentID_3
			from (
				select #firstT.LastName LastName_1, #firstT.FirstName FirstName_1, #firstT.MiddleName MiddleName_1, #firstT.HireDate HireDate_1, #firstT.BirthDate BirthDate_1, #firstT.OrganizationLevel OrganizationLevel_1, #firstT.DepartmentID DepartmentID_1, 
						#secondT.LastName LastName_2, #secondT.FirstName FirstName_2, #secondT.MiddleName MiddleName_2, #secondT.HireDate HireDate_2, #secondT.BirthDate BirthDate_2, #secondT.OrganizationLevel OrganizationLevel_2, #secondT.DepartmentID DepartmentID_2
				from #firstT
				join #secondT
				on #firstT.DepartmentID = #secondT.DepartmentID
			) a
			join #thirdT
			on a.DepartmentID_1 = #thirdT.DepartmentID
		) a
		full join #fourthT
		on a.DepartmentID_1 = #fourthT.DepartmentID
	) a
	where BirthDate_1 > BirthDate_2 and HireDate_1 > HireDate_2 or
			BirthDate_2 > BirthDate_3 and HireDate_2 > HireDate_3 or
			BirthDate_3 > BirthDate_4 and HireDate_3 > HireDate_4
) a
order by LastName_1, LastName_2, LastName_3, LastName_4;

--����������� �����!!!
drop table #src, #firstT, #secondT, #thirdT, #fourthT;