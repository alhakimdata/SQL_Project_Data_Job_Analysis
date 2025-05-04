# Introduction
Dive into the data job market. Focusing on dtaa analyst roles, thsi project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.

SQL queries for this project portfolio? Check them out here: [alhakimdata/SQL_Project_Data_Job_Analysis](https://github.com/alhakimdata/SQL_Project_Data_Job_Analysis)

# Background
This initiative was inspired by a desire to better navigate the data analyst job market, with the goal of identifying top-paid and in-demand skills while streamlining others' efforts to discover ideal opportunities.

I did this project exhibiting my skills in SQL as one of my portfolio projects. Of course, this would not happen with the help/guide from one of my favorite data analyst.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I used:
I took a thorough dive into the data analyst job market and used several crucial tools:

- **SQL:** The foundation of my investigation, allowing me to query the database and uncover key findings.
- **PostgreSQL:** The chosen database management system is excellent for managing job posting data.
- **Visual Studio Code:** My preferred method for database management and SQL query execution.
- **Git & Github:** Version control and sharing my SQL script and analysis are critical to guaranteeing collaboration and project tracking.

# The Analysis:
Each query for this research focused on a unique facet of the data analyst employment market.  Here's how I approached each question.

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's a breakdown of the top data analyst jobs for 2023:
- **Wide Salary Range:** The top ten highest-paying data analyst roles range from $184,000 to $650,000, demonstrating great earning potential in the industry.
- **Diverse Employers:** Companies offering high pay include SmartAsset, Meta, and AT&T, demonstrating a broad interest across industries.
- **Job Title Variety:** Job titles range from Data Analyst to Director of Analytics, indicating a wide range of positions and expertise in data analytics.

![Top Paying Roles](data_analysis_assets\1_top_data_analyst_jobs.png)



### 2. Skills for Top Paying Jobs 
To determine what abilities/skills are required for the highest-paying occupations, I combined job postings and skill data, providing insights into what employers prioritize in high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name,
        job_posted_date
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON
        job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg
    LIMIT
        10
)

SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN
    skills_job_dim ON
    top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```


Here's a breakdown of the top 10 highest paying Data Analyst skills in 2023:

1. **SQL**: This is the most commonly required skill, appearing 8 times.
2. **Python**: Highly sought-after, appearing 7 times.
3. **Tableau**: Featured 6 times, indicating its importance in data visualization.
4. **R**: Required for statistical computing, appearing 4 times.
5. **Snowflake, Pandas, Excel**: Each of these skills appears 3 times, showing their relevance in data handling and analysis.


![Sql Example](data_analysis_assets\2_top_paying_job_skills.png)



### 3. In-Demand Data Analyst Skills
This query assisted in identifying the most often requested talents in job advertisements, focusing attention to areas of high demand.

```sql
SELECT
    skills,
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
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT
    5;
