CREATE OR REPLACE VIEW stolica_kraju AS
SELECT country.Name as Państwo, city.Name as Stolica FROM country
LEFT JOIN city on country.Code = city.CountryCode
WHERE city.ID = country.Capital OR country.Capital IS NULL
GROUP BY country.Name, city.Name;

SELECT * FROM stolica_kraju;

SELECT Name, Population FROM country WHERE Continent = 'Asia'
AND Population = (SELECT MIN(Population) FROM country WHERE Continent = 'Asia');

SELECT Name FROM country ORDER BY SurfaceArea DESC LIMIT 5;

SELECT Name FROM country ORDER BY SurfaceArea LIMIT 10;

SELECT Name FROM country WHERE Continent = 'Europe' ORDER BY SurfaceArea LIMIT 10;

SELECT Name, SurfaceArea FROM country WHERE SurfaceArea BETWEEN 40000 AND 100000 ORDER BY SurfaceArea;

SELECT Name FROM city WHERE Name LIKE 'Z%k';

SELECT Name FROM city WHERE (Name LIKE 'W%') AND (Population > 1000000);

SELECT Name,Population FROM city WHERE (Population < 500) OR (Population > 9000000);

SELECT Name, Continent, SurfaceArea FROM country ORDER BY Continent, SurfaceArea DESC;

CREATE OR REPLACE VIEW gestosc_krajow AS
SELECT
    Name AS Kraj,
    Population AS Populacja,
    surfaceArea AS Powierzchnia,
    Population / NULLIF(surfaceArea, 0) AS Gestosc_Zaludnienia
FROM country ORDER BY Gestosc_Zaludnienia DESC;

SELECT * FROM gestosc_krajow LIMIT 10;

SELECT * FROM gestosc_krajow WHERE Powierzchnia > 10000 LIMIT 10;

SELECT * FROM gestosc_krajow ORDER BY Gestosc_Zaludnienia LIMIT 4;

SELECT * FROM gestosc_krajow WHERE Populacja != 0 ORDER BY Gestosc_Zaludnienia LIMIT 10;

SELECT Name FROM country WHERE IndepYear is null;

SELECT Name FROM country WHERE IndepYear IS NOT NULL
AND SurfaceArea = (SELECT MAX(SurfaceArea) FROM country WHERE IndepYear IS NOT NULL );

SELECT Name FROM country WHERE Continent = 'Asia' AND IndepYear < 0 ORDER BY Population DESC ;

SELECT Name FROM country WHERE ((IndepYear < 0) OR IndepYear IS NULL) AND Population > 5000000;

SELECT Name FROM city WHERE CountryCode = 'POL' AND
Population = (SELECT MIN(Population) FROM city WHERE CountryCode = 'POL');

SELECT country.Continent, COUNT(country.Name) as liczba_krajow FROM country GROUP BY country.Continent ORDER BY (liczba_krajow);

SELECT country.Continent,  SUM(country.SurfaceArea) as suma_powierzchni, SUM(country.Population) as liczba_ludnosci
FROM country GROUP BY country.Continent ORDER BY suma_powierzchni;

SELECT country.Continent,COUNT(country.Name) as liczba_krajow,  AVG(country.SurfaceArea) as srednia_powierzchnia,
       AVG(country.Population) as srednia_liczba_ludnosci
FROM country GROUP BY country.Continent ORDER BY liczba_krajow;

SELECT country.GovernmentForm AS 'Ustrój', count(*) AS 'ilość' FROM country WHERE (Continent = 'Europe') AND
    (Population > 1000000) GROUP BY country.GovernmentForm ;

SELECT city.CountryCode, COUNT(*) as 'ilosc' FROM city GROUP BY city.CountryCode ORDER BY ilosc DESC LIMIT 1;

SELECT countrylanguage.Language, COUNT(*) AS 'ilosc' FROM countrylanguage GROUP BY countrylanguage.Language
ORDER BY ilosc DESC LIMIT 10;

SELECT country.GovernmentForm AS 'Ustrój', COUNT(*) AS 'ilość' FROM country
GROUP BY country.GovernmentForm HAVING COUNT(*) > 10;

SELECT IndepYear, COUNT(*) AS 'ilość' FROM country WHERE IndepYear IS NOT NULL
GROUP BY IndepYear HAVING COUNT(*) =
(SELECT MAX(cnt) FROM ( SELECT COUNT(*) AS cnt FROM country WHERE IndepYear IS NOT NULL GROUP BY IndepYear) AS sub );

SELECT country.IndepYear, count(*) AS 'ilość' FROM country WHERE IndepYear IS NOT NULL
GROUP BY IndepYear HAVING COUNT(*) >= 5 ORDER BY ilość;

SELECT country.Name AS Kraj, city.Name AS Miasto, country.Population AS PopulacjaKraju, city.Population AS PopulacjaMiasta
FROM country
INNER JOIN city ON country.Code = city.CountryCode;

SELECT city.Name, city.Population FROM city
INNER JOIN country ON city.CountryCode = country.Code
WHERE country.Continent = 'Europe'
ORDER BY city.Population DESC LIMIT 1;

SELECT country.Continent, city.Name AS Miasto, city.Population AS Populacja
FROM city
INNER JOIN country ON city.CountryCode = country.Code
WHERE (country.Continent, city.Population) IN (
    SELECT Continent, MAX(city.Population)
    FROM city
             INNER JOIN country ON city.CountryCode = country.Code
    GROUP BY Continent
);

SELECT country.Continent, COUNT(city.Name) AS Miasto FROM country
LEFT JOIN city ON city.CountryCode = country.Code
GROUP BY country.Continent ;

SELECT country.Name AS Kraj, city.Name AS Miasto FROM country
INNER JOIN city ON country.Code = city.CountryCode
WHERE (city.ID = country.Capital) AND (city.Name = country.Name);

SELECT country.Name FROM country
LEFT JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE (Language = Name) OR (Language IS NULL);

SELECT city.Name FROM city
INNER JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
WHERE Language = 'Polish';

SELECT countrylanguage.Language, COUNT(DISTINCT country.Name) AS 'IloscKrajow' FROM countrylanguage
INNER JOIN country ON country.Code = countrylanguage.CountryCode
GROUP BY Language
HAVING COUNT(DISTINCT country.Name) >= 5
ORDER BY IloscKrajow DESC;

SELECT countrylanguage.Language, COUNT(DISTINCT city.Name) AS 'IloscMiast' FROM countrylanguage
INNER JOIN city ON city.CountryCode = countrylanguage.CountryCode
GROUP BY Language
ORDER BY IloscMiast DESC;

SELECT countrylanguage.Language, SUM(country.Population) AS 'Ilosc' FROM countrylanguage
INNER JOIN country ON country.Code = countrylanguage.CountryCode
GROUP BY Language
ORDER BY Ilosc DESC
LIMIT 10;










