-- 1. Ile lat przepracował w firmie każdy z pracowników?
SELECT EmployeeID, YEAR(GETDATE()) - YEAR(HireDate) AS 'Total work in years'
FROM Employees

-- 2. Policz sumę lat przepracowanych przez wszystkich pracowników i średni czas pracy w firmie
SELECT SUM(YEAR(GETDATE()) - YEAR(HireDate)) AS 'Summary work',
       AVG(YEAR(GETDATE()) - YEAR(HireDate)) AS 'Average work'
FROM Employees

-- 3. Dla każdego pracownika wyświetl imię, nazwisko oraz wiek
SELECT FirstName, LastName, YEAR(GETDATE()) - YEAR(BirthDate) AS 'Age'
FROM Employees

-- 4. Policz średni wiek wszystkich pracowników
SELECT AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) AS 'Average Age'
FROM Employees

-- 5. Wyświetl wszystkich pracowników, którzy mają teraz więcej niż 25 lat
SELECT EmployeeID, FirstName, LastName, DATEDIFF(YEAR, BirthDate, GETDATE()) AS 'Age'
FROM Employees
WHERE YEAR(GETDATE()) - YEAR(BirthDate) > 25

-- 6. Policz średnią liczbę miesięcy przepracowanych przez każdego pracownika
SELECT AVG(DATEDIFF(MONTH, HireDate, GETDATE())) AS 'Average work in months'
FROM Employees

-- 7. Wyświetl dane wszystkich pracowników, którzy przepracowali w firmie co najmniej 320 miesięcy,
-- ale nie więcej niż 333
SELECT *
FROM Employees
WHERE DATEDIFF(MONTH, HireDate, GETDATE()) BETWEEN 320 AND 333