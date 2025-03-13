/*
AUTOR: Bartosz Ochnik
STWORZENIE MOJEJ BAZY DANYCH - Wypozyczalnia Samochodow
Tworzenie i korzystanie z bazy danych "CarRentals" */
CREATE DATABASE IF NOT EXISTS CarRentals;
USE CarRentals;

-- 1) Polecenia CREATE:
-- Tworzenie tabeli Klienci

CREATE TABLE Klienci(
                        id_klienta INT PRIMARY KEY AUTO_INCREMENT,
                        imie VARCHAR(30) NOT NULL,
                        nazwisko VARCHAR(30) NOT NULL,
                        email VARCHAR(30) UNIQUE NOT NULL,
                        telefon VARCHAR(15),
                        adres VARCHAR(50)
);

-- Tworzenie tabeli Pojazdy

CREATE TABLE Pojazdy(
                        nr_rejestracyjny INT PRIMARY KEY,
                        marka VARCHAR(25) NOT NULL,
                        model VARCHAR(30) NOT NULL,
                        typ ENUM('Sedan', 'SUV', 'Kombi', 'Sportowy', 'Motocykl') NOT NULL,
                        cena Tinyint NOT NULL,
                        status ENUM('Dostepny','Wypozyczony','W naprawie') DEFAULT 'Dostepny'
);

-- Tworzenie tabeli Rezerwacje

CREATE TABLE Rezerwacje(
                           nr_rezerwacji INT PRIMARY KEY AUTO_INCREMENT,
                           id_klienta INT,
                           nr_rejestracyjny INT,
                           data_rozpoczecia DATE NOT NULL,
                           data_zakonczenia DATE NOT NULL,
                           status ENUM('W trakcie', 'Przed rozpoczeciem', 'Zakonczona', 'Anulowana') DEFAULT 'Przed rozpoczeciem',
                           FOREIGN KEY (id_klienta) REFERENCES Klienci(id_klienta),
                           FOREIGN KEY (nr_rejestracyjny) REFERENCES Pojazdy(nr_rejestracyjny)

);

-- Tworzenie tabeli Platnosci

CREATE TABLE Platnosci(
                          nr_platnosci INT PRIMARY KEY AUTO_INCREMENT,
                          nr_rezerwacji INT,
                          kwota DECIMAL(10,2) NOT NULL,
                          data_platnosci DATE NOT NULL DEFAULT (CURDATE()),
                          status ENUM('Oplacone' ,'Oczekujace', 'Anulowane') DEFAULT 'Oczekujace',
                          metoda ENUM('Karta' , 'Gotowka', 'Przelew') NOT NULL,
                          FOREIGN KEY (nr_rezerwacji) REFERENCES Rezerwacje(nr_rezerwacji)
);

