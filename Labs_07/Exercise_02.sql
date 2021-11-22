-- 1. Dla każdego produktu podaj maksymalną liczbę zamówionych jednostek
-- subqueries
SELECT ProductID,
       (SELECT MAX(Quantity)
        FROM [Order Details] AS OD
        WHERE OD.ProductID = P.ProductID) AS Max_quantity
FROM Products AS P

-- join
SELECT P.ProductID, MAX(Quantity) AS Max_quantity
FROM Products AS P
         INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
GROUP BY P.ProductID
ORDER BY P.ProductID

-- 2. Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu
SELECT ProductID, ProductName, UnitPrice
FROM Products AS P
WHERE UnitPrice < (SELECT AVG(UnitPrice) FROM Products)

-- 3. Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu danej kategorii
SELECT ProductID, ProductName, UnitPrice
FROM Products AS P1
WHERE P1.UnitPrice < (SELECT AVG(P2.UnitPrice)
                      FROM Products AS P2
                      WHERE P1.CategoryID = P2.CategoryID)