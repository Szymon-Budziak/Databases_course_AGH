-- 1. Podaj liczbę zamówionych jednostek produktów dla produktów, dla których productid < 3
SELECT ProductID,
       SUM(Quantity) AS 'Quantity Sum'
FROM [Order Details]
WHERE ProductID < 3
GROUP BY ProductID

-- 2. Zmodyfikuj zapytanie z poprzedniego punktu, tak aby podawało liczbę zamówionych jednostek produktu dla
-- wszystkich produktów
SELECT ProductID,
       SUM(Quantity) AS 'Quantity Sum'
FROM [Order Details]
GROUP BY ProductID

-- 3. Podaj nr zamówienia oraz wartość zamówienia, dla zamówień, dla których łączna liczba zamawianych jednostek
-- produktów jest > 250
SELECT OrderID,
       SUM(UnitPrice * Quantity * (1 - Discount)) AS 'Value',
       SUM(Quantity)                              AS 'Quantity Sum'
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity) > 250