-- 1. Napisz polecenie, które wybiera numer tytułu i tytuł dla wszystkich książek, których tytuły
-- zawierających słowo „adventure”
SELECT title_no, title
FROM title
WHERE title LIKE '%adventure%'

-- 2. Napisz polecenie, które wybiera numer czytelnika, oraz zapłaconą karę
SELECT member_no, fine_paid
FROM loanhist
WHERE fine_assessed != fine_paid

-- 3. Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult.
SELECT DISTINCT city, state
FROM adult

-- 4. Napisz polecenie, które wybiera wszystkie tytuły z tablicy title i wyświetla je w porządku alfabetycznym.
SELECT title
FROM title
ORDER BY title ASC