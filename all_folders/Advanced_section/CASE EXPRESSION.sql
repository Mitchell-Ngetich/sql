-- CASE EXPRESSION
WITH job_categories AS (
    SELECT job_id,
        CASE
            WHEN job_location = 'Anywhere' THEN 'Remote'
            WHEN job_location = 'New York, NY' THEN 'Local'
            ELSE 'Onsite'
        END AS location_category
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst'
)
SELECT 
    location_category,
    COUNT(job_id) AS number_of_jobs
FROM job_categories
GROUP BY location_category;

-- Practise Problem

WITH job_interest AS(
    SELECT 
        job_title_short,
        salary_year_avg,
        job_country,
    CASE
        WHEN salary_year_avg <= 100000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 100000 AND 200000 THEN 'Standard'
        WHEN salary_year_avg >= 200000 THEN 'High'
        ELSE 'null_salary'
    END AS salary_bracket
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
)
SELECT *
FROM job_interest
ORDER BY salary_year_avg DESC;