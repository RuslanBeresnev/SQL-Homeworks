USE pet_db;

---------------------------------------------------------------
-- Создание таблиц и PK 
---------------------------------------------------------------

CREATE TABLE Person(
    Person_ID         INTEGER      NOT NULL,
    Last_Name	      VARCHAR(20)  NOT NULL,
    First_Name	      VARCHAR(20),
    Phone	      VARCHAR(15)  NOT NULL,
    Address	      VARCHAR(50)  NOT NULL,
CONSTRAINT Person_PK PRIMARY KEY (Person_ID)
)
;
CREATE TABLE Owner(
    Owner_ID                INTEGER         NOT NULL,
    Description	            VARCHAR(50),
    Person_ID               INTEGER         NOT NULL,
CONSTRAINT Owner_PK PRIMARY KEY (Owner_ID)
)
;
CREATE TABLE Employee(
    Employee_ID           INTEGER         NOT NULL,
    Spec	          VARCHAR(15),
    Person_ID             INTEGER         NOT NULL,
CONSTRAINT Employee_PK PRIMARY KEY (Employee_ID)
)
;
CREATE TABLE Pet_Type(
    Pet_Type_ID           INTEGER      NOT NULL,
    Name	          VARCHAR(15)  NOT NULL,
CONSTRAINT Pet_Type_PK PRIMARY KEY (Pet_Type_ID)
)
;
CREATE TABLE Pet(
    Pet_ID                  INTEGER      NOT NULL,
    Nick	            VARCHAR(15)  NOT NULL,
    Breed                   VARCHAR(20),
    Age                     INTEGER,
    Description             VARCHAR(50),
    Pet_Type_ID             INTEGER         NOT NULL,
    Owner_ID                INTEGER         NOT NULL,
CONSTRAINT Pet_PK PRIMARY KEY (Pet_ID)
)
;
CREATE TABLE Service(
    Service_ID              INTEGER         NOT NULL,
    Name	            VARCHAR(15)  NOT NULL,
CONSTRAINT Service_PK PRIMARY KEY (Service_ID)
)
;
CREATE TABLE Employee_Service(
    Employee_ID                   INTEGER         NOT NULL,
    Service_ID                    INTEGER         NOT NULL,
    Is_Basic	                  INTEGER
)
;
CREATE TABLE Order1(
    Order_ID                      INTEGER         NOT NULL,
    Owner_ID                      INTEGER         NOT NULL,
    Service_ID                    INTEGER         NOT NULL,
    Pet_ID                        INTEGER         NOT NULL,
    Employee_ID                   INTEGER         NOT NULL,
    Time_Order                    DATETIME      DEFAULT GETDATE()    NOT NULL,
    Is_Done	                  INTEGER       DEFAULT 0           NOT NULL,
    Mark	                  INTEGER,
    Comments                      VARCHAR(50),
CONSTRAINT Order_Is_Done CHECK (Is_Done in (0,1)),
CONSTRAINT Order_PK PRIMARY KEY (Order_ID)
)
;

---------------------------------------------------------------
-- Создание FK 
---------------------------------------------------------------
ALTER TABLE Owner ADD CONSTRAINT FK_Owner_Person 
    FOREIGN KEY (Person_ID)
    REFERENCES Person(Person_ID)
;
ALTER TABLE Employee ADD CONSTRAINT FK_Employee_Person 
    FOREIGN KEY (Person_ID)
    REFERENCES Person(Person_ID)
;
ALTER TABLE Pet ADD CONSTRAINT FK_Pet_0wner 
    FOREIGN KEY (Owner_ID)
    REFERENCES Owner(Owner_ID)
;
ALTER TABLE Pet ADD CONSTRAINT FK_Pet_Pet_Type 
    FOREIGN KEY (Pet_Type_ID)
    REFERENCES Pet_Type(Pet_Type_ID)
;
ALTER TABLE Employee_Service ADD CONSTRAINT FK_Empl_Serv_Employee 
    FOREIGN KEY (Employee_ID)
    REFERENCES Employee(Employee_ID)
;
ALTER TABLE Employee_Service ADD CONSTRAINT FK_Empl_Serv_Service 
    FOREIGN KEY (Service_ID)
    REFERENCES Service(Service_ID)
