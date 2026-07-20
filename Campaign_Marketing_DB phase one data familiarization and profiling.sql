/*
Project: Social Media Campaign Analysis
Author: Timothy Njeru
Tool: MySQL Workbench
Objective:
Explore and profile the social media campaign database
before performing business analysis.

Skills Demonstrated:
- SHOW TABLES
- DESCRIBE
- SELECT
- LIMIT
- COUNT()
- DISTINCT
- GROUP BY
- ORDER BY
- MIN()
- MAX()
*/

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


