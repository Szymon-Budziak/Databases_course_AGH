-- 1. Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień obsłużonych przez tego pracownika
-- Ogranicz wynik tylko do pracowników:
--    a) którzy mają podwładnych,
--    b) którzy nie mają podwładnych.

-- a)
SELECT E.FirstName,
       E.LastName,
       ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 2) AS Total_value
FROM Employees AS E
         INNER JOIN Employees E2 ON E.EmployeeID = E2.ReportsTo
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID, E.FirstName, E.LastName

-- b)
SELECT E.FirstName,
       E.LastName,
       ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 2) AS Total_value
FROM Employees AS E
         LEFT JOIN Employees E2 ON E.EmployeeID = E2.ReportsTo
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE E2.ReportsTo IS NULL
GROUP BY E.EmployeeID, E.FirstName, E.LastName