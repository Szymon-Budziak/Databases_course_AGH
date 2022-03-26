-- 1. Wybierz nazwy i numery telefonów klientów, którym w 1997 roku przesyłki dostarczała firma United Package.
-- subqueries
SELECT C.CompanyName,
       C.Phone
FROM Customers AS C
WHERE C.CustomerID IN
      (SELECT O.CustomerID
       FROM Orders AS O
       WHERE YEAR(O.OrderDate) = 1997
         AND O.ShipVia IN (SELECT S.ShipperID
                           FROM Shippers AS S
                           WHERE S.CompanyName = 'United Package'))

-- join
SELECT DISTINCT C.CompanyName,
                C.Phone
FROM Customers AS C
         INNER JOIN Orders O ON O.CustomerID = C.CustomerID
         INNER JOIN Shippers S ON O.ShipVia = S.ShipperID
WHERE YEAR(O.OrderDate) = 1997
  AND S.CompanyName = 'United Package'

-- 2. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii Confections.
-- subqueries
SELECT C.CompanyName,
       C.Phone
FROM Customers AS C
WHERE C.CustomerID IN
      (SELECT O.CustomerID
       FROM Orders AS O
       WHERE O.OrderID IN
             (SELECT OD.OrderID
              FROM [Order Details] AS OD
              WHERE OD.ProductID IN
                    (SELECT P.ProductID
                     FROM Products AS P
                     WHERE P.CategoryID IN
                           (SELECT CT.CategoryID
                            FROM Categories AS CT
                            WHERE CT.CategoryName = 'Confections'))))

-- join
SELECT DISTINCT C.CompanyName,
                C.Phone
FROM Customers AS C
         INNER JOIN Orders O ON C.CustomerID = O.CustomerID
         INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
         INNER JOIN Products P ON OD.ProductID = P.ProductID
         INNER JOIN Categories CA ON CA.CategoryID = P.CategoryID
WHERE CA.CategoryName = 'Confections'

-- 3. Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii Confections.
-- subqueries
SELECT C.CompanyName,
       C.Phone
FROM Customers AS C
WHERE C.CustomerID NOT IN
      (SELECT O.CustomerID
       FROM Orders AS O
       WHERE O.OrderID IN
             (SELECT OD.OrderID
              FROM [Order Details] AS OD
              WHERE OD.ProductID IN
                    (SELECT P.ProductID
                     FROM Products AS P
                     WHERE P.CategoryID IN
                           (SELECT CT.CategoryID
                            FROM Categories AS CT
                            WHERE CT.CategoryName = 'Confections'))))

-- join
SELECT C.CompanyName,
       C.Phone
FROM Customers AS C
WHERE C.CustomerID NOT IN (SELECT O.CustomerID
                           FROM Orders AS O
                                    INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
                                    INNER JOIN Products P ON P.ProductID = OD.ProductID
                                    INNER JOIN Categories C2 on C2.CategoryID = P.CategoryID
                           WHERE C2.CategoryName = 'Confections')