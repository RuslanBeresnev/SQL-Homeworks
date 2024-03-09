-- Реализация базы данных по предметной области "Молокозавод"

CREATE DATABASE Dairy_Plant;
GO
USE Dairy_Plant;

---------------------------------------------------------------
-- Создание таблиц и PK 
---------------------------------------------------------------

-- Таблица для поставщика какого-то одного вида сырья
CREATE TABLE Provider(
    Provider_ID INTEGER NOT NULL,
    Name VARCHAR(30) NOT NULL,
    Region VARCHAR(30),
    Address VARCHAR(50) NOT NULL,
	Phone VARCHAR(15) NOT NULL,
	Raw_ID INTEGER NOT NULL,
CONSTRAINT Provider_PK PRIMARY KEY (Provider_ID)
)
;

-- Таблица для клиента (магазин), который продаёт один вид продукции
CREATE TABLE Client(
    Client_ID INTEGER NOT NULL,
    Name VARCHAR(30) NOT NULL,
    Address VARCHAR(50) NOT NULL,
	Phone VARCHAR(15) NOT NULL,
	Product_ID INTEGER NOT NULL,
CONSTRAINT Client_PK PRIMARY KEY (Client_ID)
)
;

-- Таблица для сырья одного конкретного типа
CREATE TABLE Raw(
    Raw_ID INTEGER NOT NULL,
    Type VARCHAR(20) NOT NULL,
    Amount_In_Storage INTEGER DEFAULT 0 NOT NULL,
	Cost_Per_Unit INTEGER NOT NULL,
CONSTRAINT Raw_PK PRIMARY KEY (Raw_ID),
CONSTRAINT Amount_In_Storage CHECK (Amount_In_Storage >= 0),
CONSTRAINT Cost_Per_Unit CHECK (Cost_Per_Unit >= 0)
)
;

-- Таблица для возможных типов производимой заводом продукции
CREATE TABLE Product_Type(
    Type_ID INTEGER NOT NULL,
    Name VARCHAR(30) NOT NULL,
CONSTRAINT Type_PK PRIMARY KEY (Type_ID)
)
;

-- Таблица для конкретного продукта (разные вариации продуктов одного типа, например)
CREATE TABLE Product(
    Product_ID INTEGER NOT NULL,
    Type_ID INTEGER NOT NULL,
    Name VARCHAR(30) NOT NULL,
    Packing_Type VARCHAR(20),
    Packing_Color VARCHAR(20),
	Selling_Price INTEGER NOT NULL,
	Amount_Of_Remained INTEGER DEFAULT 0 NOT NULL,
	Additional_Information VARCHAR(50),
CONSTRAINT Product_PK PRIMARY KEY (Product_ID),
CONSTRAINT Selling_Price CHECK (Selling_Price >= 0),
CONSTRAINT Amount_Of_Remained CHECK (Amount_Of_Remained >= 0)
)
;

-- Таблица для клиентских заказов на определёную произведённую продукцию
CREATE TABLE Order_For_Product(
    Order_ID INTEGER NOT NULL,
    Product_ID INTEGER NOT NULL,
    Amount INTEGER NOT NULL,
    Client_ID INTEGER NOT NULL,
	Data VARCHAR(100),
	Is_Done INTEGER DEFAULT 0 NOT NULL,
CONSTRAINT Order_PK PRIMARY KEY (Order_ID),
CONSTRAINT Amount CHECK (Amount >= 0),
CONSTRAINT Is_Done CHECK (IS_Done IN (0, 1))
)
;

CREATE TABLE Raw_Product(
    Raw_ID INTEGER NOT NULL,
    Product_ID INTEGER NOT NULL,
    Raw_Amount INTEGER NOT NULL,
CONSTRAINT Raw_Amount CHECK (Raw_Amount >= 0),
)
;

---------------------------------------------------------------
-- Создание FK 
---------------------------------------------------------------

