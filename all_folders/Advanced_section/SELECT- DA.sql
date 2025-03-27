SELECT
    job_title_short AS title,
    job_location location,
    job_posted_date :: DATE date
FROM
    job_postings_fact;

SELECT
    job_title_short AS title,
    job_location location,
    job_posted_date date_time
FROM
    job_postings_fact
LIMIT
    5;

SELECT
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_zone
FROM
    job_postings_fact
LIMIT
    10;

-- First AT TIME ZONE 'UTC' says "this timestamp is in UTC",Second AT TIME ZONE 'EST' converts it to Eastern Time
-- EXTRACT
SELECT
    EXTRACT(
        MONTH
        FROM
            job_posted_date
    ) AS job_month,
    EXTRACT(
        YEAR
        FROM
            job_posted_date
    ) AS job_year
FROM
    job_postings_fact
LIMIT
    5;

-- Agg jobs according to their post month
SELECT
    COUNT(job_id) AS count,
    EXTRACT(
        MONTH
        FROM
            job_posted_date
    ) AS MONTH
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    MONTH
ORDER BY
    1 DESC;

SELECT
    job_schedule_type,
    AVG(salary_year_avg) AS avg_salary,
    AVG(salary_hour_avg) AS avg_hourly
FROM
    job_postings_fact
WHERE
    job_posted_date >= '2023-06-01'
GROUP BY
    job_schedule_type;

SELECT
    COUNT(job_id),
    EXTRACT(
        MONTH
        FROM
            job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'
    ) AS MONTH,
    TO_CHAR(
        job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST',
        'Month'
    ) AS month_name -- extracts month name
FROM
    job_postings_fact
WHERE
    job_posted_date >= '2023-01-01'
    AND job_posted_date < '2024-01-01'
GROUP BY
    MONTH,
    month_name
ORDER BY
    MONTH;

-- Quiz 3
SELECT
    cd.name,
    TO_CHAR(jpf.job_posted_date, 'Month') AS month_name
FROM
    company_dim cd
    LEFT JOIN job_postings_fact jpf ON cd.company_id = jpf.company_id
WHERE
    EXTRACT(
        MONTH
        FROM
            jpf.job_posted_date
    ) IN (4, 5, 6) -- TRIM(TO_CHAR(jpf.job_posted_date, 'Month')) IN ('April','May','June') -> works also
    AND jpf.job_health_insurance = TRUE
ORDER BY
    month_name;

-- Creating a table from the combined 3 tables
-- JAN
CREATE TABLE jan_jobs AS
SELECT *
FROM
    job_postings_fact
WHERE
    EXTRACT(MONTH FROM job_posted_date) = 1;

-- FEB
CREATE TABLE feb_jobs AS
SELECT *
FROM
    job_postings_fact
WHERE
    EXTRACT(MONTH FROM job_posted_date) = 2;

-- MARCH
CREATE TABLE mar_jobs AS
SELECT *
FROM
    job_postings_fact
WHERE
    EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM mar_jobs
LIMIT 5;