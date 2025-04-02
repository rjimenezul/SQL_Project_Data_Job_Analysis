-- What are the top paying skill?


-- Based on the previous query for the top demand skills, modify the code in order to obtain the Round Average year salary:

SELECT skills_dim.skills, ROUND(AVG(salary_year_avg),1) AS Average_Salary

FROM job_postings_fact AS jbf


INNER JOIN skills_job_dim ON jbf.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id


-- Add the IS NOT NULL for the salary_year_avg column to clean the data:
WHERE jbf.job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL


GROUP BY skills_dim.skills

-- Order by the top 10 averages.
ORDER BY Average_Salary DESC
LIMIT 10;