CREATE OR REPLACE VIEW stolica_kraju AS
SELECT country.Name as Państwo, city.Name as Stolica FROM country
LEFT JOIN city on country.Code = city.CountryCode
WHERE city.ID = country.Capital OR country.Capital IS NULL
GROUP BY country.Name, city.Name;

SELECT * FROM stolica_kraju;

CREATE OR REPLACE VIEW gestosc_krajow AS
SELECT
    Name AS Kraj,
    Population AS Populacja,
    surfaceArea AS Powierzchnia,
    Population / NULLIF(surfaceArea, 0) AS Gestosc_Zaludnienia
FROM country;

SELECT * FROM gestosc_krajow;