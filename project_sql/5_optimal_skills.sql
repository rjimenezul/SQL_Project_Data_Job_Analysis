--What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill) for a data analyst? 


-- Using both previous queries done to have the top demand and top paying skills, we build two CTEs:

WITH top_demand_skills AS(
    SELECT skills_dim.skills, COUNT(jbf.job_id) AS Qty_of_Jobs

    FROM job_postings_fact AS jbf
    INNER JOIN skills_job_dim ON jbf.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE jbf.job_title_short = 'Data Analyst'
    GROUP BY skills_dim.skills

), highest_paying_skills AS(

    SELECT skills_dim.skills, ROUND(AVG(salary_year_avg),1) AS Average_Salary
    FROM job_postings_fact AS jbf
    INNER JOIN skills_job_dim ON jbf.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE jbf.job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL 
    GROUP BY skills_dim.skills

)

-- Use inner join to obtain only the skills present in both CTEs, including the quantity of jobs and the average salary data:

SELECT top_demand_skills.skills, top_demand_skills.Qty_of_Jobs, highest_paying_skills.Average_Salary
FROM top_demand_skills
INNER JOIN highest_paying_skills ON top_demand_skills.skills = highest_paying_skills.skills

-- Setup the order by first the highest demand skills and then the highest paying skills:
ORDER BY top_demand_skills.Qty_of_Jobs DESC, highest_paying_skills.Average_Salary DESC

-- TOP 10
LIMIT 10;



