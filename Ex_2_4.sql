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

/**/

