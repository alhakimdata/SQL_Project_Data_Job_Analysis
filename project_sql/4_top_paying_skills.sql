/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless on location
- Why? It reveals how different skill impact salary levels for Data Analysts and helps
identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*
Here’s a quick analysis and trend breakdown
from the top 25 highest-paying skills for data analysts
based on average salary data:

Top 25 High-Paying Skills – Trend Insights
1. Programming & Big Data Tools Dominate

    Skills like PySpark ($208k), Pandas ($151k), NumPy ($143k), Scala ($124k), Golang ($145k), and Swift ($153k) are very high-paying.

    These are typically used in data engineering, machine learning, and software development, showing that cross-functional coding skills significantly boost pay.

2. Cloud & Infrastructure Skills Pay Well

    Tools such as:

        Databricks ($141k) – big data processing.

        GCP ($122k) – cloud computing.

        Kubernetes ($132k) and Linux ($136k) – DevOps and infrastructure tools.

    This reflects the growing demand for cloud-native, scalable data systems.

3. AI/ML-Driven Tools Are Rewarded

    Skills like:

        Watson ($160k) – IBM’s AI platform.

        DataRobot ($155k) – automated machine learning.

        Scikit-learn ($125k) – ML library in Python.

    High pay is linked to predictive analytics and automation expertise.

4. Development & Workflow Tools are Key

    Examples:

        GitLab ($154k), Bitbucket ($189k), Jenkins ($125k) – source control and CI/CD.

        Airflow ($126k) – data workflow orchestration.

        Atlassian ($131k) – project management suite.

    These tools are essential in collaborative and production-grade environments.

5. Visualization, BI & Niche Tools

    Niche but powerful tools also rank:

        MicroStrategy ($121k) – BI tool.

        Notion ($125k) – documentation/productivity.

        Jupyter ($152k) – used for prototyping and presenting data projects.

*/