-- 1. Dla każdego przewoźnika (nazwa) podaj liczbę zamówień które przewieźli w 1997r
SELECT S.CompanyName,
       COUNT(*) AS Number_of_orders
FROM Shippers AS S
         INNER JOIN Orders O ON S.ShipperID = O.ShipVia
WHERE YEAR(O.ShippedDate) = 1997
GROUP BY S.ShipperID, S.CompanyName

-- 2. Który z przewoźników był najaktywniejszy (przewiózł największą liczbę zamówień) w 1997r, podaj nazwę
-- tego przewoźnika
SELECT TOP 1 S.CompanyName,
             COUNT(*) AS Number_of_orders
FROM Shippers AS S
         INNER JOIN Orders O ON S.ShipperID = O.ShipVia
WHERE YEAR(O.ShippedDate) = 1997
GROUP BY S.ShipperID, S.CompanyName
ORDER BY Number_of_orders DESC

-- 3. Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień obsłużonych przez tego pracownika
SELECT E.FirstName,
       E.LastName,
       ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 2) AS total_value
FROM Employees AS E
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID, E.FirstName, E.LastName

-- 4. Który z pracowników obsłużył największą liczbę zamówień w 1997r, podaj imię i nazwisko takiego pracownika
SELECT TOP 1 E.FirstName,
             E.LastName,
             COUNT(*) AS Number_of_orders
FROM Employees AS E
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY COUNT(*) DESC

-- 5. Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia o największej wartości) w 1997r, podaj
-- imię i nazwisko takiego pracownika
SELECT TOP 1 E.FirstName,
             E.LastName,
             ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 2) AS total_value
FROM Employees AS E
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY total_value DESC