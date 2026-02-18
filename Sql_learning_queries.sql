/*
=============================================================================
        SQL FUNDAMENTALS - COMPLETE LEARNING GUIDE
=============================================================================
        About       : I built this guide from scratch while learning SQL on my own.
                  Every query here is something I wrote, tested, and understood
                  myself. I'm sharing it publicly so anyone at any level can
                  use it as a reference or a starting point.

    How to use  : The database setup is included in this repo under
                  init-sqlserver-salesdb — run that first to create and
                  populate the tables, then you can execute any query
                  in this file straight away.

    Topics      :
        1. SELECT *          - Retrieve ALL columns
        2. FROM              - Where to find your data
        3. SELECT columns    - Pick only what you need
        4. WHERE             - Filter rows by condition
        5. ORDER BY          - Sort results ASC or DESC
        6. GROUP BY          - Group and summarize data
        7. HAVING            - Filter after aggregation
        8. DISTINCT          - Remove duplicate values
        9. TOP / LIMIT       - Restrict rows returned

    Tables      : customers ( id, first_name, country, score )
                  orders    ( id, customer_id, order_date, amount )

    Note        : If anything is unclear or could be improved, feel free
                  to open an issue or fork the repo — that's the point!
=============================================================================
*/




/* ==========================================================================
   1. SELECT *  (ALL)
   ==========================================================================
   What it does:
       SELECT * means "give me EVERYTHING" — every single column
       that exists in the table. The asterisk (*) is a wildcard
       symbol that represents all columns.

   When to use it:
       Great for quick exploration when you don't yet know what
       columns exist or want to see the full raw data.

   When NOT to use it:
       Avoid SELECT * in production code. It pulls unnecessary data,
       which slows down your queries on large tables.

   Syntax:
       SELECT *
       FROM table_name;
   ========================================================================== */

/*
   Question : Retrieve everything from the customers table.
   Answer   : Use SELECT * to grab all columns and all rows.
*/
SELECT *
FROM customers;




/* ==========================================================================
   2. FROM
   ==========================================================================
   What it does:
       FROM tells SQL *where* to look for your data — which table
       to read from. You almost always use it right after SELECT.

   Think of it like:
       SELECT = "I want..."
       FROM   = "...from this place."

   Syntax:
       SELECT column_name
       FROM table_name;
   ========================================================================== */

/*
   Question : Retrieve all data from the customers table.
   Answer   : Combine SELECT * with FROM customers.
*/
SELECT *
FROM customers;




/* ==========================================================================
   3. SELECT (Specific Columns)
   ==========================================================================
   What it does:
       Instead of grabbing ALL columns with *, you list only the
       column names you actually need. This makes your query faster,
       cleaner, and easier to read.

   Key Rule:
       The ORDER you list the columns is the ORDER they appear
       in your results. Swap them around and the display changes too!

   Syntax:
       SELECT
           column1,
           column2,
           column3
       FROM table_name;
   ========================================================================== */

/*
   Question : Retrieve each customer's first name, country, and score.
   Answer   : List only those three columns after SELECT.
*/
SELECT
    first_name,
    country,
    score
FROM
    customers;


/*
   Question : What happens if we change the column order?
   Answer   : The result display will also change — score appears first now.
              The data itself doesn't change, only how it's presented.
*/
SELECT
    score,
    first_name,
    country
FROM
    customers;




/* ==========================================================================
   4. WHERE
   ==========================================================================
   What it does:
       WHERE acts like a filter. It only returns rows where your
       condition is TRUE. Rows that don't match are excluded.

   Common operators:
       =    equals
       !=   not equal (some databases use <>)
       >    greater than
       <    less than
       >=   greater than or equal to
       <=   less than or equal to

   Syntax:
       SELECT *
       FROM table_name
       WHERE condition;

   Important:
       Text values must be wrapped in single quotes: 'Germany'
       Numbers do NOT need quotes: score != 0
   ========================================================================== */

/*
   Question : Retrieve all customers with a score not equal to 0.
   Answer   : Use != to exclude rows where score is zero.
*/
SELECT *
FROM customers
WHERE score != 0;


/*
   Question : Retrieve all customers from Germany.
   Answer   : Filter by country using = and wrap the text in single quotes.
*/
SELECT *
FROM customers
WHERE country = 'Germany';


/*
   Question : Retrieve all customers NOT from Germany.
   Answer   : Use != to exclude Germany from the results.
*/
SELECT *
FROM customers
WHERE country != 'Germany';


/*
   Question : Retrieve only first_name and id for customers NOT from Germany.
   Answer   : Combine column selection with a WHERE filter.
*/
SELECT
    first_name,
    id
FROM customers
WHERE country != 'Germany';


