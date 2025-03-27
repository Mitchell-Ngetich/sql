/*
 Question: What skills are required for the top-paying data analyst jobs?
 - Use the top 10 highest-paying Data Analyst jobs from first query
 - Add the specific skills required for these roles
 Why? It provides a detailed look at which high-paying jobs demand certain skills,
 helping job seekers understand which skills to develop that align with top salaries
 */
WITH top_paying_skills AS(
    SELECT
        jpf.job_id,
        cd.name AS company_name,
        jpf.job_title,
        jpf.salary_year_avg
    FROM
        job_postings_fact jpf
        LEFT JOIN company_dim cd ON cd.company_id = jpf.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
    ORDER BY
        jpf.salary_year_avg DESC
    LIMIT
        10
)
SELECT
    tps.*, -- selects all columns in tps table
    sd.skills
FROM
    top_paying_skills tps
    INNER JOIN skills_job_dim sjd ON sjd.job_id = tps.job_id
    INNER JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
ORDER BY
    salary_year_avg;