SELECT
    job_title_short AS title,
    job_location as location,
    job_posted_date:: DATE as date
FROM
    job_postings_fact;


SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM
    job_postings_fact

LIMIT 5;


SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
    job_postings_fact

LIMIT 5;


SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month 
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month 
ORDER BY
    job_posted_count DESC;

SELECT *
FROM job_postings_fact;

SELECT CREATE Table march_job ASCREATE Table january_job AS
    Select *
    FROM job_postings_fact
    WHERE EXTRACT(month From job_posted_date) = 1


CREATE Table february_job AS
    Select *
    FROM job_postings_fact
    WHERE EXTRACT(month From job_posted_date) = 2

CREATE Table march_job AS
    Select *
    FROM job_postings_fact
    WHERE EXTRACT(month From job_posted_date) = 1CREATE Table january_job AS
        Select *
        FROM job_postings_fact
        WHERE EXTRACT(month From job_posted_date) = 1
    
    
    CREATE Table february_job AS
        Select *
        FROM job_postings_fact
        WHERE EXTRACT(month From job_posted_date) = 2
    
    CREATE Table march_job AS
        Select *
        FROM job_postings_fact
        WHERE EXTRACT(month From job_posted_date) = 3WITH january_job AS(
            Select *
            From job_postings_fact
            Where EXTRACT(MONTH From job_posted_date) = 1
        )
        
        SELECT * FROM january_job;SELECT *
        FROM(
            SELECT *
            FROM job_postings_fact
            WHERE EXTRACT(MONTH From job_posted_date) = 1
        ) AS january_job;
    Select *
    FROM job_postings_fact
    WHERE EXTRACT(month From job_posted_date) = 3;
    AVG()