;
ALTER TABLE Order1 ADD CONSTRAINT FK_Order_Employee 
    FOREIGN KEY (Employee_ID)
    REFERENCES Employee(Employee_ID)
;
ALTER TABLE Order1 ADD CONSTRAINT FK_Order_0wner 
    FOREIGN KEY (Owner_ID)
    REFERENCES Owner(Owner_ID)
;
ALTER TABLE Order1 ADD CONSTRAINT FK_Order_Pet 
    FOREIGN KEY (Pet_ID)
    REFERENCES Pet(Pet_ID)
;
ALTER TABLE Order1 ADD CONSTRAINT FK_Order_Service 
    FOREIGN KEY (Service_ID)
    REFERENCES Service(Service_ID)
;

---------------------------------------------------------------
-- Заполнение таблиц тестовыми данными
---------------------------------------------------------------
set dateformat ymd;

INSERT INTO Person(Person_ID, Last_Name, First_Name, Phone, Address) VALUES (1, 'Ivanov', 'Vania', '+79123456789', 'Srednii pr VO, 34-2');
INSERT INTO Person(Person_ID, Last_Name, First_Name, Phone, Address) VALUES (2, 'Petrov', 'Petia', '+79234567890', 'Sadovaia ul, 17\2-23');
INSERT INTO Person(Person_ID, Last_Name, First_Name, Phone, Address) VALUES (3, 'Vasiliev', 'Vasia', '+7345678901', 'Nevskii pr, 9-11');
INSERT INTO Person(Person_ID, Last_Name, First_Name, Phone, Address) VALUES (4, 'Orlov', 'Oleg', '+7456789012', '5 linia VO, 45-8');
INSERT INTO Person(Person_ID, Last_Name, First_Name, Phone, Address) VALUES (5, 'Galkina', 'Galia', '+7567890123', '10 linia VO, 35-26');
INSERT INTO Person(Person_ID, Last_Name, First_Name, Phone, Address) VALUES (6, 'Sokolov', 'S.', '+7678901234', 'Srednii pr VO, 27-1');
INSERT INTO Person(Person_ID, Last_Name, First_Name, Phone, Address) VALUES (7, 'Vorobiev', 'Vova', '123-45-67', 'Universitetskaia nab, 17');
INSERT INTO Person(Person_ID, Last_Name, First_Name, Phone, Address) VALUES (8, 'Ivanov', 'Vano', '+7789012345', 'Malyi pr VO, 33-2');
INSERT INTO Person(Person_ID, Last_Name, First_Name, Phone, Address) VALUES (9, 'Sokolova', 'Sveta', '234-56-78', '');
INSERT INTO Person(Person_ID, Last_Name, First_Name, Phone, Address) VALUES (10, 'Zotov', 'Misha', '111-56-22', '');

INSERT INTO Owner(Owner_ID, Description, Person_ID) VALUES (1, 'good boy', 4);
INSERT INTO Owner(Owner_ID, Description, Person_ID) VALUES (2, '', 5);
INSERT INTO Owner(Owner_ID, Description, Person_ID) VALUES (3, '', 6);
INSERT INTO Owner(Owner_ID, Description, Person_ID) VALUES (4, 'from the ArtsAcademy', 7);
INSERT INTO Owner(Owner_ID, Description, Person_ID) VALUES (5, '', 8);
INSERT INTO Owner(Owner_ID, Description, Person_ID) VALUES (6, 'mean', 9);

INSERT INTO Employee(Employee_ID, Spec, Person_ID) VALUES (1, 'boss', 1);
INSERT INTO Employee(Employee_ID, Spec, Person_ID) VALUES (2, 'hairdresser', 2);
INSERT INTO Employee(Employee_ID, Spec, Person_ID) VALUES (3, 'student',3);
INSERT INTO Employee(Employee_ID, Spec, Person_ID) VALUES (4, 'student', 10);
     
INSERT INTO Pet_Type(Pet_Type_ID, NAME) VALUES (1, 'DOG');
INSERT INTO Pet_Type(Pet_Type_ID, NAME) VALUES (2, 'CAT');
INSERT INTO Pet_Type(Pet_Type_ID, NAME) VALUES (3, 'COW');
INSERT INTO Pet_Type(Pet_Type_ID, NAME) VALUES (4, 'FISH');

