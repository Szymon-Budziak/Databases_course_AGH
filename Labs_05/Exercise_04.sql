-- 1. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje
-- nas imię, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka.
SELECT member.firstname, member.lastname, juvenile.birth_date, adult.street, adult.city, adult.state, adult.zip
FROM member
         INNER JOIN adult ON member.member_no = adult.member_no
         INNER JOIN juvenile ON adult.member_no = juvenile.adult_member_no

-- 2. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje
-- nas imię, nazwisko, data urodzenia dziecka, adres zamieszkania dziecka oraz imię i nazwisko rodzica.
SELECT jm.firstname, jm.lastname, j.birth_date, street, city, state, zip, am.firstname, am.lastname
FROM juvenile AS j
         INNER JOIN member jm ON j.member_no = jm.member_no
         INNER JOIN adult a ON a.member_no = j.adult_member_no
         INNER JOIN member am ON a.member_no = am.member_no