-- 1. Napisz polecenie które zwraca imię i nazwisko (jako pojedynczą kolumnę – name), oraz informacje o adresie: ulica,
-- miasto, stan, kod (jako pojedynczą kolumnę – address) dla wszystkich dorosłych członków biblioteki
SELECT firstname + ' ' + lastname AS 'name', a.street + ' ' + a.city + ' ' + a.state + ' ' + a.zip AS 'address'
FROM member AS m
         INNER JOIN adult a ON a.member_no = m.member_no

-- 2. Napisz polecenie, które zwraca: isbn, copy_no, on_loan, title, translation, cover, dla książek o isbn 1,
-- 500 i 1000. Wynik posortuj wg ISBN
SELECT i.isbn, c.copy_no, c.on_loan, t.title, c.on_loan, i.translation, i.cover
FROM item AS i
         INNER JOIN copy c ON i.title_no = c.title_no
         INNER JOIN title t ON c.title_no = t.title_no
WHERE i.isbn IN (1, 500, 1000)
ORDER BY i.isbn

-- 3. Napisz polecenie które zwraca o użytkownikach biblioteki o nr 250, 342, i 1675 (dla każdego użytkownika: nr,
-- imię i nazwisko członka biblioteki), oraz informację o zarezerwowanych książkach (isbn, data)
SELECT m.member_no, m.firstname, m.lastname, r.isbn, r.log_date
FROM member AS m
         LEFT OUTER JOIN reservation r
                         ON m.member_no = r.member_no
WHERE m.member_no IN (250, 342, 1675)

-- 4. Podaj listę członków biblioteki mieszkających w Arizonie (AZ) mają więcej niż dwoje dzieci zapisanych
-- do biblioteki
SELECT DISTINCT m.member_no, firstname, lastname
FROM member AS m
         INNER JOIN adult a ON m.member_no = a.member_no AND state = 'AZ'
         INNER JOIN juvenile j ON a.member_no = j.adult_member_no
GROUP BY m.member_no, firstname, lastname
HAVING COUNT(*) > 2

-- 5. Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają więcej niż dwoje dzieci zapisanych
-- do biblioteki oraz takich którzy mieszkają w Kaliforni (CA) i mają więcej niż troje dzieci zapisanych do biblioteki
SELECT m.member_no, firstname, lastname
FROM member AS m
         INNER JOIN adult a ON m.member_no = a.member_no
         INNER JOIN juvenile j ON a.member_no = j.adult_member_no
WHERE state = 'AZ'
GROUP BY m.member_no, firstname, lastname
HAVING COUNT(*) > 2
UNION
SELECT m2.member_no, firstname, lastname
FROM member AS m2
         INNER JOIN adult a2 ON m2.member_no = a2.member_no
         INNER JOIN juvenile j2 ON a2.member_no = j2.adult_member_no
WHERE state = 'CA'
GROUP BY m2.member_no, firstname, lastname
HAVING COUNT(*) > 3