/*
=============================================================================
        HACKERRANK SQL CHALLENGES - CITY & STATION TABLE SOLUTIONS
=============================================================================
    Platform    : HackerRank
    Difficulty  : Easy

    About       : This file contains all my HackerRank SQL solutions
                  solved from scratch as part of my self-learning journey.
                  Every solution here is written and understood by me.
                  New solutions will keep getting added to this file.

    Tables      : CITY
                  ┌─────────────┬──────────────┐
                  │ Field       │ Type         │
                  ├─────────────┼──────────────┤
                  │ ID          │ NUMBER       │
                  │ NAME        │ VARCHAR2(17) │
                  │ COUNTRYCODE │ VARCHAR2(3)  │
                  │ DISTRICT    │ VARCHAR2(20) │
                  │ POPULATION  │ NUMBER       │
                  └─────────────┴──────────────┘

                  STATION
                  ┌─────────┬──────────────┐
                  │ Field   │ Type         │
                  ├─────────┼──────────────┤
                  │ ID      │ NUMBER       │
                  │ CITY    │ VARCHAR2(21) │
                  │ STATE   │ VARCHAR2(2)  │
                  │ LAT_N   │ NUMBER       │
                  │ LONG_W  │ NUMBER       │
                  └─────────┴──────────────┘

    Solutions Index:
        ── CITY TABLE ──
        1.  Select All Rows and Columns
        2.  American Cities with Population > 100,000
        3.  Names of American Cities with Population > 120,000
        4.  City with ID = 1661
        5.  All Japanese Cities (All Columns)
        6.  Names of All Japanese Cities

        ── STATION TABLE ──
        7.  List of City and State
        8.  Cities with Even ID (No Duplicates)
        9.  Difference Between Total and Distinct City Count
        10. Shortest and Longest City Names
=============================================================================
*/




/*
=============================================================================
   ── CITY TABLE SOLUTIONS ──
=============================================================================
*/




/* ==========================================================================
   SOLUTION 1 — Query All Columns for Every Row
   ==========================================================================
   Challenge : Query ALL columns for EVERY row in the CITY table.
               No filters, no conditions — just the entire table.

   Logic     : The simplest SQL query possible — no WHERE filter needed
               because we want ALL rows with NO conditions.
               SELECT * means "give me every column" (wildcard).

   When to use SELECT *:
               Great for quick exploration to see what the full table
               looks like. In production code, always try to select
               only the columns you need — faster and cleaner.
   ========================================================================== */

SELECT *
FROM CITY;




/* ==========================================================================
   SOLUTION 2 — All American Cities with Population > 100,000
   ==========================================================================
   Challenge : Query all columns for all American cities in the CITY
               table with a population larger than 100,000.
               The CountryCode for America is 'USA'.

   Logic     : Two conditions must BOTH be TRUE using AND:
                   1. COUNTRYCODE = 'USA'
                   2. POPULATION  > 100000

   Operators Used:
               AND  → both conditions must be true simultaneously
               =    → exact text match
               >    → strictly greater than (100,000 itself is excluded)

   Note      : Always use single quotes ' ' for text values in SQL.
               Double quotes " " can cause errors in some databases.
   ========================================================================== */

SELECT *
FROM CITY
WHERE COUNTRYCODE = 'USA'
  AND POPULATION > 100000;




/* ==========================================================================
   SOLUTION 3 — Names of American Cities with Population > 120,000
   ==========================================================================
   Challenge : Query ONLY the NAME field for all American cities in the
               CITY table with a population larger than 120,000.
               The CountryCode for America is 'USA'.

   Difference from Solution 2:
               Solution 2 → SELECT *     (returned ALL columns)
               This one   → SELECT NAME  (returns ONLY the city name)
               Good practice — only pull the data you actually need!

   Logic     : Same two conditions with AND, just a higher population
               threshold (120,000 instead of 100,000) and one column selected.
   ========================================================================== */

SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'USA'
  AND POPULATION > 120000;




/* ==========================================================================
   SOLUTION 4 — Query a Single City by ID
   ==========================================================================
   Challenge : Query all columns for the city in the CITY table
               with the ID value of 1661.

   Logic     : Use WHERE with = to match one specific ID number.
               Since ID is a NUMBER type, no quotes are needed around 1661.

   Key Point : ID is a unique identifier — so this query will return
               exactly ONE row (or none if the ID doesn't exist).
   ========================================================================== */

SELECT *
FROM CITY
WHERE ID = 1661;




