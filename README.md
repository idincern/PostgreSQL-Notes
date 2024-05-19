# PostgreSQL-Notes
My personal notes for PostgreSQL.

- **\l**: lists all dbs
- **\c [db_name]**: connects to the database
- **\dt**: lists all tables
- **\d [table_name]**: lists entities in the table
- **\i C:/Users/Dincer/Desktop/PostgreSQL_DBs/person.sql** : to load from the text file
- **DROP TABLE [table_name];** deletes the table
- **SELECT * FROM person;**: select all columns values in the table
- **SELECT first_name, last_name FROM person;**: Select all columns values in the table

- **SELECT * FROM person ORDER BY country_of_birth ASC;** : A->Z

- **SELECT * FROM person ORDER BY id ASC;**: 1234567...

![orderbys](orderbys.png)

