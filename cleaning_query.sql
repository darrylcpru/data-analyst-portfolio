SELECT
  Rank,
  Name,
  Platform,
  CASE
    WHEN Year = 'N/A' THEN NULL
    ELSE CAST(Year AS INT64)
  END AS Year_Released,
  Genre,
  Publisher,
  NA_Sales,
  EU_Sales,
  JP_Sales,
  Other_Sales,
  Global_Sales,
FROM `portfolio_games.raw_sales`
WHERE Year != 'N/A' AND Publisher IS NOT NULL;