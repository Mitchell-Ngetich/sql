/*Question: What are the top-paying data analyst jobs?  
 a) Identify the top 10 highest-paying Data Analyst 
 roles that are available remotely.  
 b) Focuses on job postings with specified 
 salaries (nulls).  
 Why? Highlight the top-paying opportunities for Data
 Analysts, offering insights into employment trends. 
 */
SELECT
    jpf.job_id,
    cd.name AS company_name,
    jpf.job_title,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.salary_year_avg,
    jpf.job_posted_date
FROM
    job_postings_fact jpf
    LEFT JOIN company_dim cd ON cd.company_id = jpf.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;

SELECT
    jpf.job_id,
    cd.name AS company_name,
    jpf.job_title,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.salary_year_avg,
    jpf.job_posted_date
FROM
    job_postings_fact jpf
    LEFT JOIN company_dim cd ON cd.company_id = jpf.company_id
WHERE
    job_title_short = 'Data Engineer'
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;