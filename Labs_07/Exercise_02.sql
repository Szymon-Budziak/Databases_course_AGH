-- 1. Dla każdego produktu podaj maksymalną liczbę zamówionych jednostek
-- subqueries
SELECT P.ProductID,
       (SELECT MAX(OD.Quantity)
        FROM [Order Details] AS OD
        WHERE OD.ProductID = P.ProductID) AS Max_quantity
FROM Products AS P

-- join
SELECT P.ProductID,
       MAX(OD.Quantity) AS Max_quantity
FROM Products AS P
         INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
GROUP BY P.ProductID

-- 2. Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu
SELECT P.ProductID,
       P.ProductName,
       P.UnitPrice
FROM Products AS P
WHERE P.UnitPrice < (SELECT AVG(P.UnitPrice)
                     FROM Products AS P)

-- 3. Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu danej kategorii
SELECT P.ProductID,
       P.ProductName,
       P.UnitPrice
FROM Products AS P
WHERE P.UnitPrice < (SELECT AVG(P2.UnitPrice)
                     FROM Products AS P2
                     WHERE P.CategoryID = P2.CategoryID)