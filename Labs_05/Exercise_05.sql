-- 1. Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza orthwind)
SELECT e.FirstName, e.LastName, s.FirstName, s.LastName
FROM Employees AS e
         INNER JOIN Employees AS s ON e.EmployeeID = s.ReportsTo

-- 2. Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych (baza northwind)
SELECT e.FirstName, e.LastName
FROM Employees AS e
         LEFT JOIN Employees AS s ON e.EmployeeID = s.ReportsTo
WHERE s.ReportsTo IS NULL

-- 3. Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci urodzone przed 1 stycznia 1996
SELECT a.member_no, a.street, a.city, a.state, a.zip
FROM adult AS a
         INNER JOIN juvenile j ON a.member_no = j.adult_member_no
WHERE j.birth_date < '1996-01-01'

-- 4. Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci urodzone przed 1 stycznia 1996.
-- Interesują nas tylko adresy takich członków biblioteki, którzy aktualnie nie przetrzymują książek.
SELECT DISTINCT a.member_no, a.street, a.city, a.state, a.zip
FROM adult AS a
         INNER JOIN juvenile j ON a.member_no = j.adult_member_no
         LEFT JOIN loanhist l ON a.member_no = l.member_no
WHERE j.birth_date < '1996-01-01'
  AND (in_date < GETDATE() OR l.member_no is NULL)