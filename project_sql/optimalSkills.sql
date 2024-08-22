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
LIMIT 25;


-- rewriting this same query more concisely
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;


/*
	Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
High-Demand Programming Languages: Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
Cloud Tools and Technologies: Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
Business Intelligence and Visualization Tools: Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
Database Technologies: The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.
