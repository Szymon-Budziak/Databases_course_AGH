-- 1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla
-- każdego produktu podaj dane adresowe dostawcy
SELECT ProductName, UnitPrice, Address
FROM Products
         INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE UnitPrice BETWEEN 20 AND 30

-- 2. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
SELECT ProductName, UnitsInStock
FROM Products
         INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Suppliers.CompanyName = 'Tokyo Traders'

-- 3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
SELECT CompanyName, Address, City, Region, PostalCode, Country
FROM Customers
         LEFT OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID AND YEAR(OrderDate) = 1997
WHERE Orders.CustomerID IS NULL

-- 4. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie ma w magazynie
SELECT CompanyName, Phone
FROM Suppliers
         INNER JOIN Products ON Suppliers.SupplierID = Products.SupplierID
WHERE UnitsInStock = 0