ALTER TABLE Provider ADD CONSTRAINT FK_Provider_Raw 
    FOREIGN KEY (Raw_ID)
    REFERENCES Raw(Raw_ID)
;
ALTER TABLE Client ADD CONSTRAINT FK_Client_Product
    FOREIGN KEY (Product_ID)
    REFERENCES Product(Product_ID)
;
ALTER TABLE Product ADD CONSTRAINT FK_Product_Product_Type
    FOREIGN KEY (Type_ID)
    REFERENCES Product_Type(Type_ID)
;
ALTER TABLE Order_For_Product ADD CONSTRAINT Order_For_Product_Product
    FOREIGN KEY (Product_ID)
    REFERENCES Product(Product_ID)
;
ALTER TABLE Order_For_Product ADD CONSTRAINT Order_For_Product_Client
    FOREIGN KEY (Client_ID)
    REFERENCES Client(Client_ID)
;
ALTER TABLE Raw_Product ADD CONSTRAINT Raw_Product_Raw
    FOREIGN KEY (Raw_ID)
    REFERENCES Raw(Raw_ID)
;
ALTER TABLE Raw_Product ADD CONSTRAINT Raw_Product_Product
    FOREIGN KEY (Product_ID)
    REFERENCES Product(Product_ID)
;

---------------------------------------------------------------
-- Создание индексов для некоторых важных полей таблиц
---------------------------------------------------------------

CREATE INDEX Index_Provider_Name ON Provider(Name);
CREATE INDEX Index_Provider_Region ON Provider(Region);
CREATE INDEX Index_Client_Name ON Client(Name);
CREATE INDEX Index_Raw_Type ON Raw(Type);
CREATE INDEX Index_Product_Type_Name ON Product_Type(Name);
CREATE INDEX Index_Product_Name On Product(Name);

---------------------------------------------------------------
-- Заполнение таблиц тестовыми данными
---------------------------------------------------------------

INSERT INTO Product_Type(Type_ID, Name) VALUES (1, 'Kefir');
INSERT INTO Product_Type(Type_ID, Name) VALUES (2, 'Yoghurt');
INSERT INTO Product_Type(Type_ID, Name) VALUES (3, 'Curd');
INSERT INTO Product_Type(Type_ID, Name) VALUES (4, 'Cheese');
INSERT INTO Product_Type(Type_ID, Name) VALUES (5, 'Butter');
INSERT INTO Product_Type(Type_ID, Name) VALUES (6, 'Ice Cream');

INSERT INTO Product(Product_ID, Type_ID, Name, Packing_Type, Packing_Color, Selling_Price, Amount_Of_Remained, Additional_Information) VALUES (1, 1, 'Kefir "Svezheye segondnya"', 'Carton box', 'Blue', 75, 19, 'Kefir with extended shelf life');
INSERT INTO Product(Product_ID, Type_ID, Name, Packing_Type, Packing_Color, Selling_Price, Amount_Of_Remained, Additional_Information) VALUES (2, 2, 'Yoghurt "Mepica"', 'Glass bottle', 'Transparent', 48, 100, 'Yoghurt with fruit pieces');
INSERT INTO Product(Product_ID, Type_ID, Name, Packing_Type, Packing_Color, Selling_Price, Amount_Of_Remained, Additional_Information) VALUES (3, 3, 'Curd "Krasnoye selo"', 'Paper bag', 'Green', 110, 120, 'Skim curd');
INSERT INTO Product(Product_ID, Type_ID, Name, Packing_Type, Packing_Color, Selling_Price, Amount_Of_Remained) VALUES (4, 4, 'Cheese "Ranabeyevo"', 'Paper bag', 'Brown', 150, 200);
INSERT INTO Product(Product_ID, Type_ID, Name, Packing_Type, Packing_Color, Selling_Price, Amount_Of_Remained) VALUES (5, 5, 'Butter "Butter Station"', 'Paper bag', 'Yellow', 80, 250);
INSERT INTO Product(Product_ID, Type_ID, Name, Packing_Type, Packing_Color, Selling_Price, Amount_Of_Remained) VALUES (6, 6, 'Ice cream "Zelenodolsk kholod"', 'Carton box', 'White', 105, 100);

