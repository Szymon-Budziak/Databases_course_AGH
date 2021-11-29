-- 1. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z podziałem na lata i miesiące
SELECT EmployeeID,
       YEAR(OrderDate)  AS 'Year',
       MONTH(OrderDate) AS 'Month',
       COUNT(*)         AS 'Number of orders'
FROM Orders
GROUP BY EmployeeID, YEAR(OrderDate), MONTH(OrderDate)

-- 2. Dla każdej kategorii podaj maksymalną i minimalną cenę produktu w tej kategorii
SELECT CategoryID,
       MAX(UnitPrice) AS 'Max price',
       MIN(UnitPrice) AS 'Min price'
FROM Products
GROUP BY CategoryID