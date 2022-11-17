/*a.Попробуйте вывести не просто самую высокую зарплату во всей 
команде, а вывести именно фамилию сотрудника с самой высокой 
зарплатой.
*/
SELECT id, FirstName, LastName FROM Employees
WHERE Salary=(SELECT MAX(Salary) FROM Employees);

/*b.Попробуйте вывести фамилии сотрудников в алфавитном порядке
*/
SELECT LastName FROM Employees
ORDER BY LastName;

/*c.Рассчитайте средний стаж для каждого уровня сотрудников
*/
SELECT JobLevel, ROUND(AVG(current_date-DateIn)/365.0,1) AS JobStage  FROM Employees
GROUP BY JobLevel
ORDER BY JobLevel;

-- d.Выведите фамилию сотрудника и название отдела, в котором он работает
SELECT e.LastName, d.DivisionName  
FROM Employees AS e
LEFT JOIN Divisions AS d
ON d.id=e.division_id
ORDER BY e.LastName;

-- e.Выведите название отдела и фамилию сотрудника 
-- с самой высокой зарплатой в данном отделе и 
-- саму зарплату также
WITH MaxSal AS 
(SELECT d.DivisionName as Division, 
 e.LastName  as LastName, 
 Salary as Salary
FROM Employees AS e
LEFT JOIN Divisions AS d
ON d.id=e.division_id), 

FinTab AS
(SELECT Division,LastName,Salary,
ROW_NUMBER() OVER(PARTITION BY Division ORDER BY Salary DESC) AS Numb
FROM MaxSal)

SELECT Division,LastName,Salary FROM FinTab
WHERE numb =1;

/* f.*Выведите название отдела, сотрудники которого получат 
наибольшую премию по итогам года. 
Как рассчитать премию можно узнать в последнем задании 
предыдущей домашней работы*/
WITH Bonuses AS 
(SELECT Emp_id, 
ROUND((CASE WHEN Mark1 = 'A' THEN 20 WHEN Mark1='B' THEN 10 WHEN Mark1='C' THEN 0 WHEN Mark1='D' THEN -10 WHEN Mark1='E' THEN -20 END + 
CASE WHEN Mark2 = 'A' THEN 20 WHEN Mark2='B' THEN 10 WHEN Mark2='C' THEN 0 WHEN Mark2='D' THEN -10 WHEN Mark2='E' THEN -20 END + 
CASE WHEN Mark3 = 'A' THEN 20 WHEN Mark3='B' THEN 10 WHEN Mark3='C' THEN 0 WHEN Mark3='D' THEN -10 WHEN Mark3='E' THEN -20 END + 
CASE WHEN Mark4 = 'A' THEN 20 WHEN Mark4='B' THEN 10 WHEN Mark4='C' THEN 0 WHEN Mark4='D' THEN -10 WHEN Mark4='E' THEN -20 END)/4.0+100,2) AS Bonus
FROM WorkPlans)

SELECT DivisionName, AVG(Bonus)
FROM Divisions AS d
LEFT JOIN Employees AS e
ON d.id=e.division_id
LEFT JOIN Bonuses as b
ON b.Emp_Id=e.id
GROUP BY DivisionName 
ORDER BY AVG(Bonus) DESC
LIMIT 1; 

/*g*Проиндексируйте зарплаты сотрудников с учетом коэффициента 
премии. Для сотрудников с коэффициентом премии 
больше 1.2 – размер индексации составит 20%, 
для сотрудников с коэффициентом премии от 1 до 1.2 
размер индексации составит 10%. 
Для всех остальных сотрудников индексация не предусмотрена.*/

WITH Bonuses AS 
(SELECT Emp_id, 
ROUND((CASE WHEN Mark1 = 'A' THEN 20 WHEN Mark1='B' THEN 10 WHEN Mark1='C' THEN 0 WHEN Mark1='D' THEN -10 WHEN Mark1='E' THEN -20 END + 
CASE WHEN Mark2 = 'A' THEN 20 WHEN Mark2='B' THEN 10 WHEN Mark2='C' THEN 0 WHEN Mark2='D' THEN -10 WHEN Mark2='E' THEN -20 END + 
CASE WHEN Mark3 = 'A' THEN 20 WHEN Mark3='B' THEN 10 WHEN Mark3='C' THEN 0 WHEN Mark3='D' THEN -10 WHEN Mark3='E' THEN -20 END + 
CASE WHEN Mark4 = 'A' THEN 20 WHEN Mark4='B' THEN 10 WHEN Mark4='C' THEN 0 WHEN Mark4='D' THEN -10 WHEN Mark4='E' THEN -20 END)/4.0+100,2) AS Bonus
FROM WorkPlans)

SELECT e.id,LastName, Salary, Bonus, 
CASE WHEN Bonus/100. > 1.2 THEN 1.2 
	 WHEN Bonus/100. BETWEEN 1 AND 1.2 THEN 1.1
	 ELSE 1.0 END AS Indexation
FROM Employees AS e
LEFT JOIN Bonuses as b
ON b.Emp_Id=e.id; 

/****По итогам индексации отдел финансов хочет получить следующий отчет: 
вам необходимо на уровень каждого отдела вывести следующую информацию:
i.     Название отдела
ii.     Фамилию руководителя
iii.     Количество сотрудников
iv.     Средний стаж
v.     Средний уровень зарплаты
vi.     Количество сотрудников уровня junior
vii.     Количество сотрудников уровня middle
viii.     Количество сотрудников уровня senior
ix.     Количество сотрудников уровня lead
x.     Общий размер оплаты труда всех сотрудников до индексации
xi.     Общий размер оплаты труда всех сотрудников после индексации
xii.     Общее количество оценок А
xiii.     Общее количество оценок B
xiv.     Общее количество оценок C
xv.     Общее количество оценок D
xvi.     Общее количество оценок Е
xvii.     Средний показатель коэффициента премии
xviii.     Общий размер премии.
xix.     Общую сумму зарплат(+ премии) до индексации
xx.     Общую сумму зарплат(+ премии) после индексации(премии не индексируются)
xxi.     Разницу в % между предыдущими двумя суммами(первая/вторая)*/

