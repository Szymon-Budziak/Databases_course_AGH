-- 1. Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień obsłużonych przez tego pracownika
-- (przy obliczaniu wartości zamówień uwzględnij cenę za przesyłkę)
-- subqueries
SELECT E.FirstName,
       E.LastName,
       (SELECT SUM(O.Freight)
        FROM Orders AS O
        WHERE O.EmployeeID = E.EmployeeID)
           + (SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
              FROM [Order Details] AS OD
              WHERE OD.OrderID IN (SELECT O2.OrderID
                                   FROM Orders AS O2
                                   WHERE O2.EmployeeID = E.EmployeeID)) AS Total_value
FROM Employees AS E

-- join
SELECT E.FirstName,
       E.LastName,
       SUM(Od.UnitPrice * OD.Quantity * (1 - OD.Discount))
           + (SELECT SUM(O2.Freight)
              FROM Orders AS O2
              WHERE O2.EmployeeID = E.EmployeeID) AS Total_value
FROM Employees AS E
         INNER JOIN Orders O ON O.EmployeeID = E.EmployeeID
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID, E.FirstName, E.LastName

-- 2. Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia o największej wartości) w 1997r, podaj
-- imię i nazwisko takiego pracownika
SELECT TOP 1 E.FirstName,
             E.LastName,
             (SELECT SUM(O.Freight)
              FROM Orders AS O
              WHERE O.EmployeeID = E.EmployeeID
                AND YEAR(O.OrderDate) = 1997)
                 + (SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
                    FROM [Order Details] AS OD
                    WHERE OD.OrderID IN
                          (SELECT O2.OrderID
                           FROM Orders AS O2
                           WHERE O2.EmployeeID = E.EmployeeID
                             AND YEAR(O2.OrderDate) = 1997)) AS Total_value
FROM Employees AS E

-- 3. Ogranicz wynik z pkt 1 tylko do pracowników:
--    a) którzy mają podwładnych,
--    b) którzy nie mają podwładnych.

-- a)
-- subqueries 1st solution using EXISTS
SELECT E.FirstName,
       E.LastName,
       ((SELECT SUM(O.Freight)
         FROM Orders AS O
         WHERE O.EmployeeID = E.EmployeeID)
           + (SELECT SUM(Od.UnitPrice * OD.Quantity * (1 - OD.Discount))
              FROM [Order Details] AS OD
              WHERE OD.OrderID IN (SELECT O2.OrderID
                                   FROM Orders AS O2
                                   WHERE O2.EmployeeID = E.EmployeeID))) AS Total_value
FROM Employees AS E
WHERE EXISTS(SELECT E2.ReportsTo
             FROM Employees AS E2
             WHERE E2.ReportsTo = E.EmployeeID)

-- join 1st solution using EXISTS
SELECT E.FirstName,
       E.LastName,
       (SELECT SUM(O2.Freight)
        FROM Orders AS O2
        WHERE O2.EmployeeID = E.EmployeeID)
           + SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Total_value
FROM Employees AS E
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON Od.OrderID = O.OrderID
WHERE EXISTS(SELECT E2.ReportsTo
             FROM Employees AS E2
             WHERE E2.ReportsTo = E.EmployeeID)
GROUP BY E.EmployeeID, E.FirstName, E.LastName

-- subqueries 2nd solution using IN
SELECT E.FirstName,
       E.LastName,
       (SELECT SUM(OD.UnitPrice * Od.Quantity * (1 - OD.Discount))
        FROM [Order Details] AS OD
        WHERE OD.OrderID IN (SELECT O.OrderID
                             FROM Orders AS O
                             WHERE O.EmployeeID = E.EmployeeID))
           + (SELECT SUM(O2.Freight)
              FROM Orders AS O2
              WHERE O2.EmployeeID = E.EmployeeID) AS Total_value
FROM Employees AS E
WHERE E.EmployeeID IN (SELECT E2.ReportsTo
                       FROM Employees AS E2
                       WHERE E2.ReportsTo = E.EmployeeID)

-- join 2nd solution using IN
SELECT E.FirstName,
       E.LastName,
       (SELECT SUM(O2.Freight)
        FROM Orders AS O2
        WHERE O2.EmployeeID = E.EmployeeID)
           + SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Total_value
FROM Employees AS E
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON Od.OrderID = O.OrderID
WHERE E.EmployeeID IN (SELECT E2.ReportsTo
                       FROM Employees AS E2
                       WHERE E2.ReportsTo = E.EmployeeID)
GROUP BY E.EmployeeID, E.FirstName, E.LastName

-- b)
-- subqueries 1st solution using EXISTS
SELECT E.FirstName,
       E.LastName,
       ((SELECT SUM(O.Freight)
         FROM Orders AS O
         WHERE O.EmployeeID = E.EmployeeID)
           + (SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
              FROM [Order Details] AS OD
              WHERE OD.OrderID IN (SELECT O2.OrderID
                                   FROM Orders AS O2
                                   WHERE O2.EmployeeID = E.EmployeeID))) AS Total_value
FROM Employees AS E
WHERE NOT EXISTS(SELECT E2.ReportsTo
                 FROM Employees AS E2
                 WHERE E.EmployeeID = E2.ReportsTo)

