-- 1. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje
-- nas imię, nazwisko i data urodzenia dziecka.
SELECT m.member_no, firstname, lastname, birth_date
FROM member AS m
         INNER JOIN juvenile ON m.member_no = juvenile.member_no

-- 2. Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek
SELECT DISTINCT title
FROM title
         INNER JOIN loan ON title.title_no = loan.title_no

-- 3. Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao Teh King’. Interesuje nas
-- data oddania książki, ile dni była przetrzymywana i jaką zapłacono karę
SELECT in_date, DATEDIFF(DAY, in_date, due_date) AS 'Delay', fine_paid
FROM loanhist
         INNER JOIN title ON loanhist.title_no = title.title_no
WHERE title = 'Tao Teh King'
  AND DATEDIFF(DAY, in_date, due_date) > 0

-- 4. Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych przez osobę o nazwisku: Stephen A. Graff
SELECT isbn
FROM member
         INNER JOIN reservation ON member.member_no = reservation.member_no
WHERE firstname = 'Stephen'
  AND middleinitial = 'A'
  AND lastname = 'Graff'