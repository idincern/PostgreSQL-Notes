# PostgreSQL-Notes
My personal notes for [PostgreSQL training](https://www.youtube.com/watch?v=qw--VYLpxG4&t=275s&ab_channel=freeCodeCamp.org).

- \l: lists all databases
- \c [db_name]: connects to the database
- \dt: lists all tables
- \d [table_name]: lists entities in the table
- \i C:/Users/Dincer/Desktop/PostgreSQL_DBs/person.sql : loads from the text file
```sql
- DROP TABLE [table_name]; -- Deletes the table
- SELECT * FROM person; -- Selects all column values in the table
- SELECT first_name, last_name FROM person; -- Selects specific column values in the table
```

#
### ORDER BY
Allows sorting (ASCENDING/DESCENDING).

```sql
SELECT * FROM person ORDER BY country_of_birth ASC; -- A->Z
SELECT * FROM person ORDER BY id ASC; -- 1234567...
SELECT * FROM person ORDER BY country_of_birth;
SELECT * FROM person ORDER BY country_of_birth ASC;
SELECT * FROM person ORDER BY country_of_birth DESC;
SELECT * FROM person ORDER BY id DESC;
SELECT * FROM person ORDER BY id;
SELECT * FROM person ORDER BY first_name;
SELECT * FROM person ORDER BY first_name DESC;
SELECT * FROM person ORDER BY email DESC;
SELECT * FROM person ORDER BY email DESC;
SELECT * FROM person ORDER BY id, email;
SELECT * FROM person ORDER BY date_of_birth;
```

#
### DISTINCT
Displays unique values.

```sql
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth ASC;
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth DESC;
```

#
### WHERE
Used for filtering.
```sql
SELECT * FROM person WHERE gender='Female';
SELECT * FROM person WHERE gender='Male' AND country_of_birth='Turkey'
SELECT * FROM person WHERE gender='Male' AND (country_of_birth='Turkey' OR country_of_birth='USA') AND last_name = "Pete";
```

#
### COMPARISON OPERATORS
SELECT 1 = 1; // t Equals ✅
SELECT 1 <> 1; // f Not equals ❌
```sql
SELECT 'AMIGOSCODE' <> 'amigoscode' // t
```

#
### LIMIT
```sql
SELECT * FROM person LIMIT 10; -- fetches only the first 10 records.
SELECT * FROM person OFFSET 10 LIMIT 10; -- fetches only records 10-20.
SELECT * FROM person OFFSET 10 FETCH FIRST 10 ROW ONLY; -- same as above
```

#
### IN
```sql
SELECT * FROM person WHERE country_of_birth ='China' OR country_of_birth ='Brazil' OR country_of_birth ='France';
SELECT * FROM person WHERE country_of_birth IN('China','Brazil','France'); -- same as above

```

#
### BETWEEN
```sql
SELECT * FROM person WHERE date_of_birth BETWEEN DATE '2000-01-01' AND '2015-01-01';
```

#
### LIKE
% sign => any number of any characters.


```sql
SELECT * FROM person WHERE email LIKE '%@google.com'; -- Only google.com domain
SELECT * FROM person WHERE email LIKE '%@google.%'; -- All google domains
SELECT * FROM person WHERE email LIKE '%_______@'; -- _ indicates a character in each place (a-Z)
NOTE: If ILIKE is used, uppercase-lowercase is ignored.
SELECT * FROM person WHERE country_of_birth ILIKE 'P%'; -- All countries starting with P or p.
```

#
### GROUP BY
Allows filtering by a column.

```sql
SELECT DISTINCT country_of_birth; -- 124 countries total
SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth ORDER BY country_of_birth; -- returns the number of people born in each country (total 2 columns: country name and number of people)
```

#
### HAVING
Adds extra filtering to the GROUP BY command.
```sql
SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth HAVING COUNT(*) > 5 ORDER BY country_of_birth; -- returns the number of people born in each country (total 2 columns: country name and number of people)
```
