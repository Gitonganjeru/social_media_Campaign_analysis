/*
Business Questions

Objective:
Answer different business questions that will provide a deeper understanding of the data.

Method:
- Joined the ads and ad_events tables.
- Used conditional aggregation to count each event type.
- Calculated total engagement as the sum of Click, Like, Share, and Purchase events.
- Ranked platforms by total engagement.

Skills:
INNER JOIN
CASE
COUNT
GROUP BY
ORDER BY
*/
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