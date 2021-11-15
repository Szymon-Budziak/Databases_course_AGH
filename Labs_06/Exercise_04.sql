-- 1. Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień obsłużonych przez tego pracownika
-- Ogranicz wynik tylko do pracowników:
--    a) którzy mają podwładnych,
--    b) którzy nie mają podwładnych.

-- a)
SELECT E.FirstName, E.LastName, ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2) AS Total_value
FROM Employees AS E
         INNER JOIN Employees Emp ON Emp.ReportsTo = E.EmployeeID
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE Emp.ReportsTo IS NOT NULL
GROUP BY E.FirstName, E.LastName

-- b)
SELECT E.FirstName, E.LastName, ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2) AS Total_value
FROM Employees AS E
         LEFT JOIN Employees Emp ON Emp.ReportsTo = E.EmployeeID
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE Emp.ReportsTo IS NULL
GROUP BY E.FirstName, E.LastName