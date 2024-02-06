--1
SELECT * FROM Student
WHERE возраст > 20;
--2
SELECT * FROM Student
WHERE возраст > 10 AND возраст < 25;
--3
SELECT * FROM Специальность
WHERE тип = 'бюджет';
--4
SELECT DISTINCT номер, наименование FROM Специальность
ORDER BY наименование ASC;
--5
SELECT * FROM Student
WHERE фамилия LIKE 'П%';
--6
SELECT * FROM Student
WHERE возраст BETWEEN 20 AND 25 
AND id_специальности IN (SELECT id_специальности FROM Специальность WHERE наименование = 'Прикладная информатика');
--7
SELECT AVG(стоимость) AS средняя_стоимость FROM Специальность
WHERE тип = 'контракт';
--8
SELECT Student.*, Специальность.наименование
FROM Student
INNER JOIN Специальность ON Student.id_специальности = Специальность.id_специальности
ORDER BY Специальность.наименование ASC, фамилия ASC, имя ASC;
--9
SELECT MAX(сумма) AS максимальная_стоимость, MIN(сумма) AS минимальная_стоимость
FROM Оплата_за_обучение;
--10
SELECT COUNT(*) AS общее_количество_студентов FROM Student;
--11
SELECT Специальность.уровень, COUNT(*) AS количество_студентов
FROM Student
INNER JOIN Специальность ON Student.id_специальности = Специальность.id_специальности
GROUP BY Специальность.уровень;
--12
SELECT Student.фамилия, Student.имя, Student.отчество, Специальность.наименование
FROM Student
INNER JOIN Оплата_за_обучение ON Student.id_студента = Оплата_за_обучение.id_студента
INNER JOIN Специальность ON Student.id_специальности = Специальность.id_специальности
ORDER BY Оплата_за_обучение.дата_и_время_платежа ASC
LIMIT 0,1;
--13
SELECT COUNT(*) AS количество_платежей, SUM(сумма) AS общая_сумма
FROM Оплата_за_обучение
WHERE id_студента = (SELECT id_студента FROM Student WHERE фамилия = 'Иванов' AND имя = 'Иван' AND отчество = 'Иванович');
--14
SELECT Student.фамилия || ' ' || Student.имя || ' ' || Student.отчество AS полное_имя,SUM(Оплата_за_обучение.сумма) AS общая_сумма_за_обучение,SUM(Оплата_за_обучение.задолженность) AS общая_сумма_долга
FROM Student
INNER JOIN Оплата_за_обучение ON Student.id_студента = Оплата_за_обучение.id_студента
INNER JOIN Специальность ON Student.id_специальности = Специальность.id_специальности
WHERE Специальность.наименование = 'Бизнес-информатика'
GROUP BY Student.id_студента
HAVING общая_сумма_долга >= 0 AND общая_сумма_за_обучение >= 2000;
--15
SELECT Специальность.наименование AS специальность,COUNT(Student.id_студента) AS количество_студентов
FROM Специальность
INNER JOIN Student ON Специальность.id_специальности = Student.id_специальности
GROUP BY Специальность.id_специальности
HAVING COUNT(Student.id_студента) > 3;
--16
SELECT Специальность.наименование AS специальность,COUNT(Student.id_студента) AS количество_студентов
FROM Специальность
LEFT JOIN Student ON Специальность.id_специальности = Student.id_специальности
GROUP BY Специальность.id_специальности
HAVING количество_студентов > 0
ORDER BY количество_студентов DESC;
--19
SELECT Student.фамилия || ' ' || Student.имя || ' ' || Student.отчество AS ФИО,SUM(Оплата_за_обучение.задолженность) AS общая_сумма_долга
FROM Student
INNER JOIN Оплата_за_обучение ON Student.id_студента = Оплата_за_обучение.id_студента
GROUP BY Student.id_студента
HAVING SUM(Оплата_за_обучение.задолженность) < (SELECT AVG(задолженность) FROM Оплата_за_обучение);
--20
SELECT STRFTIME('%m', дата_и_время_платежа) AS месяц,COUNT(*) AS количество_платежей,SUM(сумма) AS общая_сумма_платежей
FROM Оплата_за_обучение
WHERE STRFTIME('%Y', дата_и_время_платежа) = '2023'
GROUP BY месяц;
--21
SELECT Специальность.наименование AS специальность,COUNT(Student.id_студента) AS количество_студентов,ROUND(CAST(COUNT(Student.id_студента) AS REAL) / (SELECT COUNT(*) FROM Student) * 100, 2) AS процент
FROM Специальность
LEFT JOIN Student ON Специальность.id_специальности = Student.id_специальности
GROUP BY Специальность.id_специальности
HAVING процент > 0
ORDER BY процент DESC;
















