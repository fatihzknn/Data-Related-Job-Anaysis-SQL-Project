/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/
WITH top_paying_10_job AS(
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
LIMIT 10
)
Select 
    top_paying_10_job.*,
    skills_dim.skills
FROM
    top_paying_10_job
INNER JOIN 
    skills_job_dim on top_paying_10_job.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    skills_dim.skills is not NULL

/*
Skills Required:
	•	The most common skills required for this high-paying role include:
	•	SQL: Essential for data manipulation and querying.
	•	Python: Widely used for data analysis, scripting, and automation.
	•	R: Popular for statistical analysis and data visualization.
	•	Azure: Cloud computing skills, indicating the importance of working with cloud platforms.
	•	Databricks: Knowledge of big data processing and analytics tools.
*/