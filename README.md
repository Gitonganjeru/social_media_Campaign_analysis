# social_media_Campaign_analysis
# 📊 Social Media Campaign Performance Analysis

## Project Overview

This project analyzes the performance of digital advertising campaigns across social media platforms using a relational database containing campaign, advertisement, user, and event-level interaction data.

The objective is to evaluate campaign effectiveness, understand audience engagement patterns, identify high-performing customer segments, and generate actionable business recommendations that support marketing budget allocation and strategic decision-making.

The project follows the **CRISP-DM (Cross-Industry Standard Process for Data Mining)** framework, progressing from data understanding and quality assessment to business analysis and KPI development.

---

## Business Problem

Organizations invest significant resources in digital advertising campaigns across platforms such as Facebook and Instagram. However, without data-driven evaluation, it becomes difficult to determine:

- Which campaigns deliver the highest engagement.
- Which audience segments respond best to advertisements.
- Which platforms generate the most value.
- Whether advertising budgets are being utilized effectively.
- Which campaigns deserve additional investment.

This analysis aims to provide evidence-based insights to improve campaign performance and marketing ROI.

---

# Project Objectives

### Primary Objectives

- Assess the quality and integrity of the campaign database.
- Analyze customer engagement behavior across campaigns.
- Evaluate advertisement performance across platforms.
- Identify high-performing audience segments.
- Develop meaningful marketing KPIs.
- Generate actionable recommendations for stakeholders.

### Analytical Objectives

- Understand relationships between campaigns, advertisements, users, and events.
- Perform data quality validation before analysis.
- Explore engagement patterns by platform, demographic group, and campaign.
- Measure marketing effectiveness through KPI development.

---

# Dataset Overview

The database consists of four interconnected tables designed to simulate a real-world digital marketing environment.

---

## Database Schema

### 1. Campaigns

Stores strategic information about marketing campaigns.

| Column | Description |
|----------|------------|
| campaign_id | Unique campaign identifier |
| name | Campaign name |
| start_date | Campaign start date |
| end_date | Campaign end date |
| duration_days | Campaign duration |
| total_budget | Campaign budget |

---

### 2. Ads

Contains information about individual advertisements.

| Column | Description |
|----------|------------|
| ad_id | Unique advertisement identifier |
| campaign_id | Associated campaign |
| ad_platform | Advertising platform |
| ad_type | Advertisement format |
| target_gender | Target audience gender |
| target_age_group | Target audience age group |
| target_interests | Target audience interests |

---

### 3. Users

Contains audience demographic information.

| Column | Description |
|----------|------------|
| user_id | Unique user identifier |
| user_gender | Gender |
| user_age | Age |
| age_group | Age category |
| country | User country |
| location | User location |
| interests | User interests |

---

### 4. Ad Events (Fact Table)

Records every user interaction with an advertisement.

| Column | Description |
|----------|------------|
| event_id | Event identifier |
| ad_id | Advertisement identifier |
| user_id | User identifier |
| timestamp | Event timestamp |
| day_of_week | Day event occurred |
| time_of_day | Time category |
| event_type | Interaction type |

---

# Entity Relationship Model

```text
Campaigns
    │
    ▼
Ads
    │
    ▼
Ad Events
    ▲
    │
Users
```

### Fact Table

- ad_events

### Dimension Tables

- campaigns
- ads
- users

The `ad_events` table serves as the central fact table because it records transactional user interactions, while the remaining tables provide descriptive business context.

---

# Methodology

This project follows the CRISP-DM framework.

## 1. Business Understanding

Defined the business problem and analytical objectives.

### Key Questions

- Which campaigns generate the highest engagement?
- Which audience segments perform best?
- Which platforms drive the most activity?
- How effectively are marketing budgets being utilized?

---

## 2. Data Understanding

Conducted database exploration to understand:

- Table structures
- Relationships
- Data types
- Record counts
- Fact and dimension tables

### SQL Skills Demonstrated

- CREATE DATABASE
- USE
- SHOW TABLES
- DESCRIBE
- SELECT
- LIMIT
- COUNT()
- DISTINCT

### Deliverables

- Database documentation
- Data dictionary
- Schema understanding

-- I created a database, this is the data familiarization stage
CREATE database social_media_campaign;
USE social_media_campaign;

-- This inspects the database to identify all available tables 
SHOW TABLES;

-- I want to now understand  the tables's structure before begining the analysis
DESCRIBE ads;
SELECT *
FROM ads
LIMIT 10;