```


Here's the breakdown of the most demanded skills for data analysts in 2023:

 - **SQL** and **Excel** continue to be essential, highlighting the necessity of having solid foundational knowledge of data processing and spreadsheet manipulation.
 - **Programming** and **Visualization** such as Python, Tableau, and Power BI are also essential as part of technical skills needed in any data job roles particularly data analyst role in data storytelling and decision support.




|   skill   |    demand_count    |
|-----------|--------------------|
|   SQL     |   7291             |
|   Excel   |   4611             |
|   Python  |   4330             |
|   Tableau |   3745             |
|   Power BI|   2609             |



### 4. Skills Based on Salary
Exploring the average earnings linked with various skills reveals which skills are the most lucrative.

```sql
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
```

Here's a quick breakdown of the top-paying skills:

- **High Demand for Big Data & ML Skills**: Due to the industry's high regard for data processing and predictive modeling skills, analysts with expertise in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy) command top salaries.
- **Proficiency in Software Development and Deployment**: Proficiency with development and deployment platforms (such as GitLab, Kubernetes, and Airflow) suggests a profitable intersection of engineering and data analysis, with a focus on abilities that support automation and effective data pipeline management.
- **Expertise in Cloud Computing**: Knowledge of cloud and data engineering technologies (such as Elasticsearch, Databricks, and GCP) highlights the increasing significance of cloud-based analytics settings and implies that mastery of cloud computing greatly increases one's earning potential in data analytics.


|   skill       |    average_salary ($) |
|---------------|--------------------|
|   pyspark     |   208,172          |
|   bitbucket   |   189,155          |
|   couchbase   |   160,515          |
|   watson      |   160,515          |
|   datarobot   |   155,486          |
|   gitlab      |   154,500          |
|   swift       |   153,750          |
|   jupyter     |   152,777          |
|   pandas      |   151,821          |
|   elasticsearch | 145,000          |



### 5. Most Effective Skills to Learn
Combining insights from demand and salary data, this query sought to identify talents that are both in high demand and pay well, providing a strategic focus for skill development.

```sql
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
```

Here's the breakdown of the most optimal skills for Data Analysts in 2023:

- **In-Demand Programming Languages**: Python and R are among the most sought-after programming languages, with demand counts of 236 and 148, respectively. While their popularity remains high, their average salaries are around $101,397 for Python and $100,499 for R, suggesting that while expertise in these languages is valuable, they are also widely accessible.
- **Cloud Technologies**: Specialized skills in platforms like Snowflake, Azure, AWS, and BigQuery show strong demand and come with competitive salaries, underscoring the increasing significance of cloud technologies and big data in modern data analysis.
- **Business Intelligence & Data Visualization Tools**: Tools like Tableau and Looker, with demand counts of 230 and 49, and average salaries of $99,288 and $103,795, emphasize the growing importance of data visualization and business intelligence in transforming data into meaningful insights for decision-making.
- **Database Management Technologies**: Skills in both traditional (Oracle, SQL Server) and NoSQL databases, with average salaries between $97,786 and $104,534, highlight the ongoing need for expertise in data storage, management, and retrieval systems.


|   skill_id       |    skills    |     demand_count    |   average_salary($)|
|------------------|--------------|---------------------|--------------------|
|   8              |   go         |     27              |   115,320          |
|   234            |   confluence |     11              |   114,210          |
|   97             |   hadoop     |     22              |   113,193          |
|   80             |   snowflake  |     37              |   112,948          |
|   74             |   azure      |     34              |   111,225          |
|   77             |   bigquery   |     13              |   109,654          |
|   76             |   aws        |     32              |   108,317          |
|   4              |   java       |     17              |   106,906          |
|   194            |   ssis       |     12              |   106,683          |
|   233            |   jira       |     20              |   104,918          |


# Conclusions - Insights

1. **Top Paying Data Analyst Jobs**: The highest-paying remote data analyst roles can offer salaries up to $650,000.
2. **Skills for Top Jobs**: Advanced SQL proficiency is essential for securing high-paying data analyst positions.
3. **Most In-Demand Skills**: SQL is the most demanded skill in the data analyst market, making it crucial for job seekers.
4. **Skills with Higher Salaries**: Specialized skills like SVN and Solidity are linked to the highest salaries, highlighting the value of niche expertise.
5. **Optimal Skills for Market Value**: SQL is in high demand and offers a competitive salary, making it a key skill for boosting job market value.

## Learning

In this journey, I’ve significantly enhanced my SQL skills with key advancements:

- **Complex Query Crafting**: Mastered advanced SQL techniques, including table joins and using WITH clauses for efficient temp table management.

- **Data Aggregation**: Became proficient with GROUP BY and aggregate functions like COUNT() and AVG() to summarize data.

- **Analytical Skills**: Improved my problem-solving abilities by translating real-world questions into actionable SQL queries.

## Final Thoughts

This project not only boosted my SQL expertise but also provided valuable insights into the data analyst job market. The analysis emphasizes the importance of focusing on high-demand, high-salary skills, helping aspiring data analysts target the most lucrative opportunities. It also reinforces the need for continuous learning and adapting to new trends in data analytics.