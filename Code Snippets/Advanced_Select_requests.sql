SELECT Order1.Mark FROM Order1 WHERE Order1.Employee_ID IN (SELECT Employee_ID FROM Employee WHERE Spec = 'student') AND Is_Done = 1;
SELECT Person.Last_Name FROM Employee JOIN (SELECT Employee_ID FROM Employee WHERE Employee_ID NOT IN (SELECT Employee_ID FROM Order1)) AS WithoutOrdersPeople ON WithoutOrdersPeople.Employee_ID = Employee.Employee_ID JOIN Person ON Person.Person_ID = Employee.Person_ID;
SELECT Service.Name, Order1.Time_Order, P1.Last_Name, Pet.Nick, P2.Last_Name FROM Order1 JOIN Service ON Order1.Service_ID = Service.Service_ID JOIN Pet ON Order1.Pet_ID = Pet.Pet_ID JOIN Employee ON Order1.Employee_ID = Employee.Employee_ID JOIN Person AS P1 ON Employee.Person_ID = P1.Person_ID JOIN Owner ON Order1.Owner_ID = Owner.Owner_ID JOIN Person AS P2 ON Owner.Person_ID = P2.Person_ID;
SELECT Description FROM Owner WHERE Description != '' AND Description IS NOT NULL UNION SELECT Comments FROM Order1 WHERE Comments != '' AND Comments IS NOT NULL UNION SELECT Description FROM Pet WHERE Description != '' AND Description IS NOT NULL;
SELECT First_Name, Last_Name FROM Person WHERE Person_ID IN (SELECT Person_ID FROM Employee WHERE EXISTS (SELECT Mark FROM Order1 WHERE Employee.Employee_ID = Order1.Employee_ID AND Mark = 5));