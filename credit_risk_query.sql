-- CTE: Clean raw fields and establish behavioral risk classification buckets
WITH risk_classification AS (
    SELECT
      person_age AS age,
      person_income AS annual_income,
      loan_amnt AS loan_amount,
      -- Step A: Fix column names with spaces/symbols using backticks if needed
      loan_status AS is_default,
      -- Step B: Categorize Debt-to-Income ratios into underwriting risk tiers
      CASE
        WHEN loan_percent_income >= 0.40 THEN 'High Strain (40%)'
        WHEN loan_percent_income >= 0.20 AND loan_percent_income < 0.40 THEN 'Moderate Strain (20-39%)'
        ELSE 'Low Strain (0-19%)'
      END AS debt_strain_tier,
      -- Step C: Categorize credit histories to see if past behavior predicts current default
      -- FIX: Forcing the column to be read as text to prevent operator errors
      CASE
        WHEN CAST(cb_person_default_on_file AS STRING) = 'Y' THEN 'Prior History of Default'
        WHEN CAST(cb_person_default_on_file AS STRING) = '1' THEN 'Prior History of Default'
        ELSE 'Clean Credit Record'
      END AS credit_history_profile
    FROM `portfolio_games.raw_credit_risk`
    WHERE person_income IS NOT NULL AND loan_amnt > 0
)

-- Final Selection: Calculate portfolio volume and default rates across risk profiles
SELECT
  debt_strain_tier,
  credit_history_profile,
  -- Measure the volume of total applications in this segment
  COUNT(*) AS total_loan_applications,
  -- Calculate the exact percentage rate of default for this financial cohort
  ROUND((SUM(is_default) / COUNT(*)) * 100, 2) AS default_rate_percentage
FROM risk_classification
GROUP BY debt_strain_tier, credit_history_profile
ORDER BY default_rate_percentage DESC;