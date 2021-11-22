-- 1. Podaj łączną wartość zamówienia o numerze 10250 (uwzględnij cenę za przesyłkę)
-- subqueries
SELECT ROUND((SELECT SUM(UnitPrice * Quantity * (1 - Discount))
              FROM [Order Details] AS OD
              WHERE OD.OrderID = O.OrderID) + O.Freight, 2) AS Value
FROM Orders AS O
WHERE OrderID = 10250

-- join
SELECT ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) + O.Freight, 2) AS Value
FROM Orders AS O
         INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE O.OrderID = 10250
group by O.Freight

-- 2. Podaj łączną wartość zamówień każdego zamówienia (uwzględnij cenę za przesyłkę)
-- subqueries
SELECT OrderID,
       ROUND((SELECT SUM(UnitPrice * Quantity * (1 - Discount))
              FROM [Order Details] AS OD
              WHERE OD.OrderID = O.OrderID) + O.Freight, 2) AS Value
FROM Orders AS O

-- join
SELECT O.OrderID, ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) + O.Freight, 2) AS Value
FROM Orders AS O
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE OD.OrderID = O.OrderID
GROUP BY O.OrderID, O.Freight

-- 3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
-- 1st subqueries
SELECT CompanyName, Address, City, Region, PostalCode, Country
FROM Customers AS C
WHERE NOT EXISTS(SELECT * FROM Orders AS O WHERE O.CustomerID = C.CustomerID AND YEAR(OrderID) = 1997)

-- 2nd subqueries
SELECT CompanyName, Address, City, Region, PostalCode, Country
FROM Customers AS C
WHERE C.CustomerID NOT IN (SELECT O.CustomerID FROM Orders AS O WHERE YEAR(OrderID) = 1997)

-- 4. Podaj produkty kupowane przez więcej niż jednego klienta
-- join
SELECT P.ProductName, COUNT(*) AS 'Number_of_clients'
FROM Products AS P
         INNER JOIN [Order Details] OD ON P.ProductID = OD.ProductID
         INNER JOIN Orders O ON OD.OrderID = O.OrderID
         INNER JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY P.ProductName
HAVING COUNT(*) > 1