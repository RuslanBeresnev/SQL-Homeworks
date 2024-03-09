CREATE VIEW v_dogs AS SELECT Pet.Nick, Pet.Breed, Pet.Age, Person.Last_Name, Person.First_Name FROM Pet JOIN Owner ON Pet.Owner_ID = Owner.Owner_ID JOIN Person ON Owner.Person_ID = Person.Person_ID;
GO
SELECT Nick, Last_Name FROM v_dogs WHERE Breed = 'poodle';
-----------------------
CREATE VIEW v_rating (Last_Name, First_Name, Employee_Count, Avg_Mark) AS SELECT Person.Last_Name, Person.First_Name, COUNT(*), AVG(CONVERT(DECIMAL, Order1.Mark)) FROM Order1 JOIN Employee ON Order1.Employee_ID = Employee.Employee_ID JOIN Person ON Employee.Person_ID = Person.Person_ID WHERE Order1.Is_Done = 1 GROUP BY Person.Person_ID, Person.Last_Name, Person.First_Name;
GO
SELECT * FROM v_rating ORDER BY Avg_Mark DESC;
----------------------------------
CREATE VIEW v_customers AS SELECT Person.Last_Name, Person.First_Name, Person.Phone, Person.Address FROM Owner JOIN Person ON Owner.Person_ID = Person.Person_ID;
GO
UPDATE v_customers SET Address = '?' WHERE Address IS NULL OR Address = '';
SELECT * FROM v_customers;