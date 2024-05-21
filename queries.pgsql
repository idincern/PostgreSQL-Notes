SELECT * FROM person ORDER BY country ASC;

SELECT * FROM person ORDER BY id ASC; -- 1234567...

SELECT country, COUNT(*) AS MALES FROM person
WHERE gender = 'Male'
GROUP BY country
ORDER BY country ASC;

SELECT country, ARRAY_AGG(email) FROM person
WHERE country ='Japan' GROUP BY country;

SELECT country, JSON_AGG(email) AS emails FROM person
WHERE country ='Japan' GROUP BY country; -- may also be jsonb_agg

SELECT country, STRING_AGG(email, ' --- ') FROM person
WHERE country ='Japan' GROUP BY country;

SELECT country, COUNT(*) FROM person
GROUP BY country HAVING COUNT(*) > 5
ORDER BY country;

-- male / total people
SELECT COUNT(*) AS total_males, (SELECT COUNT(*) FROM person) AS total_people,
       CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM person) AS male_ratio
FROM person
WHERE gender = 'Male';
