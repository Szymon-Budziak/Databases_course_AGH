-- 1. Dla każdego produktu podaj jego nazwę, cenę, średnią cenę wszystkich produktów oraz różnicę między ceną
-- produktu a średnią ceną wszystkich produktów
SELECT P.ProductName,
       P.UnitPrice,
       (SELECT AVG(UnitPrice) FROM Products)               AS "Avg_price",
       P.UnitPrice - (SELECT AVG(UnitPrice) FROM Products) AS "Diff_price"
FROM Products AS P

-- 2. Dla każdego produktu podaj jego nazwę kategorii, nazwę produktu, cenę, średnią cenę wszystkich produktów
-- danej kategorii oraz różnicę między ceną produktu a średnią ceną wszystkich produktów danej kategorii
-- subqueries
SELECT (SELECT CategoryName FROM Categories AS C WHERE C.CategoryID = P.CategoryID)               AS Category_name,
       ProductName,
       UnitPrice,
       (SELECT AVG(UnitPrice) FROM Products AS P2 WHERE P.CategoryID = P2.CategoryID)             AS Avg_category_price,
       UnitPrice - (SELECT AVG(UnitPrice) FROM Products AS P2 WHERE P.CategoryID = P2.CategoryID) AS Diff_price
FROM Products AS P

-- join
SELECT C.CategoryName,
       P.ProductName,
       P.UnitPrice,
       (SELECT AVG(UnitPrice) FROM Products AS P2 WHERE P.CategoryID = P2.CategoryID)             AS Avg_category_price,
       UnitPrice - (SELECT AVG(UnitPrice) FROM Products AS P2 WHERE P.CategoryID = P2.CategoryID) AS Diff_price
FROM Products AS P
         INNER JOIN Categories C ON C.CategoryID = P.CategoryID