-- 1. Napisz polecenie, które oblicza wartość każdej pozycji zamówienia o numerze 10250
SELECT ProductID, UnitPrice * Quantity * (1 - Discount) AS 'Value'
FROM [Order Details]
WHERE OrderID = 10250

-- 2. Napisz polecenie które dla każdego dostawcy (supplier) pokaże pojedynczą kolumnę
-- zawierającą nr telefonu i nr faksu w formacie (numer telefonu i faksu mają być
-- oddzielone przecinkiem)
-- first solution
SELECT CompanyName, Phone + ISNULL(', ' + Fax, '') AS 'Contact'
FROM Suppliers

-- second solution
SELECT CompanyName,
       CASE
           WHEN Fax IS NOT NULL THEN Phone + ', ' + Fax
           ELSE Phone
           END AS 'Contact'
FROM Suppliers