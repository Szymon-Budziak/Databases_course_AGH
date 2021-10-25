-- 1. Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
SELECT OrderID
FROM [Order Details]
GROUP BY OrderID
HAVING COUNT(*) > 5

-- 2. Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień (wyniki posortuj malejąco
-- wg łącznej kwoty za dostarczenie zamówień dla każdego z klientów)
SELECT CustomerID, SUM(Freight) AS 'Freight sum'
FROM Orders
WHERE YEAR(ShippedDate) = 1998
GROUP BY CustomerID
HAVING COUNT(*) > 8
ORDER BY 'Freight sum' DESC