-- join 1st solution using EXISTS
SELECT E.FirstName,
       E.LastName,
       SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
           + (SELECT SUM(O2.Freight)
              FROM Orders AS O2
              WHERE O2.EmployeeID = E.EmployeeID) AS Total_value
FROM Employees AS E
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE NOT EXISTS(SELECT E2.ReportsTo
                 FROM Employees AS E2
                 WHERE E2.ReportsTo = E.EmployeeID)
GROUP BY E.EmployeeID, E.FirstName, E.LastName

-- subqueries 2nd solution using IN
SELECT E.FirstName,
       E.LastName,
       (SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
        FROM [Order Details] AS OD
        WHERE OD.OrderID IN (SELECT O.OrderID
                             FROM Orders AS O
                             WHERE O.EmployeeID = E.EmployeeID))
           + (SELECT SUM(O2.Freight)
              FROM Orders AS O2
              WHERE O2.EmployeeID = E.EmployeeID) AS Total_value
FROM Employees AS E
WHERE E.EmployeeID NOT IN (SELECT E2.ReportsTo
                           FROM Employees AS E2
                           WHERE E2.ReportsTo = E.EmployeeID)

-- join 2nd solution using IN
SELECT E.FirstName,
       E.LastName,
       (SELECT SUM(O2.Freight)
        FROM Orders AS O2
        WHERE O2.EmployeeID = E.EmployeeID)
           + SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Total_value
FROM Employees AS E
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON Od.OrderID = O.OrderID
WHERE E.EmployeeID NOT IN (SELECT E2.ReportsTo
                           FROM Employees AS E2
                           WHERE E2.ReportsTo = E.EmployeeID)
GROUP BY E.EmployeeID, E.FirstName, E.LastName

-- 4. Zmodyfikuj rozwiązania z pkt 3 tak aby dla pracowników pokazać jeszcze datę ostatnio obsłużonego zamówienia
-- a)
-- subqueries solution using EXISTS
SELECT E.FirstName,
       E.LastName,
       (SELECT SUM(O.Freight)
        FROM Orders AS O
        WHERE O.EmployeeID = E.EmployeeID)
           + (SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
              FROM [Order Details] AS OD
              WHERE OD.OrderID IN (SELECT O2.OrderID
                                   FROM Orders AS O2
                                   WHERE O2.EmployeeID = E.EmployeeID)) AS Total_value,
       (SELECT TOP 1 O3.OrderDate
        FROM Orders AS O3
        WHERE O3.EmployeeID = E.EmployeeID
        ORDER BY O3.OrderDate DESC)                                     AS Last_order
FROM Employees AS E
WHERE EXISTS(SELECT E2.ReportsTo
             FROM Employees AS E2
             WHERE E2.ReportsTo = E.EmployeeID)

-- join solution using IN
SELECT E.FirstName,
       E.LastName,
       (SELECT SUM(O2.Freight)
        FROM Orders AS O2
        WHERE O2.EmployeeID = E.EmployeeID)
           + SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Total_value,
       (SELECT TOP 1 O3.OrderDate
        FROM Orders AS O3
        WHERE O3.EmployeeID = E.EmployeeID
        ORDER BY O3.OrderDate DESC)                              AS Last_order
FROM Employees AS E
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON Od.OrderID = O.OrderID
WHERE E.EmployeeID IN (SELECT E2.ReportsTo
                       FROM Employees AS E2
                       WHERE E2.ReportsTo = E.EmployeeID)
GROUP BY E.EmployeeID, E.FirstName, E.LastName

-- b)
-- subqueries solution using IN
SELECT E.FirstName,
       E.LastName,
       (SELECT SUM(O.Freight)
        FROM Orders AS O
        WHERE O.EmployeeID = E.EmployeeID)
           + (SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
              FROM [Order Details] AS OD
              WHERE OD.OrderID IN (SELECT OrderID
                                   FROM Orders AS O2
                                   WHERE O2.EmployeeID = E.EmployeeID)) AS Total_value,
       (SELECT TOP 1 O3.OrderDate
        FROM Orders AS O3
        WHERE E.EmployeeID = O3.EmployeeID
        ORDER BY O3.OrderDate DESC)                                     AS Last_order
FROM Employees AS E
WHERE E.EmployeeID NOT IN (SELECT E2.ReportsTo
                           FROM Employees AS E2
                           WHERE E.EmployeeID = E2.ReportsTo)

-- join solution using EXISTS
SELECT E.FirstName,
       E.LastName,
       SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
           + (SELECT SUM(O2.Freight)
              FROM Orders AS O2
              WHERE O2.EmployeeID = E.EmployeeID) AS Total_value,
       (SELECT TOP 1 O3.OrderDate
        FROM Orders AS O3
        WHERE O3.EmployeeID = E.EmployeeID
        ORDER BY O3.OrderDate DESC)
FROM Employees AS E
         INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
         INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE NOT EXISTS(SELECT E2.ReportsTo
                 FROM Employees AS E2
                 WHERE E2.ReportsTo = E.EmployeeID)
GROUP BY E.EmployeeID, E.FirstName, E.LastName