/* ==========================================================================
   SOLUTION 5 — All Japanese Cities (All Columns)
   ==========================================================================
   Challenge : Query all attributes (columns) of every Japanese city
               in the CITY table. The COUNTRYCODE for Japan is 'JPN'.

   Logic     : Filter by COUNTRYCODE = 'JPN' to get only Japanese cities.
               SELECT * returns every column for those matching rows.

   Note      : COUNTRYCODE is VARCHAR2(3) — a 3-character text field,
               so we wrap 'JPN' in single quotes.
   ========================================================================== */

SELECT *
FROM CITY
WHERE COUNTRYCODE = 'JPN';




/* ==========================================================================
   SOLUTION 6 — Names of All Japanese Cities
   ==========================================================================
   Challenge : Query ONLY the names of all Japanese cities in the CITY table.
               The COUNTRYCODE for Japan is 'JPN'.

   Difference from Solution 5:
               Solution 5 → SELECT *     (all columns for Japanese cities)
               This one   → SELECT NAME  (only the city name column)

   Logic     : Same WHERE filter as Solution 5, but we only select NAME.
               This is more efficient — we return only what we need.
   ========================================================================== */

SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'JPN';




/*
=============================================================================
   ── STATION TABLE SOLUTIONS ──
=============================================================================
*/




/* ==========================================================================
   SOLUTION 7 — List of City and State
   ==========================================================================
   Challenge : Query a list of CITY and STATE from the STATION table.

   Logic     : No filter needed — we want every row.
               We select only the two columns we care about: CITY and STATE.

   Good Habit: Instead of SELECT *, we name the exact columns we need.
               This is faster and clearer, especially on large tables.
   ========================================================================== */

SELECT CITY, STATE
FROM STATION;




/* ==========================================================================
   SOLUTION 8 — Cities with Even ID Numbers (No Duplicates)
   ==========================================================================
   Challenge : Query a list of CITY names from STATION for cities that
               have an even ID number. Exclude duplicates from the result.

   Logic     : Two things happening here:
                   1. ID % 2 = 0  → The modulo operator (%) gives the
                      remainder after division. If ID divided by 2 has
                      a remainder of 0, the number is even.
                      Examples: 2, 4, 6, 8... are even (remainder = 0)
                                1, 3, 5, 7... are odd  (remainder = 1)

                   2. DISTINCT     → Removes duplicate city names so
                      each city appears only once in the result.

   New Concept — Modulo (%):
               Think of it like: "Does this number divide evenly by 2?"
               If yes (remainder = 0), it's even → include it.
   ========================================================================== */

SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 = 0;




/* ==========================================================================
   SOLUTION 9 — Difference Between Total and Distinct City Count
   ==========================================================================
   Challenge : Find the difference between the total number of CITY entries
               and the number of distinct (unique) CITY entries in STATION.

   Logic     : COUNT(CITY)          → counts ALL city entries including repeats
               COUNT(DISTINCT CITY) → counts only UNIQUE city names
               Subtracting them tells us how many duplicates exist.

   Example   : If there are 10 total cities but only 7 unique names,
               the answer is 10 - 7 = 3 (3 duplicate entries).

   New Concept — COUNT():
               COUNT(column)          → total non-null rows
               COUNT(DISTINCT column) → total unique non-null values
   ========================================================================== */

SELECT COUNT(CITY) - COUNT(DISTINCT CITY)
FROM STATION;




/* ==========================================================================
   SOLUTION 10 — Shortest and Longest City Names
   ==========================================================================
   Challenge : Query the two cities with the shortest and longest CITY names
               in STATION, along with their name lengths. If there is more
               than one city with the same shortest or longest length, pick
               the one that comes first alphabetically.

   Logic     : We need TWO separate results (shortest + longest) combined
               into one output. We use UNION to merge them.

               Query 1 → Sort by LENGTH(CITY) ASC  then CITY ASC → LIMIT 1
                         Gets the shortest name; alphabetical tiebreaker.

               Query 2 → Sort by LENGTH(CITY) DESC then CITY ASC → LIMIT 1
                         Gets the longest name; alphabetical tiebreaker.

   New Concepts:
               LENGTH(CITY) → returns the number of characters in the name
               UNION        → combines results of two SELECT queries into one
               LIMIT 1      → restricts each sub-query to return just 1 row

   Note      : LIMIT works in MySQL. In SQL Server use TOP 1 instead.
   ========================================================================== */

(SELECT CITY, LENGTH(CITY)
 FROM STATION
 ORDER BY LENGTH(CITY) ASC, CITY ASC
 LIMIT 1)

UNION

(SELECT CITY, LENGTH(CITY)
 FROM STATION
 ORDER BY LENGTH(CITY) DESC, CITY ASC
 LIMIT 1);




