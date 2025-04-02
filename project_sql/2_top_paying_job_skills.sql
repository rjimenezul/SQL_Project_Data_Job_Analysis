--Question: What are the top-paying data analyst jobs, and what skills are required? 

- Identify the top 10 highest-paying Data Analyst jobs and the specific skills required for these roles.
- Filters for roles with specified salaries that are remote
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries

-- create queries to evalaute and familiarize with both skill tables:

-- provides the dimensional table that relates job id to skill id
SELECT *
FROM skills_job_dim
LIMIT 10;

-- dimensional table that gives the skill name for each skill id
SELECT *
FROM skills_dim
LIMIT 10;


-- To answer the question: use and start building from the query created in top paying jobs file:
WITH remote_jobs AS (
SELECT job_id
FROM job_postings_fact
WHERE job_work_from_home = TRUE
)


SELECT  top_10_jobs.Company_Name, skills_dim.skills AS Skill_Name, top_10_jobs.yearly_salary

-- Use the previous query as a subquery in order to build from the table of the top 10 paying jobs:
FROM (

SELECT remjob.job_id AS Job_ID, compdim.name AS Company_Name, job_title AS Job_Title, job_work_from_home,salary_year_avg AS Yearly_Salary
FROM job_postings_fact AS jbf

LEFT JOIN company_dim AS compdim ON jbf.company_id = compdim.company_id
INNER JOIN remote_jobs AS remjob ON jbf.job_id = remjob.job_id

WHERE job_title_short = 'Data Analyst' AND
      salary_year_avg IS NOT NULL

ORDER BY salary_year_avg DESC
LIMIT 10
) AS top_10_jobs

-- with the subquery defined, we obtain the skill id from the skill job table and the skill name from the skill tabe:

LEFT JOIN skills_job_dim AS skilljob ON skilljob.job_id = top_10_jobs.job_id

LEFT JOIN skills_dim ON skills_dim.skill_id = skilljob.skill_id

-- last, filter out the job ids that are null as they provide no information we need.
WHERE skilljob.job_id IS NOT NULL
ORDER BY Yearly_Salary DESC;




