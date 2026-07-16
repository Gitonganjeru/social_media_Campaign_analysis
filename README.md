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

---

## 3. Data Quality Assessment

Evaluated completeness, consistency, and validity before analysis.

### Data Quality Checks

#### Missing Values

Validated critical fields such as:

- Campaign names
- Campaign budgets

#### Duplicate Detection

Performed duplicate analysis using:

```sql
GROUP BY
HAVING COUNT(*) > 1
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
