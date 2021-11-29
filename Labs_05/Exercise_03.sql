-- 1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego
-- produktu podaj dane adresowe dostawcy, interesują nas tylko produkty z kategorii ‘Meat/Poultry’
SELECT P.ProductName,
       P.UnitPrice,
       S.Address,
       S.City,
       S.Region,
       S.PostalCode,
       S.Country
FROM Products AS P
         INNER JOIN Suppliers S On P.SupplierID = S.SupplierID
         INNER JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE P.UnitPrice BETWEEN 20 AND 30
  AND C.CategoryName = 'Meat/Poultry'

-- 2. Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu podaj nazwę dostawcy.
SELECT P.ProductName,
       P.UnitPrice,
       S.CompanyName
FROM Products AS P
         INNER JOIN Categories C On P.CategoryID = C.CategoryID
         INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE C.CategoryName = 'Confections'

-- 3. Wybierz nazwy i numery telefonów klientów, którym w 1997 roku przesyłki dostarczała firma ‘United Package’
SELECT DISTINCT C.CompanyName,
                C.Phone
FROM Customers AS C
         INNER JOIN Orders O On C.CustomerID = O.CustomerID
         INNER JOIN Shippers S On O.ShipVia = S.ShipperID
WHERE YEAR(O.OrderDate) = 1997
  AND S.CompanyName = 'United Package'

-- 4. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii ‘Confections’
SELECT DISTINCT C.CompanyName,
                C.Phone
FROM Customers AS C
         INNER JOIN Orders O ON C.CustomerID = O.CustomerID
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
         INNER JOIN Products P ON OD.ProductID = P.ProductID
         INNER JOIN Categories CA ON P.CategoryID = CA.CategoryID
WHERE CA.CategoryName = 'Confections'