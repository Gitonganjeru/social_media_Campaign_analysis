/*==========================================================
DATA QUALITY ASSESSMENT

Objective:
Evaluate the completeness, consistency, and validity of the
social media campaign database before analysis.

Skills Demonstrated:
- IS NULL
- COUNT()
- GROUP BY
- HAVING
- LEFT JOIN
- NOT EXISTS
- BETWEEN
==========================================================*/

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