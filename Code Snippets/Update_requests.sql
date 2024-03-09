INSERT INTO Person SELECT MAX(Person_ID) + 1, 'Name', 'Surname', '+79999999999', 'Srednii pr VO, 1' FROM Person;
UPDATE Order1 SET Comments = '(s) ' + Order1.Comments WHERE Order1.Employee_ID IN (SELECT Employee_ID FROM Employee WHERE Spec = 'student');

CREATE TABLE Documents(
    Document_ID       INTEGER      NOT NULL,
    Type	          VARCHAR(20),
    Serial_Number	  VARCHAR(20)  NOT NULL,
	Person_ID         INTEGER      NOT NULL,
CONSTRAINT Documents_PK PRIMARY KEY (Document_ID)
);
ALTER TABLE Documents ADD CONSTRAINT FK_Documents_Person
	FOREIGN KEY (Person_ID)
	REFERENCES Person (Person_ID)
	ON DELETE CASCADE
;
INSERT INTO Documents SELECT 1, 'Паспорт', '1234 123456', MAX(Person_ID) FROM Person;
INSERT INTO Documents SELECT 2, 'ИНН', '111100001111', MAX(Person_ID) FROM Person;
--- DELETE FROM Person WHERE Person_ID = MAX(Person_ID);