/*
   Question : Retrieve customers where score is not equal to 0,
              showing only first_name and country.
   Answer   : Select specific columns and apply a WHERE condition.
*/
SELECT
    first_name,
    country
FROM
    customers
WHERE score != 0;




/* ==========================================================================
   5. ORDER BY
   ==========================================================================
   What it does:
       ORDER BY sorts your result set either from low-to-high (ASC)
       or high-to-low (DESC).

   Default behavior:
       If you don't write ASC or DESC, SQL defaults to ASC (ascending).

   Key Terms:
       ASC  = Ascending  = lowest to highest  (A → Z, 0 → 100)
       DESC = Descending = highest to lowest  (Z → A, 100 → 0)

   You can also sort by MULTIPLE columns — SQL sorts by the first
   column, then breaks ties using the second column.

   Syntax:
       SELECT *
       FROM table_name
       ORDER BY column_name ASC|DESC;
   ========================================================================== */

/*
   Question : Retrieve all customers and sort by the highest score first.
   Answer   : Use ORDER BY score DESC.
*/
SELECT *
FROM customers
ORDER BY score DESC;


/*
   Question : Retrieve all customers and sort by the lowest score first.
   Answer   : Use ORDER BY score ASC (or just ORDER BY score).
*/
SELECT *
FROM customers
ORDER BY score ASC;


/*
   Question : Retrieve first_name and country for customers with
              a score of 500 or less, sorted by highest score first.
   Answer   : Combine WHERE with ORDER BY DESC.
*/
SELECT
    first_name,
    country
FROM customers
WHERE score <= 500
ORDER BY score DESC;


/*
   Question : Retrieve first_name and country for customers with score = 0,
              sorted descending (all zeros, so order won't visually change).
   Answer   : Filter score = 0 then sort DESC.
*/
SELECT
    first_name,
    country
FROM customers
WHERE score = 0
ORDER BY score DESC;


/*
   Question : Retrieve first_name and country for customers with score != 0,
              sorted descending.
   Answer   : Exclude zero scores and sort highest first.
*/
SELECT
    first_name,
    country
FROM customers
WHERE score != 0
ORDER BY score DESC;


/*
   Question : Retrieve all customers sorted by country (A-Z), then within
              each country, sorted by the highest score first.
   Answer   : Use multiple columns in ORDER BY — country ASC, score DESC.
              SQL sorts by country first, then uses score to break ties.
*/
SELECT *
FROM customers
ORDER BY
    country ASC,
    score DESC;




/* ==========================================================================
   6. GROUP BY
   ==========================================================================
   What it does:
       GROUP BY takes rows that share the same value in a column
       and combines (collapses) them into a single summary row.

   It is ALWAYS used with aggregate functions like:
       SUM()   - adds up values
       COUNT() - counts rows
       AVG()   - calculates the average
       MAX()   - finds the maximum
       MIN()   - finds the minimum

   Think of it like:
       "Summarize my data by [this category]."

   Rule:
       Every column in your SELECT that is NOT inside an aggregate
       function MUST appear in your GROUP BY clause.

   Syntax:
       SELECT
           column_to_group_by,
           AGG_FUNCTION(another_column) AS alias
       FROM table_name
       GROUP BY column_to_group_by;
   ========================================================================== */

/*
   Question : Find the total score for each country.
   Answer   : Group rows by country and SUM the scores.
              AS Total_score gives the result column a friendly name (alias).
*/
SELECT
    country,
    SUM(score) AS Total_score
FROM
    customers
GROUP BY
    country;


/*
   Question : Find the total score per country AND per customer name,
              sorted by the highest total score first.
   Answer   : Group by both country AND first_name, then ORDER BY the alias.
*/
SELECT
    country,
    first_name,
    SUM(score) AS Total_score
FROM
    customers
GROUP BY
    country,
    first_name
ORDER BY Total_score DESC;


/*
   Question : Find the total score and total number of customers for each country.
   Answer   : Use both SUM() for score and COUNT() for the number of customers.
              COUNT(id) counts how many rows exist per group.
*/
SELECT
    country,
    SUM(score)  AS total_score,
    COUNT(id)   AS customers
FROM customers
GROUP BY country;




/* ==========================================================================
   7. HAVING
   ==========================================================================
   What it does:
       HAVING filters your results AFTER grouping and aggregation.
       It works just like WHERE, but for grouped/aggregated data.

   !!!  VERY IMPORTANT CONCEPT  !!!
   ─────────────────────────────────────────────────────────────────────────
       WHERE  → filters BEFORE aggregation  (filters individual rows)
       HAVING → filters AFTER  aggregation  (filters grouped results)
   ─────────────────────────────────────────────────────────────────────────

   You CANNOT use WHERE to filter on SUM(), AVG(), etc.
   You MUST use HAVING for that.

   Order of clauses (must follow this order):
       SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY

   Syntax:
       SELECT column, AGG_FUNCTION(col) AS alias
       FROM table_name
       GROUP BY column
       HAVING AGG_FUNCTION(col) condition;
   ========================================================================== */

