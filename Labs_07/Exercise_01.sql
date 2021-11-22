-- 1. Wybierz nazwy i numery telefonów klientów, którym w 1997 roku przesyłki dostarczała firma United Package.
-- subqueries
SELECT CompanyName, Phone
FROM Customers
WHERE CustomerID IN
      (SELECT CustomerID
       FROM Orders
       WHERE YEAR(OrderDate) = 1997
         AND ShipVia IN (SELECT ShipperID FROM Shippers WHERE Shippers.CompanyName = 'United Package'))

-- join
SELECT DISTINCT C.CompanyName, C.Phone
FROM Customers AS C
         INNER JOIN Orders O ON O.CustomerID = C.CustomerID
         INNER JOIN Shippers S ON O.ShipVia = S.ShipperID
WHERE YEAR(O.OrderDate) = 1997
  AND S.CompanyName = 'United Package'

-- 2. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii Confections.
-- subqueries
SELECT CompanyName, Phone
FROM Customers
WHERE CustomerID IN
      (SELECT CustomerID
       FROM Orders
       WHERE OrderID IN
             (SELECT OrderID
              FROM [Order Details]
              WHERE ProductID IN
                    (SELECT ProductID
                     FROM Products
                     WHERE CategoryID IN
                           (SELECT CategoryID
                            FROM Categories
                            WHERE CategoryName = 'Confections'))))

-- join
SELECT DISTINCT C.CompanyName, C.Phone
FROM Customers AS C
         INNER JOIN Orders O ON C.CustomerID = O.CustomerID
         INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
         INNER JOIN Products P ON OD.ProductID = P.ProductID
         INNER JOIN Categories CA ON CA.CategoryID = P.CategoryID
WHERE CA.CategoryName = 'Confections'

-- 3. Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii Confections.
-- subqueries
SELECT CompanyName, Phone
FROM Customers
WHERE CustomerID NOT IN
      (SELECT CustomerID
       FROM Orders
       WHERE OrderID IN
             (SELECT OrderID
              FROM [Order Details]
              WHERE ProductID IN
                    (SELECT ProductID
                     FROM Products
                     WHERE CategoryID IN
                           (SELECT CategoryID
                            FROM Categories
                            WHERE CategoryName = 'Confections'))))

-- 1st join
SELECT C.CompanyName, C.Phone
FROM Customers AS C
WHERE C.CustomerID NOT IN (SELECT CustomerID
                           FROM Categories AS C
                                    INNER JOIN Products P ON C.CategoryID = P.CategoryID
                                    INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
                                    INNER JOIN Orders O ON OD.OrderID = O.OrderID
                           WHERE C.CategoryName = 'Confections')

-- 2nd join
SELECT DISTINCT C.CompanyName, C.Phone
FROM Customers AS C
         INNER JOIN Orders O ON C.CustomerID <> O.CustomerID
         INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
         INNER JOIN Products P ON OD.ProductID = P.ProductID
         INNER JOIN Categories CA ON CA.CategoryID = P.CategoryID
WHERE CA.CategoryName = 'Confections'