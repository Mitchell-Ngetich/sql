/*
 Question: What are the most in-demand skills for data analysts?
 - Join job postings to inner join table similar to query 2
 - Identify the top 5 in-demand skills for a data analyst.
 - Focus on all job postings.
 Why? Retrieves the top 5 skills with the highest demand in the job market,  
 providing insights into the most valuable skills for job seekers.
 */
WITH top_demand_skills AS (
    SELECT
        COUNT(*) AS skill_count,
        sd.skills
    FROM
        job_postings_fact jpf
        INNER JOIN skills_job_dim sjd ON sjd.job_id = jpf.job_id
        INNER JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
    WHERE
        jpf.job_title_short = 'Data Analyst'
        AND jpf.job_work_from_home = True
    GROUP BY
        sd.skills
    ORDER BY
        skill_count DESC
    LIMIT
        5
)
SELECT
    skills,
    skill_count
FROM
    top_demand_skills
    /*
     Results
     sql
     excel
     python
     tableau
     power bi
     */