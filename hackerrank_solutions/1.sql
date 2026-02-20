/*
    Platform    : HackerRank
    Difficulty  : Easy

        Challenge   : Query all columns for all American cities in the CITY
                  table with a population larger than 100,000.
                  The CountryCode for America is 'USA'.

    Table       : CITY
    ┌─────────────┬──────────────┐
    │ Field       │ Type         │
    ├─────────────┼──────────────┤
    │ ID          │ NUMBER       │
    │ NAME        │ VARCHAR2(17) │
    │ COUNTRYCODE │ VARCHAR2(3)  │
    │ DISTRICT    │ VARCHAR2(20) │
    │ POPULATION  │ NUMBER       │
    └─────────────┴──────────────┘
=============================================================================
*/


/*
-----------------------------------------------------------------------------
   SOLUTION
-----------------------------------------------------------------------------
   Question : Retrieve all columns for every American city (COUNTRYCODE = 'USA')
              that has a population greater than 100,000.

   Logic    : We need TWO conditions to both be TRUE at the same time:
                  1. COUNTRYCODE must equal 'USA'
                  2. POPULATION must be greater than 100,000

              We combine both conditions using AND — meaning a row only
              appears in the result if it satisfies BOTH conditions.

   Operator Used:
              AND  → both conditions must be true
              =    → exact match
              >    → greater than (does NOT include 100,000 itself)

   Note     : Use single quotes ' ' for text values in SQL.
              Double quotes " " can cause errors in some databases.
-----------------------------------------------------------------------------
*/

SELECT *
FROM CITY
WHERE COUNTRYCODE = 'USA'
  AND POPULATION > 100000;