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





