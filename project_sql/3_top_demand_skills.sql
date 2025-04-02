-- Question: What are the most in-demand skills for data analysts?

--Select the skill name from the skill dim table and count the number of job ids from the job postings according to the Data Anlayst filter:
SELECT skills_dim.skills, COUNT(jbf.job_id) AS Qty_of_Jobs

FROM job_postings_fact AS jbf

-- Use Inner Joins to obtain the connection of skill job dim and skill dim tables to obtain the job name. 
INNER JOIN skills_job_dim ON jbf.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

--Use WHERE to filter only DATA ANALYST jobs. 
WHERE jbf.job_title_short = 'Data Analyst' 


-- Group by the skill name to make the aggregation of data and order them by the qty of jobs posted. 
GROUP BY skills_dim.skills
ORDER BY Qty_of_Jobs DESC
LIMIT 5;

--RESULTS:
--"skills","qty_of_jobs"
--"sql","92628"
--"excel","67031"
--"python","57326"
--"tableau","46554"
--"power bi","39468"
