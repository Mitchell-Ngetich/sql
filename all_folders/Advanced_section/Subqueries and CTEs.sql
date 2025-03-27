-- Subqueries and CTEs
--1. CTEs
WITH january_jobs AS(
    SELECT
        *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(
            MONTH
            FROM
                job_posted_date
        ) = 1
)
SELECT
    *
FROM
    january_jobs 

-- 2. 

WITH company_job_count AS(
    SELECT
        company_id,
        COUNT(*) AS job_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT
    cd.name AS company_name,
    cjc.job_count
FROM
    company_dim cd
    LEFT JOIN company_job_count cjc ON cjc.company_id = cd.company_id
WHERE
    job_count > 1000
ORDER BY
    job_count DESC;

-- 2.Subqueries
SELECT
    name AS company_name
FROM
    company_dim
WHERE
    company_id IN (
        SELECT
            company_id
        FROM
            job_postings_fact
        WHERE
            job_no_degree_mention = true
    ) 
;

--3. Practice Problems
SELECT sd.skills,
    skills_required.skill_count
FROM skills_dim sd
JOIN(
    SELECT skill_id,
        COUNT(skill_id) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
)AS skills_required ON sd.skill_id = skills_required.skill_id
ORDER BY skill_count DESC
LIMIT 5; 

-- Practise Problem 2

WITH company_size AS(
    SELECT  
        company_id,
        COUNT(job_id) AS job_count,
        CASE
            WHEN COUNT(job_id) < 10 THEN 'Small'
            WHEN COUNT(job_id) BETWEEN 10 AND 50 THEN 'Medium'
            ELSE 'Large'
        END AS company_category
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT 
    cd.name AS company_name,
    cs.company_category,
    COALESCE(cs.job_count,0) AS job_count
FROM company_dim cd
LEFT JOIN company_size cs
    ON cd.company_id = cs.company_id
ORDER BY cs.job_count DESC;

-- Another solution
WITH company_size AS(
    SELECT 
        jpf. company_id,
        COUNT(DISTINCT jpf.job_id) AS job_count
    FROM job_postings_fact AS jpf
    GROUP BY company_id
) 
SELECT 
    cd.name AS company_name,
    COALESCE(cs.job_count, 0) AS number_of_postings,
    CASE
        WHEN COALESCE(cs.job_count, 0) < 10 THEN 'Small'
        WHEN COALESCE(cs.job_count, 0) BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_category
FROM company_dim cd
LEFT JOIN company_size cs
    ON cd.company_id = cd.company_id
ORDER BY cs.job_count DESC;

-- PP 3PPPPPPP 
/*
Find the count of the number of remote job postings per skill
    -Display the top 5 skills by their demand in remote jobs
    -Include skill id,name,and count of postings requiring the skill
*/

WITH job_search AS(
    SELECT 
        sjd.skill_id,
        COUNT(*) AS skills_count
    FROM job_postings_fact jpf
    INNER JOIN
        skills_job_dim sjd ON jpf.job_id = sjd.job_id
    WHERE jpf.job_work_from_home = True 
        AND jpf.job_title_short = 'Data Analyst'
    GROUP BY sjd.skill_id
)
SELECT 
    sd.skill_id,
    sd.skills AS skill_name,
    js.skills_count AS remote_job_count
FROM skills_dim sd
INNER JOIN job_search js
    ON sd.skill_id = js.skill_id
ORDER BY remote_job_count DESC
LIMIT 5;