/*
   Question : Find the total score per country, but only return countries
              where the total score is greater than 800.
   Answer   : Group by country, SUM the scores, then filter with HAVING.
*/
SELECT
    country,
    SUM(score) AS Total_score
FROM
    customers
GROUP BY
    country
HAVING SUM(score) > 800;


/*
   Question : Same as above, but also sort the results by Total_score
              from highest to lowest.
   Answer   : Add ORDER BY after HAVING.
*/
SELECT
    country,
    SUM(score) AS Total_score
FROM
    customers
GROUP BY
    country
HAVING SUM(score) > 800
ORDER BY Total_score DESC;


/*
   Question : Find the average score for each country, considering ONLY
              customers with a score not equal to 0, AND return only
              countries where the average score is greater than 430.
   Answer   : Use WHERE to pre-filter (before grouping) rows with score != 0,
              then GROUP BY country, then use HAVING to filter the average.

              Notice how WHERE and HAVING work TOGETHER here:
                - WHERE  removes zero-score rows first
                - HAVING then removes countries with avg <= 430
*/
SELECT
    country,
    AVG(score) AS Average_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430;




/* ==========================================================================
   8. DISTINCT
   ==========================================================================
   What it does:
       DISTINCT removes duplicate values and returns only unique results.
       If the same value appears 10 times, DISTINCT shows it just once.

   When to use it:
       When you want a unique list of values — e.g., what countries
       are in the table? What product categories exist?

   !! BAD HABIT WARNING !!
   ─────────────────────────────────────────────────────────────────────────
       Don't use DISTINCT unless it's truly necessary.
       It forces the database engine to sort and compare every row,
       which can significantly SLOW DOWN queries on large datasets.
       If your data already has no duplicates, you're wasting resources.
   ─────────────────────────────────────────────────────────────────────────

   Syntax:
       SELECT DISTINCT column_name
       FROM table_name;
   ========================================================================== */

/*
   Question : Return a unique list of all countries in the customers table.
   Answer   : Use SELECT DISTINCT to eliminate repeated country names.
*/
SELECT DISTINCT
    country
FROM customers;




/* ==========================================================================
   9. TOP (LIMIT)
   ==========================================================================
   What it does:
       TOP restricts the number of rows your query returns.
       Instead of getting 10,000 rows, you can say "just give me the top 5."

   Note on syntax differences by database:
       SQL Server / MS SQL → TOP (N)
       MySQL / PostgreSQL  → LIMIT N   (at the end of the query)

   Best practice:
       TOP / LIMIT is most useful when combined with ORDER BY,
       so you're not just getting random rows but the actual
       top/bottom N records based on a meaningful sort.

   Syntax (SQL Server):
       SELECT TOP N *
       FROM table_name
       ORDER BY column_name DESC;
   ========================================================================== */

/*
   Question : Retrieve only 3 customers (any 3 — no specific order).
   Answer   : Use TOP 3 to limit results to the first 3 rows returned.
*/
SELECT TOP 3
    *
FROM customers;


/*
   Question : Retrieve the top 3 customers with the highest scores.
   Answer   : Combine TOP 3 with ORDER BY score DESC so you get the
              3 highest-scoring customers, not just any 3.
*/
SELECT TOP 3
    *
FROM customers
ORDER BY score DESC;


/*
   Question : Retrieve the 2 customers with the lowest scores.
   Answer   : Use TOP 2 with ORDER BY score ASC (lowest first).
*/
SELECT TOP 2
    *
FROM customers
ORDER BY score ASC;


/*
   Question : Get the two most recent orders from the orders table.
   Answer   : Sort by order_date DESC (newest first) and take the TOP 2.
*/
SELECT TOP 2
    *
FROM orders
ORDER BY order_date DESC;


/*
=============================================================================
   END OF SQL FUNDAMENTALS GUIDE
=============================================================================
   Quick Reference Summary:

   Clause      Purpose                             Filter Timing
   ─────────── ─────────────────────────────────── ─────────────
   SELECT      Choose which columns to return      —
   FROM        Specify the source table            —
   WHERE       Filter rows by condition            Before aggregation
   GROUP BY    Group rows and summarize            After WHERE
   HAVING      Filter grouped results              After aggregation
   ORDER BY    Sort the results ASC or DESC        Last step
   DISTINCT    Return only unique values           —
   TOP/LIMIT   Limit how many rows are returned    —

   Pro Tip:
       The logical order SQL processes clauses is:
       FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → TOP/LIMIT

       Even though you WRITE SELECT first, it is evaluated near the end!
=============================================================================
*/