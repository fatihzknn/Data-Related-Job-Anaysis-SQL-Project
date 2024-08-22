# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql)
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from my SQL Course. It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:
### 1. Top Paying Data Analyst Jobs
```sql
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
```
Here's the breakdown of the top data analyst jobs in 2023:

- ***Wide Salary Range:*** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- ***Diverse Employers:*** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- ***Job Title Variety:*** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.
![Top Paying Role](assets/1_top_paying_roles.png)
Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
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
```
Here's  the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- ***SQL*** is leading with a bold count of 8.
- ***Python*** follows closely with a bold count of 7.
- ***Tableau*** is also highly sought after, with a bold count of 6. Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.
![Top Paying Roles Skills](assets/2_top_paying_roles_skills.png)
Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results
### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
SELECT
    skills,
    Count(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```
Here's the breakdown of the most demanded skills for data analysts in 2023

- ***SQL*** and ***Excel*** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- ***Programming*** and ***Visualization Tools*** like ***Python***, ***Tableau***, and ***Power BI*** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skill     | Demand Count |
|-----------|--------------|
| SQL       | 7,291        |
| Excel     | 4,611        |
| Python    | 4,330        |
| Tableau   | 3,745        |
| Power BI  | 2,609        |
Table of the demand for the top 5 skills in data analyst job postings
### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
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
```
- ***Data and Cloud Technologies Dominate:*** Skills related to data engineering, cloud platforms, and data analysis tools are highly valued, reflecting the growing importance of data-driven decision-making and cloud computing in the tech industry.
- ***DevOps and Software Development:*** Expertise in DevOps tools and modern programming languages is crucial, emphasizing the demand for continuous integration, deployment practices, and efficient software development processes.
- ***AI, Machine Learning, and Databases:*** Skills in artificial intelligence, machine learning, and database management are in high demand, highlighting the importance of these areas in shaping the future of technology.

| Skill        | Average Salary ($) |
|--------------|--------------------|
| PySpark      | 208,172            |
| Bitbucket    | 189,155            |
| Couchbase    | 160,515            |
| Watson       | 160,515            |
| DataRobot    | 155,486            |
| GitLab       | 154,500            |
| Swift        | 153,750            |
| Jupyter      | 152,777            |
| Pandas       | 151,821            |
| Elasticsearch| 145,000            |
Table of the average salary for the top 10 paying skills for data analysts

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql

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
```
| Skill ID | Skill        | Demand Count | Average Salary ($) |
|----------|--------------|--------------|--------------------|
| 8        | Go           | 27           | 115,320            |
| 234      | Confluence   | 11           | 114,210            |
| 97       | Hadoop       | 22           | 113,193            |
| 80       | Snowflake    | 37           | 112,948            |
| 74       | Azure        | 34           | 111,225            |
| 77       | BigQuery     | 13           | 109,654            |
| 76       | AWS          | 32           | 108,317            |
| 4        | Java         | 17           | 106,906            |
| 194      | SSIS         | 12           | 106,683            |
| 233      | Jira         | 20           | 104,918            |

Table of the most optimal skills for data analyst sorted by salary
- ***High-Demand Programming Languages:*** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- ***Cloud Tools and Technologies:***Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- ***Business Intelligence and Visualization Tools:*** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- ***Database Technologies:*** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.
# What I Learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- 🧩 ***Complex Query Crafting:*** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- 📊 ***Data Aggregation:*** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- 💡 ***Analytical Wizardry:*** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.
# Conclusions
### Insights
From the analysis, several general insights emerged:

1. ***Top-Paying Data Analyst Jobs:*** The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. ***Skills for Top-Paying Jobs:*** High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. ***Most In-Demand Skills:*** SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. ***Skills with Higher Salaries:*** Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. ***Optimal Skills for Job Market Value:*** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.
### Closing Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.