-- 1. Podaj liczbę produktów o cenach mniejszych niż 10$ lub większych niż 20$
SELECT Count(*) AS 'Number of products'
FROM Products
WHERE UnitPrice < 10
   OR UnitPrice > 20

-- 2. Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20$
SELECT MAX(UnitPrice) AS 'Max price'
FROM Products
WHERE UnitPrice < 20

-- 3. Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o produktach sprzedawanych w butelkach (‘bottle’)
SELECT MAX(UnitPrice) AS 'Max price', MIN(UnitPrice) AS 'Min price', AVG(UnitPrice) AS 'Avg Price'
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%'

-- 4. Wypisz informację o wszystkich produktach o cenie powyżej średniej
SELECT *
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)

-- 5. Podaj sumę/wartość zamówienia o numerze 10250
SELECT SUM(UnitPrice * Quantity * (1 - Discount)) AS 'Value'
FROM [Order Details]
WHERE OrderID = 10250