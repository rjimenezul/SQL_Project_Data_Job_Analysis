-- Question we are trying to answer: What are the top-paying data analyst jobs?
-- Identify the top 10 highest-paying Data Analyst roles that are available remotely.


-- First evaluate the tables we are going to use for the query and get familiar with the column information they provide:

SELECT *
FROM company_dim
LIMIT 10;

SELECT *
FROM job_postings_fact
LIMIT 10;

--Start with the creation a CTE to filter for remote jobs by the TRUE condition for the job_work_from_home column.

WITH remote_jobs AS (
SELECT job_id
FROM job_postings_fact
WHERE job_work_from_home = TRUE
)

-- Create the query to obtain the jobs that are found in the remote jobs CTE: 


SELECT remjob.job_id AS Job_ID, compdim.name AS Company_Name, job_title AS Job_Title, job_work_from_home,salary_year_avg AS Yearly_Salary
FROM job_postings_fact AS jbf

--Include the company name using a left join to the company_dim table. 
LEFT JOIN company_dim AS compdim ON jbf.company_id = compdim.company_id

-- Innter join to obtain only remote jobs from the CTE.
INNER JOIN remote_jobs AS remjob ON jbf.job_id = remjob.job_id

-- We filter a couple of things: Data Analyst Jobs as well as eliminate NULL values in the yearly salary column to clean the data. 
WHERE job_title_short = 'Data Analyst' AND
      salary_year_avg IS NOT NULL

-- Order by Salary and obtain the top 10 highest-paying jobs.
ORDER BY salary_year_avg DESC
LIMIT 10;


