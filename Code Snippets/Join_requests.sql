SELECT Pet.Nick, Pet_Type.Name FROM Pet, Pet_Type WHERE Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID AND Pet.Nick = 'Partizan';
SELECT Pet.Nick, Pet.Breed, Pet.Age FROM Pet JOIN Pet_Type ON Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID WHERE Pet_Type.Name = 'DOG';
SELECT AVG(CONVERT(DECIMAL,Pet.Age)) FROM Pet, Pet_Type WHERE Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID AND Pet_Type.Name = 'CAT';
SELECT Order1.Time_Order, Person.Last_Name FROM Order1 JOIN Employee ON Order1.Employee_ID = Employee.Employee_ID
													   JOIN Person ON Employee.Person_ID = Person.Person_ID
													   WHERE Order1.Is_Done = 0;
SELECT Person.First_Name, Person.Last_Name, Person.Phone FROM Pet, Pet_Type, Owner, Person
WHERE Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID AND Pet.Owner_ID = Owner.Owner_ID AND
Owner.Person_ID = Person.Person_ID AND Pet_Type.Name = 'DOG';
SELECT Pet_Type.Name, Pet.Nick FROM Pet_Type LEFT JOIN PET ON Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID;
--- Имя и порода всех кошек, которым была сделана прививка от бешенства
SELECT Pet.Nick, Pet.Breed FROM Pet JOIN Pet_Type ON Pet.Pet_Type_ID = Pet_Type.Pet_Type_ID
									JOIN Vaccine ON Vaccine.Pet_ID = Pet.Pet_ID
									JOIN Vaccine_Type ON Vaccine.Vaccine_Type_ID = Vaccine_Type.Vaccine_Type_ID
									WHERE Pet_Type.Name = 'CAT' AND Vaccine_Type.Vaccine_Type = 'Rabies';