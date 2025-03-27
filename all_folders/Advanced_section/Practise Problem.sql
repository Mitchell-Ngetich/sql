-- Practise Problem
/*
 Find job postings from the 1st quarter that have salary than 70k
 - combine job postings tables from the 1st quarter
 - get job postings with an avg yearly salary > 70k
 */
WITH first_quarter_jobs AS (
    SELECT
        *
    FROM
        jan_jobs
    UNION
    ALL
    SELECT
        *
    FROM
        feb_jobs
    UNION
    ALL
    SELECT
        *
    FROM
        mar_jobs
)
SELECT
    job_title_short,
    job_location,
    salary_year_avg
FROM
    first_quarter_jobs
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg > 70000
ORDER BY
    salary_year_avg DESC;