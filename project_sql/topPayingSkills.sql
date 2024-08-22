/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_of_salary
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg is not NULL  
    and job_title_short = 'Data Analyst' 
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_of_salary DESC
LIMIT 30

/*
	•	Data and Cloud Technologies Dominate: Skills related to data engineering, cloud platforms, and data analysis tools are highly valued, reflecting the growing importance of data-driven decision-making and cloud computing in the tech industry.
	•	DevOps and Software Development: Expertise in DevOps tools and modern programming languages is crucial, emphasizing the demand for continuous integration, deployment practices, and efficient software development processes.
	•	AI, Machine Learning, and Databases: Skills in artificial intelligence, machine learning, and database management are in high demand, highlighting the importance of these areas in shaping the future of technology.
*/
