-- 1. Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień obsłużonych przez tego pracownika
-- (przy obliczaniu wartości zamówień uwzględnij cenę za przesyłkę)
-- subqueries
SELECT FirstName,
       LastName,
       (SELECT SUM(O.Freight)
        FROM Orders AS O
        WHERE O.EmployeeID = E.EmployeeID) +
       (SELECT SUM(UnitPrice * Quantity * (1 - Discount))
        FROM [Order Details] AS OD
        WHERE OrderID IN (SELECT OrderID FROM Orders AS O2 WHERE O2.EmployeeID = E.EmployeeID)) AS Total_value
FROM Employees AS E
ORDER BY E.FirstName, E.LastName

-- join
SELECT E.FirstName,
       E.LastName,
       SUM(UnitPrice * Quantity * (1 - Discount)) + (SELECT SUM(O2.Freight)
                                                     FROM Orders AS O2
                                                     WHERE O2.EmployeeID = E.EmployeeID) AS Total_value
FROM Employees AS E
         INNER JOIN Orders O ON O.EmployeeID = E.EmployeeID
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY E.FirstName

-- 2. Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia o największej wartości) w 1997r, podaj
-- imię i nazwisko takiego pracownika
SELECT TOP 1 FirstName,
             LastName,
             ROUND(((SELECT SUM(O.Freight)
                     FROM Orders AS O
                     WHERE O.EmployeeID = E.EmployeeID) +
                    (SELECT SUM(UnitPrice * Quantity * (1 - Discount))
                     FROM [Order Details] AS OD
                     WHERE OrderID IN (SELECT OrderID FROM Orders AS O2 WHERE O2.EmployeeID = E.EmployeeID))),
                   2) AS Total_value
FROM Employees AS E
WHERE EmployeeID IN (SELECT EmployeeID FROM Orders WHERE YEAR(OrderDate) = 1997)

-- 3. Ogranicz wynik z pkt 1 tylko do pracowników:
--    a) którzy mają podwładnych,
--    b) którzy nie mają podwładnych.
-- a)
SELECT FirstName,
       LastName,
       ROUND(((SELECT SUM(O.Freight)
               FROM Orders AS O
               WHERE O.EmployeeID = E.EmployeeID) +
              (SELECT SUM(UnitPrice * Quantity * (1 - Discount))
               FROM [Order Details] AS OD
               WHERE OrderID IN (SELECT OrderID FROM Orders AS O2 WHERE O2.EmployeeID = E.EmployeeID))),
             2) AS Total_value
FROM Employees AS E
WHERE EXISTS(SELECT * FROM Employees AS E2 WHERE E.EmployeeID = E2.ReportsTo)

-- b)
SELECT FirstName,
       LastName,
       ROUND(((SELECT SUM(O.Freight)
               FROM Orders AS O
               WHERE O.EmployeeID = E.EmployeeID) +
              (SELECT SUM(UnitPrice * Quantity * (1 - Discount))
               FROM [Order Details] AS OD
               WHERE OrderID IN (SELECT OrderID FROM Orders AS O2 WHERE O2.EmployeeID = E.EmployeeID))),
             2) AS Total_value
FROM Employees AS E
WHERE NOT EXISTS(SELECT * FROM Employees AS E2 WHERE E.EmployeeID = E2.ReportsTo)

-- 4. Zmodyfikuj rozwiązania z pkt 3 tak aby dla pracowników pokazać jeszcze datę ostatnio obsłużonego zamówienia
-- a)
SELECT FirstName,
       LastName,
       ROUND(((SELECT SUM(O.Freight)
               FROM Orders AS O
               WHERE O.EmployeeID = E.EmployeeID) +
              (SELECT SUM(UnitPrice * Quantity * (1 - Discount))
               FROM [Order Details] AS OD
               WHERE OrderID IN (SELECT OrderID
                                 FROM Orders AS O2
                                 WHERE O2.EmployeeID = E.EmployeeID))), 2) AS Total_value,
       (SELECT TOP 1 OrderDate
        FROM Orders AS O3
        WHERE E.EmployeeID = O3.EmployeeID
        ORDER BY O3.OrderDate DESC)                                        AS Last_order
FROM Employees AS E
WHERE EXISTS(SELECT * FROM Employees AS E2 WHERE E.EmployeeID = E2.ReportsTo)

-- b)
SELECT FirstName,
       LastName,
       ROUND(((SELECT SUM(O.Freight)
               FROM Orders AS O
               WHERE O.EmployeeID = E.EmployeeID) +
              (SELECT SUM(UnitPrice * Quantity * (1 - Discount))
               FROM [Order Details] AS OD
               WHERE OrderID IN (SELECT OrderID
                                 FROM Orders AS O2
                                 WHERE O2.EmployeeID = E.EmployeeID))), 2) AS Total_value,
       (SELECT TOP 1 OrderDate
        FROM Orders AS O3
        WHERE E.EmployeeID = O3.EmployeeID
        ORDER BY O3.OrderDate DESC)                                        AS Last_order
FROM Employees AS E
WHERE NOT EXISTS(SELECT * FROM Employees AS E2 WHERE E.EmployeeID = E2.ReportsTo)