-- 2) Polecenia INSERT:
-- Wstawianie rekordów do tabeli Klienci
INSERT INTO Klienci (imie, nazwisko, email, telefon, adres) VALUES
                                                                ('Jan', 'Kowalski', 'jan.kowalski@email.com', '600111222', 'Warszawa, ul. Długa 5'),
                                                                ('Anna', 'Nowak', 'anna.nowak@email.com', '601222333', 'Kraków, ul. Krótka 10'),
                                                                ('Piotr', 'Wiśniewski', 'piotr.wisniewski@email.com', '602333444', 'Gdańsk, ul. Morze 15'),
                                                                ('Katarzyna', 'Dąbrowska', 'k.dabrowska@email.com', '603444555', 'Wrocław, ul. Wesoła 3'),
                                                                ('Marek', 'Lewandowski', 'marek.lew@email.com', '604555666', 'Poznań, ul. Parkowa 20'),
                                                                ('Ewa', 'Jankowska', 'ewa.jankowska@email.com', '605666777', 'Szczecin, ul. Morska 12'),
                                                                ('Adam', 'Szymański', 'adam.szymanski@email.com', '606777888', 'Łódź, ul. Piękna 7'),
                                                                ('Magdalena', 'Zielińska', 'magda.z@email.com', '607888999', 'Katowice, ul. Rynek 9'),
                                                                ('Tomasz', 'Woźniak', 'tomasz.wozniak@email.com', '608999000', 'Rzeszów, ul. Leśna 4'),
                                                                ('Agnieszka', 'Mazur', 'agnieszka.mazur@email.com', '609000111', 'Lublin, ul. Słoneczna 18'),
                                                                ('Paweł', 'Kaczmarek', 'pawel.kaczmarek@email.com', '610111222', 'Bydgoszcz, ul. Wodna 25'),
                                                                ('Karolina', 'Wojciechowska', 'karolina.woj@email.com', '611222333', 'Białystok, ul. Spacerowa 2'),
                                                                ('Łukasz', 'Kubiak', 'lukasz.kubiak@email.com', '612333444', 'Opole, ul. Brzozowa 17'),
                                                                ('Joanna', 'Lis', 'joanna.lis@email.com', '613444555', 'Gdynia, ul. Marynarska 8'),
                                                                ('Dawid', 'Olszewski', 'dawid.olsz@email.com', '614555666', 'Częstochowa, ul. Aleje 11'),
                                                                ('Natalia', 'Kowalczyk', 'natalia.kow@email.com', '615666777', 'Gliwice, ul. Sportowa 30'),
                                                                ('Sebastian', 'Pawlak', 'sebastian.pawlak@email.com', '616777888', 'Toruń, ul. Zimowa 5'),
                                                                ('Aleksandra', 'Dudek', 'aleksandra.dudek@email.com', '617888999', 'Radom, ul. Zielona 12'),
                                                                ('Rafał', 'Jastrzębski', 'rafal.jast@email.com', '618999000', 'Kielce, ul. Różana 15'),
                                                                ('Martyna', 'Górska', 'martyna.gorska@email.com', '619000111', 'Zielona Góra, ul. Łąkowa 7');

-- Wstawianie rekordów do tabeli Pojazdy
INSERT INTO Pojazdy (nr_rejestracyjny, marka, model, typ, cena, status) VALUES
                                                                            (5004, 'Toyota', 'Corolla', 'Sedan', 50, 'Dostepny'),
                                                                            (4892, 'BMW', 'X5', 'SUV', 120, 'Dostepny'),
                                                                            (4582, 'Mercedes', 'E-Class', 'Sedan', 100, 'Wypozyczony'),
                                                                            (5982, 'Audi', 'A4', 'Kombi', 80, 'Dostepny'),
                                                                            (1134, 'Honda', 'Civic', 'Sedan', 55, 'Wypozyczony'),
                                                                            (8989, 'Ford', 'Focus', 'Kombi', 60, 'Dostepny'),
                                                                            (5603, 'Tesla', 'Model 3', 'Sedan', 150, 'Dostepny'),
                                                                            (3023, 'Skoda', 'Octavia', 'Kombi', 70, 'Dostepny'),
                                                                            (4290, 'Mazda', 'CX-5', 'SUV', 90, 'Wypozyczony');

-- Wstawianie rekordów do tabeli Rezerwacje
INSERT INTO Rezerwacje (id_klienta, nr_rejestracyjny, data_rozpoczecia, data_zakonczenia, status) VALUES
                                                                                                      (1, 1134, '2024-03-01', '2024-03-10', 'Zakonczona'),
                                                                                                      (2, 4582, '2024-03-05', '2024-03-12', 'W trakcie'),
                                                                                                      (3, 4290, '2024-03-07', '2024-03-15', 'W trakcie'),
                                                                                                      (4, 5603, '2024-03-10', '2024-03-17', 'Przed rozpoczeciem'),
                                                                                                      (5, 4892, '2024-03-15', '2024-03-20', 'Przed rozpoczeciem');

