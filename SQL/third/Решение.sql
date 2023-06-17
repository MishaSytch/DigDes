
-- Нужно ускорить запросы ниже любыми способами
-- Можно менять текст самого запроса или добавилять новые индексы
-- Схему БД менять нельзя
-- В овете пришлите итоговый запрос и все что было создано для его ускорения

-- Задача 1
create index id_WebLog_SessionStart on Marketing.WebLog (SessionStart, ServerID) include(SessionID, UserName);

DECLARE @StartTime datetime2 = '2010-08-30 16:27';
SELECT TOP(5000) wl.SessionID, wl.ServerID, wl.UserName 
FROM Marketing.WebLog AS wl
WHERE wl.SessionStart >= @StartTime
ORDER BY wl.SessionStart, wl.ServerID;
GO



-- Задача 2
create index id_PostalCode_StateCode on Marketing.PostalCode (StateCode, PostalCode) include(Country);

SELECT PostalCode, Country
FROM Marketing.PostalCode 
WHERE StateCode = 'KY'
ORDER BY StateCode, PostalCode;
GO



-- Задача 3

-- первый вариант, работает быстрее второго
create index id_Prospect_LastName_FirstName on Marketing.Prospect (LastName, FirstName) include(ProspectID, MiddleName, CellPhoneNUmber, HomePhoneNumber, WorkPhoneNumber, Demographics, LatestContact, EmailAddress);
create index id_Salesperson_LastName_FirstName on Marketing.Salesperson (LastName, FirstName);

DECLARE @Counter INT = 0;
WHILE @Counter < 350
BEGIN
  SELECT p.LastName, p.FirstName 
  FROM Marketing.Prospect AS p
  INNER JOIN Marketing.Salesperson AS sp
  ON p.LastName = sp.LastName
  ORDER BY p.LastName, p.FirstName;
  
  SELECT * 
  FROM Marketing.Prospect AS p
  WHERE p.LastName = 'Smith';
  SET @Counter += 1;
END;


--удаление
drop index id_Prospect_LastName_FirstName on Marketing.Prospect;
drop index id_Salesperson_LastName_FirstName on Marketing.Salesperson;


-- второй вариант, проще, но работет медленее (у меня на 0,013 с)
create index id_Prospect_LastName_FirstName on Marketing.Prospect (LastName) include(FirstName);
create index id_Salesperson_LastName_FirstName on Marketing.Salesperson (LastName);

DECLARE @Counter INT = 0;
WHILE @Counter < 350
BEGIN
  SELECT p.LastName, p.FirstName 
  FROM Marketing.Prospect AS p
  INNER JOIN Marketing.Salesperson AS sp
  ON p.LastName = sp.LastName
  ORDER BY p.LastName, p.FirstName;
  
  SELECT * 
  FROM Marketing.Prospect AS p
  WHERE p.LastName = 'Smith';
  SET @Counter += 1;
END;


-- Задача 4
create index id_ProductModel on Marketing.ProductModel (ProductModelID) include(ProductModel);
create index id_Product on Marketing.Product (ProductModelID, SubcategoryID) include(ProductID);
create index id_Subcategory on Marketing.Subcategory (SubcategoryID, CategoryID) include(SubcategoryName);
create index id_Category on Marketing.Category (CategoryID) include(CategoryName);


SELECT
	c.CategoryName,
	sc.SubcategoryName,
	pm.ProductModel,
	COUNT(p.ProductID) AS ModelCount
FROM Marketing.ProductModel pm
	JOIN Marketing.Product p
		ON p.ProductModelID = pm.ProductModelID
	JOIN Marketing.Subcategory sc
		ON sc.SubcategoryID = p.SubcategoryID
	JOIN Marketing.Category c
		ON c.CategoryID = sc.CategoryID
GROUP BY c.CategoryName,
	sc.SubcategoryName,
	pm.ProductModel
HAVING COUNT(p.ProductID) > 1



-- удаление:
drop index id_ProductModel on Marketing.ProductModel;
drop index id_Product on Marketing.Product;
drop index id_Subcategory on Marketing.Subcategory;
drop index id_Category on Marketing.Category;