-- CTE: Isolate successful purchases and stamp the user's initial conversion cohort month
WITH customer_conversion_cohorts AS (
SELECT
user_id,
event_time,
-- Step A: Truncate transaction timestamps to clean calendar months
DATE_TRUNC(EXTRACT(DATE FROM event_time), MONTH) AS purchase_month,
-- Step B: Use a Window Function to lock in the customer's earliest purchase month
FIRST_VALUE(DATE_TRUNC(EXTRACT(DATE FROM event_time), MONTH))
OVER (PARTITION BY user_id ORDER BY event_time ASC) AS cohort_month
FROM `portfolio_games.raw_transactions`
-- Data Quality Filter: Focus strictly on confirmed sales entries
WHERE event_type = 'purchase' AND user_id IS NOT NULL
)

-- Final Selection: Group by cohort timelines and compute chronological differences
SELECT
cohort_month,
purchase_month,
-- Step C: Calculate how many months passed between signup and return purchase
DATE_DIFF(purchase_month, cohort_month, MONTH) AS months_since_signup,
-- Step D: Count the returning unique customers for that timeline block
COUNT(DISTINCT user_id) AS returning_customers
FROM customer_conversion_cohorts
GROUP BY cohort_month, purchase_month
ORDER BY cohort_month ASC, months_since_signup ASC;