-- Now I will do the rest for campaigns and users
DESCRIBE campaigns;
SELECT *
FROM campaigns
LIMIT 1000;

-- Explore user table
DESCRIBE users;
SELECT *
FROM users
LIMIT 10;

-- Count total records
SELECT COUNT(*) AS total_ads
FROM ads;

-- count total campaign records
SELECT COUNT(*) AS total_campaign
FROM campaigns;

-- count total users
SELECT COUNT(*) AS total_users
FROM users;

-- Explore the central transaction table (Fact Table) that records every user interaction with an advertisement.
DESCRIBE ad_events;
SELECT *
FROM ad_events;

-- Total events recorded
SELECT COUNT(*) AS total_events
FROM ad_events;
 
-- different event types
SELECT DISTINCT event_type
FROM ad_events;

-- How many events belong to each event type
SELECT
	event_type,
	COUNT(*) AS total_events
FROM ad_events
GROUP BY event_type;

-- the day of the week with most activity
SELECT
	day_of_week,
    COUNT(*) AS total_events
FROM ad_events
GROUP BY day_of_week
ORDER BY total_events DESC;

-- the time of the day with the highest number of events
SELECT 
	time_of_day,
    COUNT(*) AS total_events
FROM ad_events
GROUP BY time_of_day
ORDER BY total_events DESC;

-- the earliest timestamp
SELECT MIN(timestamp) AS earliest_event
FROM ad_events;

-- the latest timestamp
SELECT MAX(timestamp) AS latest_event
FROM ad_events;

-- duration of the campaign dataset
SELECT
    MIN(timestamp) AS first_event,
    MAX(timestamp) AS last_event,
    DATEDIFF(MAX(timestamp), MIN(timestamp)) AS campaign_days
FROM ad_events;

-- event distribution
SELECT
    event_type,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM ad_events),
        2
    ) AS percentage
FROM ad_events
GROUP BY event_type
ORDER BY percentage DESC;

---

## 3. Data Quality Assessment

Evaluated completeness, consistency, and validity before analysis.

### Data Quality Checks

-- checking for missing campaign budget values
SELECT *
FROM campaigns
WHERE total_budget IS NULL;

-- missing campaign names
SELECT *
FROM campaigns
WHERE name IS NULL;

-- duplicate campaigns using group by and having
SELECT
    campaign_id,
    COUNT(*) AS occurrences
FROM campaigns
GROUP BY campaign_id
HAVING COUNT(*) > 1;

-- duplicate ads using group by and having
SELECT
    ad_id,
    COUNT(*) AS occurrences
FROM ads
GROUP BY ad_id
HAVING COUNT(*) > 1;

-- duplicate users
SELECT
    user_id,
    COUNT(*) AS occurrences
FROM users
GROUP BY user_id
HAVING COUNT(*) > 1;

-- I investigated the duplicates found on users column
SELECT *
FROM users WHERE user_id= '7332b';

-- Duplicate user_id values were identified.
-- The associated records contain different demographic attributes,
-- suggesting that they are not exact duplicate records.

-- This may indicate:

 -- Data entry inconsistencies
-- User identifier reuse
-- Synthetic data generation artifacts

-- Without documented business rules confirming that user_id must be unique, the records have been retained pending stakeholder clarification.

-- I will now proceed to do a referential intergrity check
-- Do all ads belong to valid campaigns?
SELECT
    a.ad_id,
    a.campaign_id
FROM ads a
LEFT JOIN campaigns c
ON a.campaign_id = c.campaign_id
WHERE c.campaign_id IS NULL;

-- check event intergrity
SELECT
    ae.ad_id
FROM ad_events ae
LEFT JOIN ads a
ON ae.ad_id = a.ad_id
WHERE a.ad_id IS NULL;

-- CHeck user intergrity
SELECT
    ae.user_id
FROM ad_events ae
LEFT JOIN users u
ON ae.user_id = u.user_id
WHERE u.user_id IS NULL;

-- After intergrity check I will do data validation
-- campaign budget
SELECT *
FROM campaigns
WHERE total_budget <= 0;

-- campaign duration
SELECT *
FROM campaigns
WHERE duration_days <= 0;

-- age validation
SELECT *
FROM users
WHERE user_age NOT BETWEEN 18 AND 65;