-- Wstawianie rekordów do tabeli Platnosci
INSERT INTO Platnosci (nr_rezerwacji, kwota, data_platnosci, status, metoda) VALUES
                                                                                 (11, 500.00, '2024-03-01', 'Oplacone', 'Karta'),
                                                                                 (12, 600.00, '2024-03-05', 'Oczekujace', 'Gotowka'),
                                                                                 (13, 750.00, '2024-03-07', 'Oplacone', 'Przelew'),
                                                                                 (14, 900.00, '2024-03-10', 'Oczekujace', 'Karta'),
                                                                                 (15, 400.00, '2024-03-15', 'Oczekujace', 'Gotowka');


-- 3) SKRYPTY
-- WIDOKI

-- Tworzenie widoku Lista_trwajacych_wypozyczen
CREATE OR REPLACE VIEW trwajace_wypozyczenia
AS
SELECT Klienci.imie, Klienci.nazwisko, Pojazdy.marka, Pojazdy.model, Pojazdy.nr_rejestracyjny, Rezerwacje.data_zakonczenia
FROM Rezerwacje
         INNER JOIN Klienci ON Rezerwacje.id_klienta = Klienci.id_klienta
         INNER JOIN Pojazdy ON Rezerwacje.nr_rejestracyjny = Pojazdy.nr_rejestracyjny
WHERE Rezerwacje.status = 'W trakcie';

-- Wybieranie danych z widoku
SELECT * FROM trwajace_wypozyczenia;

-- Tworzenie widoku Przelewy nieoplacone, gdzie pokazywani są klienci, którzy za wynajem płacą "z góry"

CREATE OR REPLACE VIEW Przelewy_nieoplacone
AS
SELECT Platnosci.nr_rezerwacji, Klienci.imie, Klienci.nazwisko,Klienci.email, Platnosci.kwota,
       Rezerwacje.data_rozpoczecia AS Termin_platnosci
FROM Platnosci
         INNER JOIN Rezerwacje ON Platnosci.nr_rezerwacji = Rezerwacje.nr_rezerwacji
         INNER JOIN Klienci  ON Rezerwacje.id_klienta = Klienci.id_klienta
WHERE Platnosci.status = 'Oczekujace' AND metoda = 'Przelew' ORDER BY Rezerwacje.data_rozpoczecia;

SELECT * FROM Przelewy_nieoplacone;

-- Tworzenie widoku pojazdów, które są dostępne
CREATE OR REPLACE VIEW dostepne_pojazdy
AS
SELECT Pojazdy.nr_rejestracyjny, Pojazdy.marka, Pojazdy.model,
       IFNULL(Rezerwacje.data_rozpoczecia, 'Niezarezerwowany') AS dostepny_do_dnia
FROM Pojazdy
         LEFT JOIN Rezerwacje ON Pojazdy.nr_rejestracyjny = Rezerwacje.nr_rejestracyjny
WHERE Pojazdy.status = 'Dostepny' OR Rezerwacje.data_rozpoczecia IS NULL;

SELECT * FROM dostepne_pojazdy;

-- widoek srednia cena wynajmu zalezna od typu

CREATE OR REPLACE VIEW srednia_cena_po_typie
AS
SELECT typ, AVG(cena) AS srednia_cena_za_dobe FROM Pojazdy
GROUP BY typ;

SELECT * FROM srednia_cena_po_typie;

-- widok zestawienia platnosci
CREATE OR REPLACE VIEW zestawienie_platnosci
AS
SELECT Platnosci.nr_platnosci, Klienci.imie, Klienci.nazwisko, Platnosci.kwota, Platnosci.data_platnosci, Platnosci.status,Platnosci.metoda
FROM Platnosci
         INNER JOIN Rezerwacje ON Platnosci.nr_rezerwacji = Rezerwacje.nr_rezerwacji
         INNER JOIN Klienci ON Rezerwacje.id_klienta = Klienci.id_klienta
WHERE Platnosci.status IN ('Oplacone', 'Oczekujace', 'Anulowane')
ORDER BY Platnosci.data_platnosci;

SELECT * FROM zestawienie_platnosci;

