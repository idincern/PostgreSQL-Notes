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

-- min, max, avg, round, sum
SELECT MIN(id) AS min_id from person;
SELECT MAX(date_of_birth) AS newest from person;
SELECT AVG(id) AS avg_id from person;

SELECT country, ROUND(AVG(id)) from person GROUP BY country ORDER BY country;
SELECT country, SUM(id)/COUNT(person) as IdSum from person GROUP BY country ORDER BY SUM(id) DESC;

SELECT 10+2 as sum;
SELECT 10-2 as diff;
SELECT 10-2 as diff;
SELECT 5^2 as power;
SELECT 10%3 as mod;

SELECT COALESCE(null, 1, 10) as first_num;
SELECT COALESCE(email , 'E-mail not provided.') as emails from person; -- changes empty emails to the text
