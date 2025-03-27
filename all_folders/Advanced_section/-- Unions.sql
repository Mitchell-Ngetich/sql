-- Unions
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    jan_jobs
UNION
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    feb_jobs
UNION
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    mar_jobs -- UNION ALL
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    jan_jobs
UNION
ALL
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    feb_jobs
UNION
ALL
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    mar_jobs -- Practide problems
    /*
     Get the corresponding skill and skill type for each job posting in q1
     -include those without any skills too
     - Why? look at the skills and the type for each job in the
     first quarter that has a salary > 70,000 
     */
SELECT
    jj.job_id,
    jj.job_title_short,
    sd.skills,
    sd.type
FROM
    jan_jobs jj
    LEFT JOIN skills_job_dim sjd ON jj.job_id = sjd.job_id
    LEFT JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jj.salary_year_avg > 70000
UNION
ALL
SELECT
    fj.job_id,
    fj.job_title_short,
    sd.skills,
    sd.type
FROM
    feb_jobs fj
    LEFT JOIN skills_job_dim sjd ON fj.job_id = sjd.job_id
    LEFT JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    fj.salary_year_avg > 70000
UNION
ALL
SELECT
    mj.job_id,
    mj.job_title_short,
    sd.skills,
    sd.type
FROM
    mar_jobs mj
    LEFT JOIN skills_job_dim sjd ON mj.job_id = sjd.job_id
    LEFT JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    mj.salary_year_avg > 70000;