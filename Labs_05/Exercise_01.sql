-- 1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla
-- każdego produktu podaj dane adresowe dostawcy
SELECT P.ProductName,
       P.UnitPrice,
       S.Address
FROM Products AS P
         INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE P.UnitPrice BETWEEN 20 AND 30

-- 2. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
SELECT P.ProductName,
       P.UnitsInStock
FROM Products AS P
         INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE S.CompanyName = 'Tokyo Traders'

-- 3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
SELECT C.CompanyName,
       C.Address,
       C.City,
       C.Region,
       C.PostalCode,
       C.Country
FROM Customers AS C
         LEFT OUTER JOIN Orders O ON C.CustomerID = O.CustomerID AND YEAR(O.OrderDate) = 1997
WHERE O.CustomerID IS NULL

-- 4. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie ma w magazynie
SELECT S.CompanyName,
       S.Phone
FROM Suppliers AS S
         INNER JOIN Products P ON S.SupplierID = P.SupplierID
WHERE P.UnitsInStock = 0