```

Investigated duplicate user IDs and documented findings before making decisions.

#### Referential Integrity Validation

Verified relationships between:

- Campaigns and Ads
- Ads and Ad Events
- Users and Ad Events

Using:

```sql
LEFT JOIN
```

to identify orphan records.

#### Data Validation

Validated:

- Campaign budgets
- Campaign durations
- User age ranges

Using:

```sql
IS NULL
BETWEEN
LEFT JOIN
COUNT()
```

### SQL Skills Demonstrated

- IS NULL
- COUNT()
- GROUP BY
- HAVING
- LEFT JOIN
- ON
- BETWEEN
- ORDER BY

---

## 4. Exploratory Data Analysis (EDA)

Performed exploratory analysis to understand event distributions and engagement behavior.

### Analyses Conducted

- Event type distributions
- Activity by day of week
- Activity by time of day
- Event frequency analysis
- User engagement patterns

### SQL Skills Demonstrated

- COUNT()
- GROUP BY
- ORDER BY
- MIN()
- MAX()
- DISTINCT
-- 1. Which ad platform generated the highest engagement?
USE social_media_campaign;
SELECT
    a.ad_platform,

    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS impressions,

    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS clicks,

    COUNT(CASE WHEN ae.event_type = 'Like' THEN 1 END) AS likes,

    COUNT(CASE WHEN ae.event_type = 'Share' THEN 1 END) AS shares,

    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS purchases,

    COUNT(
        CASE
            WHEN ae.event_type IN ('Click', 'Like', 'Share', 'Purchase')
            THEN 1
        END
    ) AS total_engagements

FROM ads AS a
INNER JOIN ad_events AS ae
    ON a.ad_id = ae.ad_id

GROUP BY a.ad_platform

ORDER BY total_engagements DESC;

-- 2. Which ad formats (Video, Carousel, Stories, Image) generate the highest user engagement?
SELECT
    a.ad_type,

    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS impressions,

    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS clicks,

    COUNT(CASE WHEN ae.event_type = 'Like' THEN 1 END) AS likes,

    COUNT(CASE WHEN ae.event_type = 'Share' THEN 1 END) AS shares,

    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS purchases,

    COUNT(
        CASE
            WHEN ae.event_type IN ('Click', 'Like', 'Share', 'Purchase')
            THEN 1
        END
    ) AS total_engagements

FROM ads AS a
INNER JOIN ad_events AS ae
    ON a.ad_id = ae.ad_id

GROUP BY a.ad_type

ORDER BY total_engagements DESC;


-- 3. which age group is most engaged?
SELECT
    u.age_group,

    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS impressions,

    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS clicks,

    COUNT(CASE WHEN ae.event_type = 'Like' THEN 1 END) AS likes,

    COUNT(CASE WHEN ae.event_type = 'Share' THEN 1 END) AS shares,

    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS purchases,

    COUNT(
        CASE
            WHEN ae.event_type IN ('Click', 'Like', 'Share', 'Purchase')
            THEN 1
        END
    ) AS total_engagements

FROM users AS u

INNER JOIN ad_events AS ae
    ON u.user_id = ae.user_id

GROUP BY u.age_group

ORDER BY total_engagements DESC;

-- 4. which gender engages the most?
SELECT
    u.user_gender,

    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS impressions,

    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS clicks,

    COUNT(CASE WHEN ae.event_type = 'Like' THEN 1 END) AS likes,

    COUNT(CASE WHEN ae.event_type = 'Share' THEN 1 END) AS shares,

    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS purchases,

    COUNT(
        CASE
            WHEN ae.event_type IN ('Click', 'Like', 'Share', 'Purchase')
            THEN 1
        END
    ) AS total_engagements

FROM users AS u

INNER JOIN ad_events AS ae
    ON u.user_id = ae.user_id

GROUP BY u.user_gender

ORDER BY total_engagements DESC;

-- 6. which country generates the highest user engagement?
SELECT
    u.country,

    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS impressions,

    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS clicks,

    COUNT(CASE WHEN ae.event_type = 'Like' THEN 1 END) AS likes,

    COUNT(CASE WHEN ae.event_type = 'Share' THEN 1 END) AS shares,

    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS purchases,

    COUNT(
        CASE
            WHEN ae.event_type IN ('Click', 'Like', 'Share', 'Purchase')
            THEN 1
        END
    ) AS total_engagements

FROM users AS u

INNER JOIN ad_events AS ae
    ON u.user_id = ae.user_id

GROUP BY u.country

ORDER BY total_engagements DESC;

-- 7. which user intrest generates the highest ebgagement?
SELECT
    u.interests,

    COUNT(CASE WHEN ae.event_type = 'Impression' THEN 1 END) AS impressions,

    COUNT(CASE WHEN ae.event_type = 'Click' THEN 1 END) AS clicks,

    COUNT(CASE WHEN ae.event_type = 'Like' THEN 1 END) AS likes,

    COUNT(CASE WHEN ae.event_type = 'Share' THEN 1 END) AS shares,

    COUNT(CASE WHEN ae.event_type = 'Purchase' THEN 1 END) AS purchases,

    COUNT(
        CASE
            WHEN ae.event_type IN ('Click', 'Like', 'Share', 'Purchase')
            THEN 1
        END
    ) AS total_engagements

FROM users AS u

INNER JOIN ad_events AS ae
    ON u.user_id = ae.user_id

GROUP BY u.interests

ORDER BY total_engagements DESC;
---

## 5. Business Analysis

Analyzed marketing performance by combining data across multiple tables.

### Areas of Analysis

#### Campaign Performance

- Engagement by campaign
- Campaign activity levels
- Budget utilization

#### Advertisement Performance

- Platform comparison
- Ad format effectiveness
- Audience targeting effectiveness

#### Audience Analysis

- Age group performance
- Gender analysis
- Interest-based segmentation
- Geographic analysis

### SQL Skills Demonstrated

- INNER JOIN
- LEFT JOIN
- Aggregations
- CASE Statements
- HAVING
- Multi-table Analysis

---

## 6. KPI Development

Developed marketing performance indicators to evaluate campaign effectiveness.

### Key Performance Indicators

| KPI | Description |
|------|------------|
| Total Impressions | Number of ad impressions |
| Total Clicks | Number of ad clicks |
| Total Likes | Number of likes |
| Total Shares | Number of shares |
| Total Purchases | Number of purchases |
| CTR | Click-through rate |
| Engagement Rate | User engagement level |
| Conversion Rate | Purchase effectiveness |
| CPC | Cost per click |
| CPA | Cost per acquisition |
| Campaign ROI | Return on investment |

### SQL Skills Demonstrated

- SUM()
- COUNT()
- AVG()
- CASE
- CTEs
- Window Functions
- Calculated Metrics

---

# SQL Skills Demonstrated

## Database Exploration

- CREATE DATABASE
- USE
- SHOW TABLES
- DESCRIBE

## Data Retrieval

- SELECT
- DISTINCT
- LIMIT

## Filtering

- WHERE
- BETWEEN
- IS NULL

## Aggregation

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()

## Sorting

- ORDER BY

## Grouping

- GROUP BY
- HAVING

## Joins

- INNER JOIN
- LEFT JOIN

## Advanced SQL

- CASE
- ROW_NUMBER()
- Window Functions
- CTEs
- Subqueries

## Data Quality Validation

- Duplicate Detection
- Missing Value Analysis
- Referential Integrity Checks
- Data Validation

---

# Key Findings

*(To be completed upon completion of business analysis.)*

### Example Findings

- Highest-performing campaign.
- Best-performing advertising platform.
- Most engaged audience segment.
- Highest-converting age group.
- Most effective advertisement type.

---

# Business Recommendations

*(To be completed after KPI analysis.)*

Potential recommendations may include:

- Increase investment in high-performing campaigns.
- Optimize underperforming ad formats.
- Focus targeting on high-converting audience segments.
- Reallocate budgets based on campaign ROI.

---

# Project Structure

```text
social-media-campaign-analysis/
│
├── README.md
│
├── data/
│   └── ad_campaign_db.sqlite
│
├── sql/
│   ├── 01_database_exploration.sql
│   ├── 02_data_quality_assessment.sql
│   ├── 03_exploratory_data_analysis.sql
│   ├── 04_business_analysis.sql
│   └── 05_kpi_analysis.sql
│
├── documentation/
│   ├── data_dictionary.md
│   ├── entity_relationship_diagram.png
│   └── project_journal.md
│
├── visuals/
│   └── dashboard_images/
│
└── presentation/
    └── executive_summary.pdf
```

---

# Tools Used

- MySQL Workbench
- SQL
- GitHub
- Markdown

---

# Author

### Timothy Njeru

Aspiring Data Analyst skilled in:

- SQL
- Excel
- Power BI
- Data Cleaning
- Data Quality Assessment
- Exploratory Data Analysis
- Dashboard Development
- Business Intelligence

### Connect With Me

- LinkedIn: *(www.linkedin.com/in/timothy-gitonga-aa680920a)*
- GitHub: *(https://github.com/Gitonganjeru/social_media_Campaign_analysis/edit/main/README.md)*

---

## Future Enhancements

- Power BI Dashboard Development
- Campaign ROI Forecasting
- Customer Segmentation Models
- Marketing Attribution Analysis
- Predictive Analytics
