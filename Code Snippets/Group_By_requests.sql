SELECT Age, COUNT(*) FROM Pet GROUP BY Age;
SELECT Pet.Age, Pet_Type.Name, COUNT(*) AS 'Count' FROM Pet JOIN Pet_Type ON Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID GROUP BY Pet.Age, Pet_Type.Name ORDER BY Pet.Age;
SELECT Pet_Type.Name, AVG(CONVERT(DECIMAL, Pet.Age)) AS 'Avg-Age' FROM Pet JOIN Pet_Type ON Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID GROUP BY Pet_Type.Name HAVING AVG(Pet.Age) < 6;
SELECT Person.Last_Name, COUNT(*) AS 'Count of orders' FROM Order1 JOIN Employee ON Order1.Employee_ID = Employee.Employee_ID JOIN Person ON Employee.Person_ID = Person.Person_ID WHERE Order1.Is_Done = 1 GROUP BY Person.Last_Name HAVING COUNT(*) > 5;
--- Имена и фамилии сотрудников, которые выполнили заказы до 8 сентября 2020 года (включительно)
SELECT DISTINCT Person.First_Name, Person.Last_Name FROM Order1 JOIN Employee ON Employee.Employee_ID = Order1.Employee_ID JOIN Person ON Employee.Person_ID = Person.Person_ID WHERE YEAR(Order1.Time_Order) = 2020 AND MONTH(Order1.Time_Order) = 9 AND DAY(Order1.Time_Order) <= 8 AND Order1.Is_Done = 1;
--- Фамилии людей, которые живут на среднем проспекте ВО
SELECT Last_Name FROM Person WHERE Address LIKE '%Srednii pr VO%';