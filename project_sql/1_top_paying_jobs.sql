/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT
    j.job_id,
    j.job_title,
    c.name as CompanyName,
    j.job_location,
    j.job_schedule_type,
    j.salary_year_avg,
    j.job_posted_date
FROM
    job_postings_fact as j
Left JOIN
    company_dim c On j.company_id = c.company_id
WHERE
    job_title_short = 'Data Analyst' and 
    salary_year_avg is not NULL AND
    job_location = 'Anywhere'
ORDER BY
    salary_year_avg  DESC
LIMIT 10;