INSERT INTO Raw(Raw_ID, Type, Amount_In_Storage, Cost_Per_Unit) VALUES (1, 'Milk', 100, 90);
INSERT INTO Raw(Raw_ID, Type, Amount_In_Storage, Cost_Per_Unit) VALUES (2, 'Carton boxes', 2000, 10);
INSERT INTO Raw(Raw_ID, Type, Amount_In_Storage, Cost_Per_Unit) VALUES (3, 'Glass Bottles', 590, 30);
INSERT INTO Raw(Raw_ID, Type, Amount_In_Storage, Cost_Per_Unit) VALUES (4, 'Paper Bag', 5000, 10);
INSERT INTO Raw(Raw_ID, Type, Amount_In_Storage, Cost_Per_Unit) VALUES (5, 'Cream', 250, 150);

INSERT INTO Provider(Provider_ID, Name, Region, Address, Phone, Raw_ID) VALUES (1, 'Milk and Co.', 'Zelenodolsky district', 'Ul. Gvardii, 1-10', '111-110', 1);
INSERT INTO Provider(Provider_ID, Name, Region, Address, Phone, Raw_ID) VALUES (2, 'Best Boxes', 'Zelenodolsky district', 'Ul. Pridorozhnaya, 14-56', '+79378998910', 2);
INSERT INTO Provider(Provider_ID, Name, Region, Address, Phone, Raw_ID) VALUES (3, 'Shiny Glass Company', 'Ulyanovsk district', 'Ul. Podgornaya, 1-3', '256-256', 3);
INSERT INTO Provider(Provider_ID, Name, Region, Address, Phone, Raw_ID) VALUES (4, 'New Village', 'Ulyanovsk district', 'Ul. Vosstaniya, 100-89', '+79836457814', 4);
INSERT INTO Provider(Provider_ID, Name, Region, Address, Phone, Raw_ID) VALUES (5, 'Best Country', 'Smolensk region', 'Ul. Nagornaya, 10-9', '+77634567489', 4);

INSERT INTO Raw_Product(Raw_ID, Product_ID, Raw_Amount) VALUES (1, 1, 1);
INSERT INTO Raw_Product(Raw_ID, Product_ID, Raw_Amount) VALUES (2, 1, 1);
INSERT INTO Raw_Product(Raw_ID, Product_ID, Raw_Amount) VALUES (5, 1, 1);
INSERT INTO Raw_Product(Raw_ID, Product_ID, Raw_Amount) VALUES (1, 3, 1);
INSERT INTO Raw_Product(Raw_ID, Product_ID, Raw_Amount) VALUES (4, 3, 1);
INSERT INTO Raw_Product(Raw_ID, Product_ID, Raw_Amount) VALUES (5, 3, 1);

INSERT INTO Client(Client_ID, Name, Address, Phone, Product_ID) VALUES (1, 'Svezheye segondnya', '14 prospect VO, 1-10', '+79878735467', 1);
INSERT INTO Client(Client_ID, Name, Address, Phone, Product_ID) VALUES (2, 'Mepica', 'Ul. Nikolaevskaya 8-10', '+79879035467', 2);
INSERT INTO Client(Client_ID, Name, Address, Phone, Product_ID) VALUES (3, 'Krasnoye selo', 'Ul. Zarechnaya 9-11', '+79768374678', 3);
INSERT INTO Client(Client_ID, Name, Address, Phone, Product_ID) VALUES (4, 'Ranabeyevo', 'Ul. Zarechnaya 101-1', '+79898374678', 4);
INSERT INTO Client(Client_ID, Name, Address, Phone, Product_ID) VALUES (5, 'Butter Station', 'Ul. Mostovaya 91-3', '+79454563456', 5);
INSERT INTO Client(Client_ID, Name, Address, Phone, Product_ID) VALUES (6, 'Zelenodolsk kholod', 'Ul. Moldovskaya 3-46', '+79274563456', 6);

