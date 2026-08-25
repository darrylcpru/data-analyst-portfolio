# Entry-Level Data Analyst Portfolio

## Project 1: Video Game Data Cleaning (SQL)
* **Goal:** Cleaned a raw dataset of 16,000+ video game records to remove null fields and fix date data types.
* **Tools Used:** Google BigQuery Sandbox, SQL
* **Code:** The exact cleaning script can be found in the `cleaning_query.sql` file in this repository.

## Project 2: Video Game Global Sales Dashboard (Tableau)
* **Goal:** Built an interactive dashboard visualizing regional sales trends and dominant gaming genres.
* **Tools Used:** Tableau Public
* **Live Dashboard:** https://public.tableau.com/app/profile/darryl.prunty6442/viz/GlobalVideoGameSalesAnalysis_17872519831340/Dashboard1

## Project 3: US National Parks Density Analysis (SQL & Tableau)
* **Goal:** Analyzed geographic data to calculate an eco-tourism density metric (Visitors per Acre) across US National Parks.
* **Tools Used:** Google BigQuery Sandbox, SQL, Tableau Public Map Visualizations
* **Code:** The cleaning and custom metric script is located in `parks_query.sql`.
* **Live Dashboard:** https://public.tableau.com/app/profile/darryl.prunty6442/viz/USNationalParksAttendanceDensityAnalysis/Dashboard1

## Project 4: E-Commerce Customer Retention & Cohort Matrix (SQL & Tableau)
* **Goal:** Built a monthly retention cohort matrix from raw electronics clickstream transactions to calculate user retention and identify drop-off windows.
* **Data Ingestion Engineering:** Encountered a 100MB browser upload constraint on the raw file. Engineered a local stream-processing script in PowerShell using the `-ReadCount` parameter to split the payload into memory-safe blocks, cleanly initializing the table schema and appending sequential data batches into Google BigQuery without data truncation.
* **Tools Used:** Google BigQuery Sandbox, SQL CTEs, Window Functions (`FIRST_VALUE`), Tableau Public
* **Code & Scripts:** The full SQL cohort aggregation script is available in `ecommerce_cohort_query.sql`.
* **Live Interactive Heatmap:** https://public.tableau.com/app/profile/darryl.prunty6442/viz/E-CommerceCustomerLifecycleCohortRetentionAnalysis/CustomerCohortRetentionMatrix
