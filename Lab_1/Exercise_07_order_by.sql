-- 1. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj według kraju, w ramach
-- danego kraju nazwy firm posortuj alfabetycznie
SELECT CompanyName, Country
FROM Customers
ORDER BY Country, CompanyName ASC

-- 2. Wybierz informację o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach
-- malejąco wg ceny
SELECT CategoryID, ProductName, UnitPrice
FROM Products
ORDER BY CategoryID, UnitPrice DESC

-- 3. Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we
-- Włoszech (Italy), wyniki posortuj tak jak w pkt 1
SELECT CompanyName, Country
FROM Customers
where Country = 'Japan'
   or Country = 'Italy'
ORDER BY Country, CompanyName ASC