INSERT INTO Order_For_Product(Order_ID, Product_ID, Amount, Client_ID, Data, Is_Done) VALUES (1, 1, 2500, 1, 'Very big order', 1);
INSERT INTO Order_For_Product(Order_ID, Product_ID, Amount, Client_ID, Is_Done) VALUES (2, 6, 100, 6, 0);
INSERT INTO Order_For_Product(Order_ID, Product_ID, Amount, Client_ID, Data, Is_Done) VALUES (3, 3, 10, 3, 'Small order for newly opened store', 1);
INSERT INTO Order_For_Product(Order_ID, Product_ID, Amount, Client_ID, Is_Done) VALUES (4, 2, 250, 2, 0);

---------------------------------------------------------------
-- Удаление индексов 
---------------------------------------------------------------


DROP INDEX Index_Provider_Name;
DROP INDEX Index_Provider_Region;
DROP INDEX Index_Client_Name;
DROP INDEX Index_Raw_Type;
DROP INDEX Index_Product_Type_Name;
DROP INDEX Index_Product_Name;


---------------------------------------------------------------
-- Удаление таблиц 
---------------------------------------------------------------


DROP TABLE Raw_Product;
DROP TABLE Provider;
DROP TABLE Order_For_Product;
DROP TABLE Raw;
DROP TABLE Client;
DROP TABLE Product;
DROP TABLE Product_Type;




-----------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------
-- Хранимые процедуры и функции 
---------------------------------------------------------------

-- Добавление нового поставщика
GO
CREATE PROCEDURE AddNewProvider
@var_name AS CHAR(20),
@var_region AS CHAR(20),
@var_address AS CHAR(20),
@var_phone AS CHAR(20),
@var_raw_ID AS INTEGER
AS
BEGIN
  DECLARE @var_new_provider_id INTEGER;
  SELECT @var_new_provider_id = MAX(Provider_ID) + 1 FROM Provider;
  INSERT INTO Provider (Provider_ID, Name, Region, Address, Phone, Raw_ID)
        VALUES (@var_new_provider_id, @var_name, @var_region, @var_address, @var_phone, @var_raw_ID);   
END;
-- Пример вызова процедуры:
-- EXECUTE AddNewOwner @var_name = 'Fine Company', @var_region = 'Zelenodolsk district', @var_address = 'Ul. Podgornaya, 1-10', @var_phone = '+79854563983', @var_raw_ID = 1;
DROP PROCEDURE AddNewProvider;



-- Выполнить заказ (если на складе завода достаточное количество единиц заказанного продукта)
GO
CREATE PROCEDURE TryToCompleteOrder
@var_order_id AS INTEGER
AS
BEGIN
  DECLARE @var_product_id INTEGER;
  SELECT @var_product_id = Product_ID FROM Order_For_Product WHERE Order_ID = @var_order_id;
  DECLARE @var_amount INTEGER;
  SELECT @var_amount = Amount FROM Order_For_Product WHERE Order_ID = @var_order_id;
  DECLARE @var_amount_of_remained INTEGER;
  SELECT @var_amount_of_remained = Amount_Of_Remained FROM Product WHERE Product_ID = @var_product_id;
  IF (@var_amount_of_remained - @var_amount) >= 0
      UPDATE Order_For_Product SET Is_Done = 1 WHERE Order_ID = @var_order_id;
	  UPDATE Product SET Amount_Of_Remained = @var_amount_of_remained - @var_amount WHERE Product_ID = @var_product_id;
