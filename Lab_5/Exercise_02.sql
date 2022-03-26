-- 1. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje
-- nas imię, nazwisko i data urodzenia dziecka.
SELECT m.member_no,
       m.firstname,
       m.lastname,
       j.birth_date
FROM member AS m
         INNER JOIN juvenile j ON m.member_no = j.member_no

-- 2. Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek
SELECT DISTINCT t.title
FROM title AS t
         INNER JOIN loan l ON t.title_no = l.title_no

-- 3. Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao Teh King’. Interesuje nas
-- data oddania książki, ile dni była przetrzymywana i jaką zapłacono karę
SELECT l.in_date,
       DATEDIFF(DAY, l.in_date, l.due_date) AS 'Delay',
       l.fine_paid
FROM loanhist AS l
         INNER JOIN title t ON l.title_no = t.title_no
WHERE t.title = 'Tao Teh King'
  AND DATEDIFF(DAY, l.in_date, l.due_date) > 0

-- 4. Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych przez osobę o nazwisku: Stephen A. Graff
SELECT r.isbn
FROM member AS m
         INNER JOIN reservation r ON m.member_no = r.member_no
WHERE m.firstname = 'Stephen'
  AND m.middleinitial = 'A'
  AND m.lastname = 'Graff'