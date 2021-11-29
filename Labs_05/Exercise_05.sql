-- 1. Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza orthwind)
SELECT E.EmployeeID,
       E.FirstName,
       E.LastName,
       E2.FirstName,
       E2.LastName
FROM Employees AS E
         INNER JOIN Employees AS E2 ON E.EmployeeID = E2.ReportsTo

-- 2. Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych (baza northwind)
SELECT E.FirstName,
       E.LastName
FROM Employees AS E
         LEFT JOIN Employees E2 ON E.EmployeeID = E2.ReportsTo
WHERE E2.ReportsTo IS NULL

-- 3. Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci urodzone przed 1 stycznia 1996
SELECT a.member_no,
       a.street,
       a.city,
       a.state,
       a.zip
FROM adult AS a
         INNER JOIN juvenile j ON a.member_no = j.adult_member_no
WHERE j.birth_date < '1996-01-01'

-- 4. Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci urodzone przed 1 stycznia 1996.
-- Interesują nas tylko adresy takich członków biblioteki, którzy aktualnie nie przetrzymują książek.
SELECT DISTINCT a.member_no,
                a.street,
                a.city,
                a.state,
                a.zip
FROM adult AS a
         INNER JOIN juvenile j ON a.member_no = j.adult_member_no
         LEFT JOIN loanhist l ON a.member_no = l.member_no
WHERE j.birth_date < '1996-01-01'
  AND (l.in_date < GETDATE() OR l.member_no is NULL)