INSERT INTO Pet(Pet_ID, Nick, Breed, Age, Description, Pet_Type_ID, Owner_ID) VALUES (1, 'Bobik', 'unknown', 3, NULL, 1, 1);
INSERT INTO Pet(Pet_ID, Nick, Breed, Age, Description, Pet_Type_ID, Owner_ID) VALUES (2, 'Musia', NULL, 12, NULL, 2, 1);
INSERT INTO Pet(Pet_ID, Nick, Breed, Age, Description, Pet_Type_ID, Owner_ID) VALUES (3, 'Katok', NULL, 2, 'crazy guy', 2, 1);
INSERT INTO Pet(Pet_ID, Nick, Breed, Age, Description, Pet_Type_ID, Owner_ID) VALUES (4, 'Apelsin', 'poodle', 5, NULL,1, 2);
INSERT INTO Pet(Pet_ID, Nick, Breed, Age, Description, Pet_Type_ID, Owner_ID) VALUES (5, 'Partizan', 'Siamese', 5, 'very big', 2, 2);
INSERT INTO Pet(Pet_ID, Nick, Breed, Age, Description, Pet_Type_ID, Owner_ID) VALUES (6, 'Daniel', 'spaniel', 14, NULL, 1, 3);
INSERT INTO Pet(Pet_ID, Nick, Breed, Age, Description, Pet_Type_ID, Owner_ID) VALUES (7, 'Model', NULL, 5, NULL, 3, 4);
INSERT INTO Pet(Pet_ID, Nick, Breed, Age, Description, Pet_Type_ID, Owner_ID) VALUES (8, 'Markiz', 'poodle', 1, NULL, 1, 5);
INSERT INTO Pet(Pet_ID, Nick, Breed, Age, Description, Pet_Type_ID, Owner_ID) VALUES (9, 'Zombi', 'unknown', 7, 'wild', 2, 6);
INSERT INTO Pet(Pet_ID, Nick, Breed, Age, Description, Pet_Type_ID, Owner_ID) VALUES (10, 'Las', 'Siamese', 7, '', 2, 6);

INSERT INTO Service(Service_ID, NAME) VALUES (1, 'Walking');
INSERT INTO Service(Service_ID, NAME) VALUES (2, 'Combing');
INSERT INTO Service(Service_ID, NAME) VALUES (3, 'Milking');

INSERT INTO Employee_Service(Employee_ID, Service_ID, Is_Basic) VALUES (1, 1, 0);
INSERT INTO Employee_Service(Employee_ID, Service_ID, Is_Basic) VALUES (1, 2, 0);
INSERT INTO Employee_Service(Employee_ID, Service_ID, Is_Basic) VALUES (1, 3, 1);
INSERT INTO Employee_Service(Employee_ID, Service_ID, Is_Basic) VALUES (2, 1, 0);
INSERT INTO Employee_Service(Employee_ID, Service_ID, Is_Basic) VALUES (2, 2, 1);
INSERT INTO Employee_Service(Employee_ID, Service_ID, Is_Basic) VALUES (3, 1, 1);

INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (1, 1, 1, 1, 3, '2020-09-04 08:00', 1, 5, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (2, 1, 2, 2, 2, '2020-09-04 09:00', 1, 4, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (3, 1, 2, 3, 2, '2020-09-04 09:00', 0, 0, 'That cat is crazy!');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (4, 1, 1, 1, 3, '2020-09-05 00:00', 1, 5, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (5, 1, 1, 1, 3, '2020-09-06 11:00', 1, 3, 'Comming late');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (6, 1, 1, 1, 3, '2020-09-07 17:00', 1, 5, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (7, 1, 2, 2, 2, '2020-09-07 18:00', 1, 5, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (8, 2, 1, 5, 3, '2020-09-07 18:00', 1, 4, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (9, 2, 1, 4, 3, '2020-09-07 10:00', 1, 4, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (10, 2, 1, 5, 3, '2020-09-08 17:00', 1, 4, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (11, 2, 1, 4, 3, '2020-09-08 18:00', 1, 4, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (12, 2, 1, 5, 3, '2020-09-08 12:00', 1, 4, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (13, 2, 1, 4, 3, '2020-09-08 14:00', 1, 4, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (14, 3, 1, 6, 3, '2020-09-09 10:00', 1, 5, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (15, 3, 2, 6, 2, '2020-09-09 18:00', 0, 0, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (16, 3, 1, 6, 3, '2020-09-10 10:00', 0, 0, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (17, 3, 1, 6, 3, '2020-09-10 11:00', 0, 0, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (18, 3, 1, 6, 3, '2020-09-12 10:00', 0, 0, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark, Comments) 
       VALUES (20, 4, 3, 7, 1, '2020-09-10 11:00', 1, 5, '');
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark) 
       VALUES (21, 4, 3, 7, 1, '2020-09-11 11:00', 0, 0);
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark) 
       VALUES (22, 4, 3, 7, 1, '2020-09-12 11:00', 0, 0);
INSERT INTO Order1(Order_ID, Owner_ID, Service_ID, Pet_ID, Employee_ID, Time_Order, Is_Done, Mark) 
       VALUES (23, 5, 2, 8, 2, '2020-09-10 16:00', 0, 0);

INSERT INTO Vaccine_Type(Vaccine_Type_ID, Vaccine_Type) VALUES (1, 'Rabies');
INSERT INTO Vaccine_Type(Vaccine_Type_ID, Vaccine_Type) VALUES (2, 'Distemper');

INSERT INTO Vaccine(Vaccine_Time, Pet_ID, Vaccine_Type_ID, Vaccine_Info) VALUES ('2023-03-09 18:00', 1, 1, 'Succesful');
INSERT INTO Vaccine(Vaccine_Time, Pet_ID, Vaccine_Type_ID, Vaccine_Info) VALUES ('2023-03-10 18:00', 1, 2, 'Succesful');
INSERT INTO Vaccine(Vaccine_Time, Pet_ID, Vaccine_Type_ID, Vaccine_Info) VALUES ('2023-03-11 18:00', 5, 1, 'Succesful');
INSERT INTO Vaccine(Vaccine_Time, Pet_ID, Vaccine_Type_ID, Vaccine_Info) VALUES ('2023-03-12 18:00', 5, 2, 'Succesful');
INSERT INTO Vaccine(Vaccine_Time, Pet_ID, Vaccine_Type_ID, Vaccine_Info) VALUES ('2023-03-13 18:00', 6, 1, 'Succesful');
INSERT INTO Vaccine(Vaccine_Time, Pet_ID, Vaccine_Type_ID, Vaccine_Info) VALUES ('2023-03-14 18:00', 6, 2, 'Succesful');

---------------------------------------------------------------
-- Удаление таблиц 
---------------------------------------------------------------

/*
DROP TABLE Order1;
DROP TABLE Employee_Service;
DROP TABLE Service;
DROP TABLE Vaccine;
DROP TABLE Vaccine_Type;
DROP TABLE Pet;
DROP TABLE Pet_Type;
DROP TABLE Employee;
DROP TABLE Owner;
DROP TABLE Person;
*/

CREATE TABLE Vaccine_Type(
	Vaccine_Type_ID INTEGER NOT NULL,
	Vaccine_Type VARCHAR(20) NOT NULL,
CONSTRAINT Type_PK PRIMARY KEY (Vaccine_Type_ID)
)
;
CREATE TABLE Vaccine(
	Vaccine_Time DATETIME NOT NULL,				
	Pet_ID INTEGER NOT NULL,
	Vaccine_Type_ID INTEGER NOT NULL,
	Vaccine_Info VARCHAR(100)
)
;

ALTER TABLE Vaccine ADD CONSTRAINT FK_Vaccine_Vaccine_Type
	FOREIGN KEY (Vaccine_Type_ID)
	REFERENCES Vaccine_Type(Vaccine_Type_ID)
;
ALTER TABLE Vaccine ADD CONSTRAINT FK_Vaccine_Pet
	FOREIGN KEY (Pet_ID)
	REFERENCES Pet(Pet_ID)
;

DROP TABLE Vaccine;
DROP TABLE Vaccine_Type;
DROP TABLE Pet;