WITH Bonuses AS 
(SELECT Emp_id, 
ROUND((CASE WHEN Mark1 = 'A' THEN 20 WHEN Mark1='B' THEN 10 WHEN Mark1='C' THEN 0 WHEN Mark1='D' THEN -10 WHEN Mark1='E' THEN -20 END + 
CASE WHEN Mark2 = 'A' THEN 20 WHEN Mark2='B' THEN 10 WHEN Mark2='C' THEN 0 WHEN Mark2='D' THEN -10 WHEN Mark2='E' THEN -20 END + 
CASE WHEN Mark3 = 'A' THEN 20 WHEN Mark3='B' THEN 10 WHEN Mark3='C' THEN 0 WHEN Mark3='D' THEN -10 WHEN Mark3='E' THEN -20 END + 
CASE WHEN Mark4 = 'A' THEN 20 WHEN Mark4='B' THEN 10 WHEN Mark4='C' THEN 0 WHEN Mark4='D' THEN -10 WHEN Mark4='E' THEN -20 END)/4.0+100,2) AS Bonus,
(CASE WHEN Mark1 = 'A' THEN 1 ELSE 0 END + 
CASE WHEN Mark2 = 'A' THEN 1 ELSE 0 END + 
CASE WHEN Mark3 = 'A' THEN 1 ELSE 0 END + 
CASE WHEN Mark4 = 'A' THEN 1 ELSE 0 END) AS A_Marks,
(CASE WHEN Mark1 = 'B' THEN 1 ELSE 0 END + 
CASE WHEN Mark2 = 'B' THEN 1 ELSE 0 END + 
CASE WHEN Mark3 = 'B' THEN 1 ELSE 0 END + 
CASE WHEN Mark4 = 'B' THEN 1 ELSE 0 END) AS B_Marks,
 (CASE WHEN Mark1 = 'C' THEN 1 ELSE 0 END + 
CASE WHEN Mark2 = 'C' THEN 1 ELSE 0 END + 
CASE WHEN Mark3 = 'C' THEN 1 ELSE 0 END + 
CASE WHEN Mark4 = 'C' THEN 1 ELSE 0 END) AS C_Marks,
(CASE WHEN Mark1 = 'D' THEN 1 ELSE 0 END + 
CASE WHEN Mark2 = 'D' THEN 1 ELSE 0 END + 
CASE WHEN Mark3 = 'D' THEN 1 ELSE 0 END + 
CASE WHEN Mark4 = 'D' THEN 1 ELSE 0 END) AS D_Marks,
(CASE WHEN Mark1 = 'E' THEN 1 ELSE 0 END + 
CASE WHEN Mark2 = 'E' THEN 1 ELSE 0 END + 
CASE WHEN Mark3 = 'E' THEN 1 ELSE 0 END + 
CASE WHEN Mark4 = 'E' THEN 1 ELSE 0 END) AS E_Marks
FROM WorkPlans)


SELECT DivisionName AS Division,
d.LastName AS LastName,
COUNT(e.id) AS Num_Employees, 
ROUND(AVG(current_date-DateIn)/365.0,1) AS JobStage,
ROUND(AVG(Salary),-1) AS Avg_Salary,
SUM(CASE WHEN JobLevel = 'junior' THEN 1 ELSE 0 END) AS Junes,
SUM(CASE WHEN JobLevel = 'middle' THEN 1 ELSE 0 END) AS Mids,
SUM(CASE WHEN JobLevel = 'senior' THEN 1 ELSE 0 END) AS Seniors,
SUM(CASE WHEN JobLevel = 'lead' THEN 1 ELSE 0 END) AS Leads,
SUM(Salary) AS Old_Salary,
SUM(Salary* (CASE WHEN Bonus/100. > 1.2 THEN 1.2 
	 WHEN Bonus/100. BETWEEN 1 AND 1.2 THEN 1.1
	 ELSE 1.0 END)) AS New_Salary,
SUM(A_marks) AS A_marks,
SUM(B_marks) AS B_marks,
SUM(C_marks) AS C_marks,
SUM(D_marks) AS D_marks,
SUM(E_marks) AS E_marks,
AVG(Bonus)  AS Avg_Bonus,
SUM(Salary+Bonus*Salary)  AS OldSalary_and_Bonus,
SUM(Salary* (CASE WHEN Bonus/100. > 1.2 THEN 1.2 
	 WHEN Bonus/100. BETWEEN 1 AND 1.2 THEN 1.1
	 ELSE 1.0 END) + Bonus*Salary) AS NewSalary_and_Bonus,
SUM(Salary* (CASE WHEN Bonus/100. > 1.2 THEN 1.2 
	 WHEN Bonus/100. BETWEEN 1 AND 1.2 THEN 1.1
	 ELSE 1.0 END) + Bonus*Salary) / SUM(Salary+Bonus*Salary) AS rate
FROM Divisions AS d
LEFT JOIN Employees AS e
ON d.id=e.division_id
LEFT JOIN Bonuses as b
ON b.Emp_Id=e.id
GROUP BY DivisionName,d.LastName
ORDER BY AVG(Bonus) DESC; 


