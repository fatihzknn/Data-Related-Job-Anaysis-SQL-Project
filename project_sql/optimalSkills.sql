/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/



With demand_skills AS(
    SELECT
        skills_dim.skill_id as skill_id,
        skills_dim.skills,
        Count(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN 
        skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg is not NULL AND
        job_work_from_home = True
    GROUP BY
        skills_dim.skill_id
), average_salary AS(
    SELECT
        skills_job_dim.skill_id as skill_id,
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
        skills_job_dim.skill_id
)
SELECT 
    demand_skills.skill_id,
    demand_skills.skills,
    demand_count,
    average_salary.avg_of_salary
FROM
    demand_skills
INNER JOIN
    average_salary ON demand_skills.skill_id = average_salary.skill_id
WHERE
    demand_count>10
ORDER BY
    avg_of_salary DESC,
    demand_count DESC
LIMIT 25


/*
	1.	High Demand for Data-Related Skills: Skills like Python and Tableau show exceptionally high demand, indicating that data analysis, manipulation, and visualization are critical in today’s job market. These skills are foundational for roles in data science, analytics, and business intelligence.
	2.	Cloud Technologies on the Rise: Snowflake, Azure, AWS, and BigQuery are prominent cloud technologies with substantial demand and competitive salaries, reflecting the ongoing shift toward cloud-based solutions in organizations.
	3.	Traditional Programming Languages Remain Relevant: Despite the emergence of new technologies, traditional programming languages like Java and C++ continue to be in demand, showcasing their continued relevance in software development and enterprise applications.
*/