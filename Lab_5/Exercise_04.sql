-- 1. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje
-- nas imię, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka.
SELECT m.firstname,
       m.lastname,
       j.birth_date,
       a.street,
       a.city,
       a.state,
       a.zip
FROM member AS m
         INNER JOIN juvenile j ON j.member_no = m.member_no
         INNER JOIN adult a ON a.member_no = j.adult_member_no

-- 2. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje
-- nas imię, nazwisko, data urodzenia dziecka, adres zamieszkania dziecka oraz imię i nazwisko rodzica.
SELECT m.firstname,
       m.lastname,
       j.birth_date,
       a.street,
       a.city,
       a.state,
       a.zip,
       m2.firstname,
       m2.lastname
FROM juvenile AS j
         INNER JOIN member m ON m.member_no = j.member_no
         INNER JOIN adult a ON a.member_no = j.adult_member_no
         INNER JOIN member m2 ON m2.member_no = a.member_no