SELECT * FROM hello_mysql.city WHERE COUNTRYCODE ='USA' AND POPULATION > 100000;

-- Query all columns (attributes) for every row in the CITY table.
SELECT * FROM city

-- Query all columns for a city in CITY with the ID 1661.
SELECT * FROM city WHERE ID =1661;

-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT * FROM city WHERE COUNTRYCODE ='JPN';

-- Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT NAME FROM city WHERE COUNTRYCODE ='JPN';

-- Query a list of CITY and STATE from the STATION table.
"
The STATION table is described as follows:
ID NUMBER
CITY VARCHAR(21)
STATE VARCHAR(2)
LAT_N NUMBER
LONG_W NUMBER
"
SELECT CITY,STATE FROM station;

-- Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
SELECT DISTINCT CITY FROM station WHERE MOD(ID,2) = 0;

-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) AS difference FROM station AS results;

-- Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
(SELECT NAME, length(NAME) FROM hello_mysql.city ORDER BY length(NAME) DESC, NAME ASC LIMIT 1) 
UNION 
(SELECT NAME, length(NAME) FROM hello_mysql.city ORDER BY length(NAME) ASC, NAME ASC LIMIT 1);

(SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) ASC, CITY ASC LIMIT 1) UNION (SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC, CITY ASC LIMIT 1);

-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT DISTRICT FROM hello_mysql.city WHERE DISTRICT regexp '^[AEIOU]'; 

SELECT DISTINCT CITY FROM station WHERE CITY regexp '^[AEIOU]'; 
 
-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT DISTRICT FROM hello_mysql.city WHERE DISTRICT regexp '[aeiou]$';
SELECT DISTINCT CITY FROM station WHERE CITY regexp '[aeiou]$';

-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT DISTRICT FROM hello_mysql.city WHERE DISTRICT regexp '^[AEIOUaeiou]' AND DISTRICT regexp '[AEIOUaeiou]$';
SELECT DISTINCT CITY FROM station WHERE CITY regexp '^[AEIOUaeiou]' AND CITY regexp '[AEIOUaeiou]$';

-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT DISTRICT FROM hello_mysql.city WHERE DISTRICT REGEXP '^[^AEIOU]'
SELECT DISTINCT CITY FROM station WHERE CITY REGEXP '^[^AEIOU]';

-- Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT DISTRICT FROM hello_mysql.city WHERE DISTRICT regexp '[^aeiou]$';
SELECT DISTINCT CITY FROM station WHERE CITY regexp '[^aeiou]$';

-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT DISTRICT FROM hello_mysql.city WHERE DISTRICT regexp '^[^AEIOU]' OR DISTRICT regexp '[^aeiou]$';
SELECT DISTINCT CITY FROM station WHERE CITY regexp '^[^AEIOU]' OR CITY regexp '[^aeiou]$';

-- Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM station WHERE CITY regexp '^[^AEIOU]' AND CITY regexp '[^aeiou]$';

-- Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
SELECT Name FROM STUDENTS WHERE Marks >75 ORDER BY RIGHT (Name,3) ASC, ID ASC;

-- Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
SELECT name FROM Employee ORDER BY name ASC

/* Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than 2000  per month
 who have been employees for less than 10 months. Sort your result by ascending employee_id. */
 SELECT name FROM Employee WHERE salary >2000 AND months <10 ORDER BY employee_id ASC;

/* 
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. 
Output one of the following statements for each record in the table:

Equilateral: It's a triangle with 3 sides of equal length.
Isosceles: It's a triangle with 2 sides of equal length.
Scalene: It's a triangle with 3 sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
*/

SELECT A, B, C,  -- Select columns explicitly instead of using *
CASE
    WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
    WHEN A = B AND B = C THEN 'Equilateral'
    WHEN A = B OR B = C OR A = C THEN 'Isosceles'
    ELSE 'Scalene'
END AS Triangle_Type  -- Use a safer alias name
FROM triangles;

/*
Given the CITY and COUNTRY tables, 
query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) 
rounded down to the nearest integer.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/

-- Lo primero que voy hacer es unir las tablas por una PK.

SELECT DISTINCT COUNTRY.Continent, FLOOR(AVG(CITY.Population) AS 'avg')
FROM CITY
INNER JOIN COUNTRY
ON city.COUNTRYCODE = COUNTRY.Code
GROUP BY COUNTRY.Continent;


-- Query the average population for all cities in CITY, rounded down to the nearest integer.
SELECT FLOOR(AVG(POPULATION)) AS 'AVG'
FROM hello_mysql.city;

-- Query a count of the number of cities in CITY having a Population larger than 100000.
SELECT COUNT(NAME) AS 'Pop >100000' FROM hello_mysql.city WHERE POPULATION > 3000000;
SELECT COUNT(CITY) AS 'Pop >100000' FROM CITY WHERE POPULATION > 100000 

-- Query the total population of all cities in CITY where District is California.
SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'California'

-- Query the average population of all cities in CITY where District is California.
SELECT AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';

-- Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
SELECT SUM(POPULATION)
FROM CITY
WHERE COUNTRYCODE = 'JPN';

-- Query the difference between the maximum and minimum populations in CITY.
SELECT MAX(POPULATION) - MIN(POPULATION) AS 'Diference'
FROM hello_mysql.city

/* 
Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of 2 decimal places. = (Sum of LAT_N
The sum of all values in LONG_W rounded to a scale of 2 decimal places.
*/

SELECT ROUND(SUM(LAT_N),2) AS 'LAT_N', ROUND(SUM(LONG_W),2) AS 'LONG_W'
FROM STATION

/*
Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's 0 key was broken 
until after completing the calculation. She wants your help finding the difference between her miscalculation 
(using salaries with any zeros removed), and the actual average salary.

Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.
*/

SELECT CEIL((AVG(Salary)) - (AVG(REPLACE(Salary, '0','')))) AS avg_salary FROM EMPLOYEES;


/*
We define an employee's total earnings to be their monthly salary x months worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. 
Then print these values as 2 space-separated integers.
earnings = monthly salary x months worked
max_totearnings = MAX(salary) FROM Employee
*/

SELECT 
	MAX(salary * months) AS max_earnings,
    COUNT(*) AS tot_maxearinings
FROM hello_mysql.employee
WHERE salary * months = (SELECT MAX(salary*months) FROM hello_mysql.employee);



/*
Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 387880 and less than 1372345. Truncate your answer to 4 decimal places.
*/

SELECT TRUNCATE(SUM(LAT_N),4)
FROM STATION 
WHERE LAT_N BETWEEN 38.7880 AND 137.2345;

/*
Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to 4 decimal places.
*/

SELECT TRUNCATE(MAX(LAT_N),4)
FROM STATION
WHERE LAT_N < 137.2345;

/*
Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than  137.2345. Round your answer to  decimal places.
*/

SELECT ROUND(LONG_W,4)
FROM STATION
WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N < 137.2345)
