



CREATE Table january_job AS
    Select *
    FROM job_postings_fact
    WHERE EXTRACT(month From job_posted_date) = 1;


CREATE Table february_job AS
    Select *
    FROM job_postings_fact
    WHERE EXTRACT(month From job_posted_date) = 2;

CREATE Table march_job AS
    Select *
    FROM job_postings_fact
    WHERE EXTRACT(month From job_posted_date) = 3;