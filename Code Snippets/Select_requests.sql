SELECT * FROM Pet WHERE Nick = 'Partizan';
SELECT Nick, Breed FROM Pet ORDER BY Age;
SELECT * FROM Pet WHERE Description IS NOT NULL AND Description != '';
SELECT AVG(Age) FROM Pet WHERE Breed = 'poodle';
SELECT Count(DISTINCT Owner_ID) FROM Pet;

---Клички и возраст с возрастом в диапазане 6 и 15
SELECT Nick, Age FROM Pet WHERE Age BETWEEN 6 AND 15;
---Клички, начинающиеся с буквы 'М'
SELECT Nick FROM Pet WHERE Nick LIKE 'M%';
---Информация про питомцев с возрастом 5, 10 или 15
SELECT * FROM Pet WHERE Age IN (5, 10, 15);