-- widok aktualnie zarezerwowanych pojazdów
CREATE OR REPLACE VIEW pojazdy_z_aktywnymi_rezerwacjami
AS
SELECT Klienci.imie, Klienci.nazwisko,Pojazdy.nr_rejestracyjny, Pojazdy.marka, Pojazdy.model, Rezerwacje.data_rozpoczecia, Rezerwacje.data_zakonczenia
FROM Pojazdy
         INNER JOIN Rezerwacje ON Pojazdy.nr_rejestracyjny = Rezerwacje.nr_rejestracyjny
         INNER JOIN Klienci ON Rezerwacje.id_klienta = Klienci.id_klienta
WHERE Rezerwacje.status IN ('W trakcie', 'Przed rozpoczeciem');

SELECT * FROM pojazdy_z_aktywnymi_rezerwacjami;

-- FUNKCJE
-- funkcja sprawdzajaca czy jaka jest cena za wynajem pojazdu w porownaninu do sredniej

DELIMITER $$
CREATE FUNCTION srednia_cena_za_dobe(typ_pojazdu VARCHAR(10), kwota INT)
    RETURNS VARCHAR(50)
    DETERMINISTIC
BEGIN
    DECLARE srednia DECIMAL(10,2);

    -- Pobranie średniej ceny dla podanego typu pojazdu
SELECT AVG(cena) INTO srednia FROM Pojazdy WHERE typ = typ_pojazdu;
-- Porównanie ceny wynajmu pojazdu z średnią dla danego typu
IF kwota < srednia THEN
        RETURN 'Taniej niż średnia';
    ELSEIF kwota = srednia THEN
        RETURN 'Cena na poziomie średniej';
ELSE
        RETURN 'Drożej niż średnia';
END IF;

END $$
DELIMITER ;

SELECT srednia_cena_za_dobe('Sedan', 80);

-- funckja sprawdzajaca czy dana pojazd jest mozliwy do wypozyczenia

DELIMITER $$
CREATE FUNCTION dostepnosc_pojazdu(numer int)
    RETURNS VARCHAR(30)
    DETERMINISTIC
BEGIN
    DECLARE status_pojazdu VARCHAR(20);

SELECT status INTO status_pojazdu FROM Pojazdy WHERE numer = nr_rejestracyjny;
IF status_pojazdu = 'Dostepny' THEN
        RETURN 'Dostepny';
    ELSEIF status_pojazdu = 'Wypozyczony' THEN
        RETURN 'Niedostepny';
END IF;

END $$
DELIMITER ;

SELECT dostepnosc_pojazdu(8989);

-- funkcja obliczajaca cene oraz dlugosc wypozyczenia
DROP function tworzenie_rezerwacji;
DELIMITER $$
CREATE FUNCTION tworzenie_rezerwacji(data_rozp DATE, data_zak DATE, nr_poj INT)
    RETURNS VARCHAR(200)
    DETERMINISTIC
BEGIN
    DECLARE kwota,ilosc,cena_dzienna int;
    DECLARE dostepnosc VARCHAR(20);

SELECT cena INTO cena_dzienna FROM Pojazdy WHERE nr_poj = nr_rejestracyjny;
SELECT status INTO dostepnosc FROM Pojazdy WHERE nr_poj = nr_rejestracyjny;

IF cena_dzienna IS NULL THEN
        RETURN 'Podany numer rejestracyjny nie znajduje sie w naszej bazie danych';
END IF;

    IF dostepnosc != 'Dostepny' THEN
        RETURN 'Pojazd w wybranym terminie jest niedostepny';
end if;

    -- Obliczenie liczby dni
    SET ilosc = DATEDIFF(data_zak, data_rozp) + 1;

    -- Jeśli data_zak jest wcześniejsza niż data_rozp, zwróć 0
    IF ilosc <= 0 THEN
        RETURN 0;

END IF;
    SET kwota = cena_dzienna*ilosc;
RETURN kwota;

END $$
DELIMITER ;

SELECT tworzenie_rezerwacji('2025-03-01','2025-03-01',1134)