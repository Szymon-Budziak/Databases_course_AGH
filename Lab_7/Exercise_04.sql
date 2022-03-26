-- 1. Podaj łączną wartość zamówienia o numerze 10250 (uwzględnij cenę za przesyłkę)
-- subqueries
SELECT (SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
        FROM [Order Details] AS OD
        WHERE OD.OrderID = O.OrderID)
           + O.Freight AS Value
FROM Orders AS O
WHERE O.OrderID = 10250

-- join
SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
           + O.Freight AS Value
FROM Orders AS O
         INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE O.OrderID = 10250
GROUP BY O.OrderID, O.Freight

-- 2. Podaj łączną wartość zamówień każdego zamówienia (uwzględnij cenę za przesyłkę)
-- subqueries
SELECT O.OrderID,
       (SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
        FROM [Order Details] AS OD
        WHERE OD.OrderID = O.OrderID) + O.Freight AS Value
FROM Orders AS O

-- join
SELECT O.OrderID,
       SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))
           + O.Freight AS Value
FROM Orders AS O
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID, O.Freight

-- 3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
-- 1st subqueries using EXISTS
SELECT C.CompanyName,
       C.Address,
       C.City,
       C.Region,
       C.PostalCode,
       C.Country
FROM Customers AS C
WHERE NOT EXISTS(SELECT O.CustomerID
                 FROM Orders AS O
                 WHERE O.CustomerID = C.CustomerID
                   AND YEAR(O.OrderDate) = 1997)

-- 2nd subqueries using IN
SELECT C.CompanyName,
       C.Address,
       C.City,
       C.Region,
       C.PostalCode,
       C.Country
FROM Customers AS C
WHERE C.CustomerID NOT IN (SELECT O.CustomerID
                           FROM Orders AS O
                           WHERE YEAR(O.OrderDate) = 1997)

-- join
SELECT C.CompanyName,
       C.Address,
       C.City,
       C.Region,
       C.PostalCode,
       C.Country
FROM Customers AS C
         LEFT JOIN Orders O ON O.CustomerID = C.CustomerID AND YEAR(O.OrderDate) = 1997
WHERE O.CustomerID IS NULL

-- 4. Podaj produkty kupowane przez więcej niż jednego klienta
SELECT P.ProductName,
       COUNT(DISTINCT O.CustomerID) AS 'Number_of_clients'
FROM Products AS P
         INNER JOIN [Order Details] OD ON P.ProductID = OD.ProductID
         INNER JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY P.ProductID, P.ProductName
HAVING COUNT(DISTINCT O.CustomerID) > 1
ORDER BY P.ProductName