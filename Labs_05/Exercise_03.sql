-- 1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego
-- produktu podaj dane adresowe dostawcy, interesują nas tylko produkty z kategorii ‘Meat/Poultry’
SELECT ProductName, UnitPrice, Address, City, Region, PostalCode, Country
FROM Products
         INNER JOIN Suppliers On Products.SupplierID = Suppliers.SupplierID
         INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE UnitPrice BETWEEN 20 AND 30
  AND CategoryName = 'Meat/Poultry'

-- 2. Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu podaj nazwę dostawcy.
SELECT ProductName, UnitPrice, CompanyName
FROM Products
         INNER JOIN Categories On Products.CategoryID = Categories.CategoryID
         INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE CategoryName = 'Confections'

-- 3. Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki dostarczała firma ‘United Package’
SELECT DISTINCT Customers.CompanyName, Customers.Phone
FROM Customers
         INNER JOIN Orders On Customers.CustomerID = Orders.CustomerID
         INNER JOIN Shippers On Orders.ShipVia = Shippers.ShipperID
WHERE YEAR(OrderDate) = 1997
  AND Shippers.CompanyName = 'United Package'

-- 4. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii ‘Confections’
SELECT DISTINCT Customers.CompanyName, Customers.Phone
FROM Customers
         INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
         INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
         INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
         INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Confections'