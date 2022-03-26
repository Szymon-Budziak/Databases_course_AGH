-- 1. Dla każdej kategorii produktu (nazwa), podaj łączną liczbę zamówionych przez klientów jednostek towarów
-- z tej kategorii.
SELECT C.CategoryName,
       SUM(OD.Quantity) AS Quantity_sum
FROM Categories AS C
         INNER JOIN Products P ON C.CategoryID = P.CategoryID
         INNER JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY C.CategoryID, C.CategoryName

-- 2. Dla każdej kategorii produktu (nazwa), podaj łączną wartość zamówionych przez klientów jednostek towarów
-- z tej kategorii.
SELECT C.CategoryName,
       ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 2) AS Total_value
FROM Categories AS C
         INNER JOIN Products P ON C.CategoryID = P.CategoryID
         INNER JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY C.CategoryID, C.CategoryName

-- 3. Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
--    a) łącznej wartości zamówień,
--    b) łącznej liczby zamówionych przez klientów jednostek towarów.
SELECT C.CategoryName,
       ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 2) AS Total_value
FROM Categories AS C
         INNER JOIN Products P ON C.CategoryID = P.CategoryID
         INNER JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY C.CategoryID, C.CategoryName
ORDER BY Total_value, SUM(OD.Quantity)

-- 4. Dla każdego zamówienia podaj jego wartość uwzględniając opłatę za przesyłkę
SELECT O.OrderID,
       ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) + O.Freight, 2) AS Total_value
FROM Orders AS O
         INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID, O.Freight