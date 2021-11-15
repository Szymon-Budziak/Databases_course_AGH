-- 1. Dla każdego zamówienia podaj łączną liczbę zamówionych jednostek towaru oraz nazwę klienta.
SELECT OD.OrderID, SUM(Quantity) AS quantity_sum, C.CompanyName
FROM [Order Details] AS OD
         INNER JOIN Orders O ON O.OrderID = OD.OrderID
         INNER JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY OD.OrderID, C.CompanyName
ORDER BY OD.OrderID

-- 2. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których łączna liczbę zamówionych
-- jednostek jest większa niż 250
SELECT OD.OrderID, SUM(OD.Quantity) AS quantity_sum, C.CompanyName
FROM [Order Details] AS OD
         INNER JOIN Orders O ON O.OrderID = OD.OrderID
         INNER JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY OD.OrderID, C.CompanyName
HAVING sum(OD.Quantity) > 250
ORDER BY OD.OrderID

-- 3. Dla każdego zamówienia podaj łączną wartość tego zamówienia oraz nazwę klienta.
SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2) AS total_value, C.CompanyName
FROM [Order Details] AS OD
         INNER JOIN Orders O ON O.OrderID = OD.OrderID
         INNER JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName

-- 4. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których łączna liczba jednostek
-- jest większa niż 250.
SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2) AS total_value, C.CompanyName
FROM [Order Details] AS OD
         INNER JOIN Orders O ON O.OrderID = OD.OrderID
         INNER JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName
HAVING SUM(Quantity) > 250

-- 5. Zmodyfikuj poprzedni przykład tak żeby dodać jeszcze imię i nazwisko pracownika obsługującego zamówienie
SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2) AS Total_value,
       C.CompanyName,
       E.FirstName + ' ' + E.LastName                       AS 'Employee'
FROM [Order Details] AS OD
         INNER JOIN Orders O ON O.OrderID = OD.OrderID
         INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
         INNER JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName, E.FirstName + ' ' + E.LastName
HAVING SUM(Quantity) > 250