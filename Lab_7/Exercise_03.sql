-- 1. Dla każdego produktu podaj jego nazwę, cenę, średnią cenę wszystkich produktów oraz różnicę między ceną
-- produktu a średnią ceną wszystkich produktów
SELECT P.ProductName,
       P.UnitPrice,
       (SELECT AVG(P2.UnitPrice)
        FROM Products AS P2)               AS 'Avg_price',
       P.UnitPrice - (SELECT AVG(P3.UnitPrice)
                      FROM Products AS P3) AS 'Diff_price'
FROM Products AS P

-- 2. Dla każdego produktu podaj jego nazwę kategorii, nazwę produktu, cenę, średnią cenę wszystkich produktów
-- danej kategorii oraz różnicę między ceną produktu a średnią ceną wszystkich produktów danej kategorii
-- subqueries
SELECT (SELECT C.CategoryName
        FROM Categories AS C
        WHERE C.CategoryID = P.CategoryID)                AS Category_name,
       P.ProductName,
       P.UnitPrice,
       (SELECT AVG(P2.UnitPrice)
        FROM Products AS P2
        WHERE P.CategoryID = P2.CategoryID)               AS Avg_category_price,
       P.UnitPrice - (SELECT AVG(P3.UnitPrice)
                      FROM Products AS P3
                      WHERE P.CategoryID = P3.CategoryID) AS Diff_price
FROM Products AS P

-- join
SELECT C.CategoryName,
       P.ProductName,
       P.UnitPrice,
       (SELECT AVG(P2.UnitPrice)
        FROM Products AS P2
        WHERE P.CategoryID = P2.CategoryID)               AS Avg_category_price,
       P.UnitPrice - (SELECT AVG(P3.UnitPrice)
                      FROM Products AS P3
                      WHERE P.CategoryID = P3.CategoryID) AS Diff_price
FROM Products AS P
         INNER JOIN Categories C ON C.CategoryID = P.CategoryID