END;
-- Пример вызова процедуры:
-- EXECUTE TryToCompleteOrder @var_order_id = 2;
DROP PROCEDURE TryToCompleteOrder;



-- Получить количество заказов мороженого
GO
CREATE FUNCTION GetNumberOfIceCreamOrders()
  RETURNS INTEGER
  BEGIN
      DECLARE @ResultInt INTEGER;
	  SELECT @ResultInt = COUNT(*) FROM Order_For_Product JOIN Product ON Order_For_Product.Product_ID = Product.Product_ID
		JOIN Product_Type ON Product.Type_ID = Product_Type.Type_ID WHERE Product_Type.Name = 'Ice Cream';
	  RETURN @ResultInt;
  END;
-- Пример вызова функции:
SELECT dbo.GetNumberOfIceCreamOrders();
DROP FUNCTION GetNumberOfIceCreamOrders;



---------------------------------------------------------------
-- Триггеры
---------------------------------------------------------------

-- Запрет на удаление поставщика
GO
CREATE TRIGGER TR_Del_Provider ON Provider FOR DELETE
AS ROLLBACK;
-- Проверка: DELETE FROM Provider;
DROP TRIGGER TR_Del_Provider;



-- Запрет на удаление клиента
GO
CREATE TRIGGER TR_Del_Client ON Client FOR DELETE 
AS ROLLBACK;
-- Проверка: DELETE FROM Client;
DROP TRIGGER TR_Del_Client;



-- После 2-го заказа продукции добавить в графу с дополнительной информацией о ней пометку о том,
-- что данная продукция стала популярной
GO
CREATE TRIGGER TR_Ins_Order_For_Product ON Order_For_Product FOR INSERT 
AS
  BEGIN
  IF (SELECT COUNT(*) FROM Order_For_Product WHERE Order_For_Product.Product_ID = (SELECT Product_ID FROM INSERTED)) > 1
      IF (SELECT Additional_Information FROM Product WHERE Product.Product_ID = (SELECT Product_ID FROM INSERTED)) IS NULL
	      UPDATE Product SET Additional_Information = 'Popular product' WHERE Product.Product_ID = (SELECT Product_ID FROM INSERTED);
	  ELSE
	      IF (SELECT Additional_Information FROM Product WHERE Product.Product_ID = (SELECT Product_ID FROM INSERTED)) NOT LIKE 'Popular product: %'
              UPDATE Product SET Additional_Information = 'Popular product: ' + Additional_Information WHERE Product.Product_ID = (SELECT Product_ID FROM INSERTED);
  END;
---DROP TRIGGER TR_Ins_Order_For_Product;
  

 
---------------------------------------------------------------
-- Представления
---------------------------------------------------------------

-- Получить количество вариаций продуктов каждого типа
GO
CREATE VIEW V_NumberOfProductVariations (Product_Type, Count) AS
	SELECT Product_Type.Name, COUNT(*) FROM Product, Product_Type WHERE Product.Type_ID = Product_Type.Type_ID
	GROUP BY Product_Type.Name;
-- DROP VIEW V_NumberOfProductVariations;



-- Поставщики и поставляемое ими сырьё
GO
CREATE VIEW V_ProvidersAndRaw (Provider_ID, Name, Region, Address, Phone, Raw_Type, Amount_In_Storage, Cost_Per_Unit) AS
	SELECT Provider.Provider_ID, Provider.Name, Provider.Region, Provider.Address, Provider.Phone, Raw.Type, Raw.Amount_In_Storage, Raw.Cost_Per_Unit
	FROM Provider LEFT JOIN Raw ON Provider.Raw_ID = Raw.Raw_ID;
-- DROP VIEW V_ProvidersAndRaw;


