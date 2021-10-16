-- 1. Szukamy informacji o produktach o cenach mniejszych niż 10 lub większych niż 20
SELECT *
FROM Products
WHERE UnitPrice <= 10
   OR UnitPrice >= 20

-- 2. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
SELECT *
FROM Products
WHERE UnitPrice BETWEEN 20 AND 30