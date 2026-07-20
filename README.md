📊 Social Media Campaign Performance Analysis
![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Status](https://img.shields.io/badge/Status-In%20Progress-orange)
![Methodology](https://img.shields.io/badge/Methodology-CRISP--DM-success)
Executive Summary
This repository showcases an end-to-end SQL analytics project analyzing synthetic Facebook and Instagram advertising campaign data. The project follows the CRISP-DM methodology, progressing from business understanding and database exploration to data quality assessment, exploratory business analysis, and KPI development.
The objective is to demonstrate practical SQL skills while producing actionable business insights that support marketing decision-making.
---
Business Problem
Marketing teams invest significant budgets into digital advertising but often lack clear visibility into:
Which campaigns perform best
Which audience segments are most engaged
Which platforms deliver the highest engagement
Which advertising strategies should receive future investment
This project answers these questions using SQL.
---
Project Objectives
Primary Objective
Analyze social media campaign performance using SQL and generate actionable business insights.
Specific Objectives
Explore a relational database
Assess data quality
Validate relationships between tables
Analyze customer engagement
Build campaign KPIs
Provide business recommendations
---
CRISP-DM Methodology
1. Business Understanding
Defined the business problem and established measurable project objectives.
Skills Demonstrated
Business Problem Definition
Analytical Thinking
Requirement Gathering
---
2. Data Understanding
Explored database structure before analysis.
Tables
Table	Description
users	Customer demographics
campaigns	Campaign information
ads	Advertisement details
ad_events	User interactions
Skills Demonstrated
CREATE DATABASE
SHOW TABLES
DESCRIBE
SELECT
LIMIT
COUNT()
DISTINCT
Example:
```sql
CREATE DATABASE social_media_campaign;
USE social_media_campaign;

SHOW TABLES;

DESCRIBE ads;

SELECT COUNT(*) AS total_ads
FROM ads;
```
---
3. Data Quality Assessment
Validated the dataset before analysis.
Checks Performed
Missing values
Duplicate detection
Referential integrity
Data validation
Business rule verification
Example:
```sql
SELECT
    user_id,
    COUNT(*) AS occurrences
FROM users
GROUP BY user_id
HAVING COUNT(*) > 1;
```
Skills Demonstrated
IS NULL
GROUP BY
HAVING
LEFT JOIN
COUNT()
Data Validation
---
4. Exploratory Business Analysis
Business questions answered include:
Which platform generated the highest engagement?
Which ad format performed best?
Which campaigns should receive more investment?
Which age group is most engaged?
Which gender engages the most?
Which countries generate the highest engagement?
Which interests generate the highest engagement?
Representative query:
```sql
SELECT
    a.ad_platform,
    COUNT(CASE WHEN ae.event_type='Impression' THEN 1 END) AS impressions,
    COUNT(CASE WHEN ae.event_type='Click' THEN 1 END) AS clicks,
    COUNT(CASE WHEN ae.event_type='Like' THEN 1 END) AS likes,
    COUNT(CASE WHEN ae.event_type='Share' THEN 1 END) AS shares,
    COUNT(CASE WHEN ae.event_type='Purchase' THEN 1 END) AS purchases,
    COUNT(
        CASE
            WHEN ae.event_type IN ('Click','Like','Share','Purchase')
            THEN 1
        END
    ) AS total_engagements
FROM ads a
INNER JOIN ad_events ae
ON a.ad_id = ae.ad_id
GROUP BY a.ad_platform
ORDER BY total_engagements DESC;
```
Key Findings
Facebook generated the highest overall engagement.
Instagram produced the only purchase event.
Stories generated the highest engagement.
Image ads demonstrated conversion potential.
Users aged 25–34 generated the highest engagement.
Male users were the most engaged demographic.
UK audiences showed stronger engagement efficiency.
Business Recommendations
Increase investment in Stories.
Continue testing Image ads for conversions.
Optimize Video and Carousel creatives.
Prioritize campaigns targeting ages 25–34.
---
5. KPI Development (In Progress)
Planned KPIs:
KPI	Formula
Impressions	COUNT(Impression)
Clicks	COUNT(Click)
Likes	COUNT(Like)
Shares	COUNT(Share)
Purchases	COUNT(Purchase)
Total Engagement	Click + Like + Share + Purchase
Engagement Rate	Engagement / Impressions
CTR	Clicks / Impressions
Conversion Rate	Purchases / Clicks
CPC	Budget / Clicks
CPA	Budget / Purchases
Upcoming SQL features:
Common Table Expressions (CTEs)
Window Functions
DENSE_RANK()
ROW_NUMBER()
NULLIF()
ROUND()
---
SQL Skills Demonstrated
Database Exploration
CREATE DATABASE
USE
SHOW TABLES
DESCRIBE
Data Retrieval
SELECT
WHERE
DISTINCT
LIMIT
Aggregation
COUNT()
SUM()
AVG()
MIN()
MAX()
Filtering
WHERE
HAVING
Joins
INNER JOIN
LEFT JOIN
Conditional Logic
CASE
Data Quality
Duplicate Detection
Missing Value Analysis
Referential Integrity
Data Validation
Advanced SQL (Upcoming)
CTEs
Window Functions
Ranking
KPI Calculations
---
Repository Structure
```text
social-media-campaign-analysis/
│
├── README.md
├── data/
├── sql/
│   ├── 01_database_exploration.sql
│   ├── 02_data_quality_assessment.sql
│   ├── 03_exploratory_business_analysis.sql
│   ├── 04_campaign_kpis.sql
│   └── 05_final_business_insights.sql
├── documentation/
├── visuals/
└── presentation/
```
---
Tools
MySQL Workbench
SQL
Git
GitHub
Markdown
---
Future Enhancements
Complete KPI development
Power BI dashboard
Executive report
Campaign ROI analysis
Customer segmentation
Predictive analytics
---
About the Author
Timothy Njeru
Aspiring Data Analyst with hands-on experience in Excel, SQL, and Power BI, passionate about transforming raw data into actionable business insights.
Connect
GitHub: https://github.com/Gitonganjeru
LinkedIn: https://www.linkedin.com/in/timothy-gitonga-aa680920a