-- Список клиентов по количеству заказанных ими за всё время единиц продукции,
-- где учитываются только клиенты, заказавшие больше 50 единиц продукции
GO
CREATE VIEW V_ClientsAndNumberOfAnyProductionUnits (Client_Name, Production_Unit_Count) AS
	SELECT Client.Name, SUM(Amount) AS Pr_Un_C FROM Order_For_Product RIGHT JOIN Client ON
	Order_For_Product.Client_ID = Client.Client_ID GROUP BY Client.Name HAVING SUM(Amount) > 50;
-- DROP VIEW V_ClientsAndNumberOfAnyProductionUnit;



---------------------------------------------------------------
-- Клиентская часть
---------------------------------------------------------------

-- 1. Поставщики из Зеленодольска
SELECT Name, Address FROM Provider WHERE Region = 'Zelenodolsky district';

-- 2. Поставщики, у которых цена единицы сырья меньше 50
SELECT Name, Raw_Type FROM V_ProvidersAndRaw WHERE Cost_Per_Unit < 50;

-- 3. Информация о поставщиках и поставляемом ими сырье из Ульяновского района и Зеленодольского района

SELECT * FROM V_ProvidersAndRaw WHERE Region = 'Ulyanovsk district'
UNION
SELECT * FROM V_ProvidersAndRaw WHERE Region = 'Zelenodolsky district';


-- 4. Названия всех продуктов и их цены у клиентов, в названии которых есть буква 'n'

SELECT Product.Name, Product.Selling_Price FROM Client, Product WHERE Client.Product_ID = Product.Product_ID
AND Client.Name LIKE '%n%'


-- 5. Список названий клиентов, которые заказывают продукцию в бумажном пакете, а также тип данной продукции и её название

SELECT Client.Name, Product_Type.Name, Product.Name FROM Order_For_Product JOIN Client
ON Order_For_Product.Client_ID = Client.Client_ID JOIN Product ON Order_For_Product.Product_ID = Product.Product_ID
JOIN Product_Type ON Product.Type_ID = Product_Type.Type_ID WHERE Packing_Type = 'Paper bag';


-- 6. Сумая маленькая сумма единиц заказанной продукции среди всех клиентов

SELECT MIN(Product_Units_Count_Grouped_By_Clients.Units_Count) FROM
(SELECT Client.Name, SUM(Amount) AS Units_Count FROM Order_For_Product JOIN Client ON
Order_For_Product.Client_ID = Client.Client_ID GROUP BY Client.Name) Product_Units_Count_Grouped_By_Clients;


-- 7. Количество вариаций продуктов каждого типа
SELECT * FROM V_NumberOfProductVariations;

-- 8. Средняя цена продукции в картонной упаковке
SELECT AVG(CONVERT(DECIMAL, Selling_Price)) FROM Product WHERE Packing_Type = 'Carton box';

-- 9. Продукция с ценой выше 70, имеющая дополнительную информацию о себе

SELECT Price_More_70.Name FROM (SELECT * FROM Product WHERE Selling_Price > 70) Price_More_70
WHERE Price_More_70.Additional_Information IS NOT NULL AND Price_More_70.Additional_Information != '';


-- 10. Номера выполненных заказов и количество заказанной продукции в заказах, где это количество больше 90
-- (отсортировано по возрастанию количества заказанной продукции)
SELECT Order_ID, Amount FROM Order_For_Product WHERE Is_Done = 1 AND Amount > 90 ORDER BY Amount;

-- 11. Заказы с непустой информацией, созданные клиентами, располагающимися в квартирах с номером 10

SELECT Order_For_Product.Order_ID FROM Order_For_Product, Client WHERE Order_For_Product.Client_ID = Client.Client_ID
AND Order_For_Product.Data IS NOT NULL AND Order_For_Product.Data != '' AND Client.Address LIKE '%-10';


-- 12. Названия всех продуктов, для производства которых используется молоко

SELECT Product.Name FROM Product JOIN Raw_Product ON Product.Product_ID = Raw_Product.Product_ID
JOIN Raw ON Raw_Product.Raw_ID = Raw.Raw_ID WHERE Raw.Type = 'Milk';
