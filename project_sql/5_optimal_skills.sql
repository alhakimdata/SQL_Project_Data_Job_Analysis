/*
 Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
 - Identify skills in high demand and associated with high average salaries for Data Analyst roles
 - Concentrates on remote positions with specified salaries
 - Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
 offering strategic insights for career development in data analysis
 */

-- Identifies skills in high demand for Data Analyst roles
-- Use Query #3
WITH skills_demand AS(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim ON
        job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON
        skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id

), 

-- Skills with high average salaries for Data Analyst roles
-- Use Query #4
average_salary AS(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True 
    GROUP BY
        skills_dim.skill_id
)
-- Return high demand and high salaries for 10 skills
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON
    average_salary.skill_id = skills_demand.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT
    25;

-- rewriting this same query more concisely
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
  INNER JOIN
    skills_job_dim ON
    job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN
    skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
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
LIMIT
    25;


/*

Based on the data you provided, here are some key insights about the most optimal skills for data analysts in 2023:

Most In-Demand Skills
1. Python – 236 job demands, Average Salary: $101,397  
   - Python remains the top skill for data analysts, with the highest demand and a competitive salary.

2. Tableau – 230 job demands, Average Salary: $99,288  
   - Tableau is in high demand and a great tool for data visualization.

3. R – 148 job demands, Average Salary: $100,499  
   - R is also highly sought after, particularly for statistical analysis.

4. Looker – 49 job demands, Average Salary: $103,795  
   - Looker is another visualization tool with notable demand, offering strong salary potential.

5. SQL Server – 35 job demands, Average Salary: $97,786  
   - SQL remains essential for data querying and management, with strong demand.

Skills with High Salaries
- Go – 27 job demands, Average Salary: $115,320  
   - Go offers the highest average salary, although demand is relatively lower compared to others.
   
- Confluence – 11 job demands, Average Salary: $114,210  
   - Confluence shows a high salary but is not as commonly demanded.

- Snowflake – 37 job demands, Average Salary: $112,948  
   - Snowflake is gaining traction in cloud data storage and analysis, offering high pay.

- Hadoop – 22 job demands, Average Salary: $113,193  
   - Hadoop continues to be important for handling big data with above-average salary prospects.

Other Noteworthy Skills
- Azure – 34 job demands, Average Salary: $111,225  
   - Azure is a key cloud platform that is highly valuable in the data analytics ecosystem.

- BigQuery – 13 job demands, Average Salary: $109,654  
   - BigQuery is a strong tool for managing large datasets, particularly in Google Cloud environments.

- AWS – 32 job demands, Average Salary: $108,317  
   - AWS is another major cloud platform that's heavily utilized in data analysis.

Skills with Moderate Demand
- SAS (63 job demands) – Average Salary: $98,902  
   - While not as high-demand as Python or R, SAS still plays a critical role in data analytics, especially in specialized industries.

Summary 
- Python, Tableau, and R are the leading skills for data analysts due to their high demand and strong salary prospects.
- For cloud data solutions, Snowflake, Azure, AWS, and BigQuery are increasingly valuable.
- Go offers the highest salary but has lower demand compared to other skills.
  
If you're looking to optimize your skillset, Python, SQL, and a visualization tool like Tableau or Looker would be a solid combination to focus on for 2023.


[
  {
    "skill_id": 8,
    "skills": "go",
    "demand_count": "27",
    "avg_salary": "115320"
  },
  {
    "skill_id": 234,
    "skills": "confluence",
    "demand_count": "11",
    "avg_salary": "114210"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "demand_count": "22",
    "avg_salary": "113193"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "37",
    "avg_salary": "112948"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "34",
    "avg_salary": "111225"
  },
  {
    "skill_id": 77,
    "skills": "bigquery",
    "demand_count": "13",
    "avg_salary": "109654"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "demand_count": "32",
    "avg_salary": "108317"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "17",
    "avg_salary": "106906"
  },
  {
    "skill_id": 194,
    "skills": "ssis",
    "demand_count": "12",
    "avg_salary": "106683"
  },
  {
    "skill_id": 233,
    "skills": "jira",
    "demand_count": "20",
    "avg_salary": "104918"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "37",
    "avg_salary": "104534"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "demand_count": "49",
    "avg_salary": "103795"
  },
  {
    "skill_id": 2,
    "skills": "nosql",
    "demand_count": "13",
    "avg_salary": "101414"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "236",
    "avg_salary": "101397"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "148",
    "avg_salary": "100499"
  },
  {
    "skill_id": 78,
    "skills": "redshift",
    "demand_count": "16",
    "avg_salary": "99936"
  },
  {
    "skill_id": 187,
    "skills": "qlik",
    "demand_count": "13",
    "avg_salary": "99631"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "230",
    "avg_salary": "99288"
  },
  {
    "skill_id": 197,
    "skills": "ssrs",
    "demand_count": "14",
    "avg_salary": "99171"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "demand_count": "13",
    "avg_salary": "99077"
  },
  {
    "skill_id": 13,
    "skills": "c++",
    "demand_count": "11",
    "avg_salary": "98958"
  },
  {
    "skill_id": 186,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "demand_count": "35",
    "avg_salary": "97786"
  },
  {
    "skill_id": 9,
    "skills": "javascript",
    "demand_count": "20",
    "avg_salary": "97587"
  }
]
*/