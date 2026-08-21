SELECT
  `Park Name` AS Park_Name,
  `Primary Location` AS State,
  `Area in acres` AS Acres,
  `Recreation visitors _2021_` AS Annual_Visitors,
  -- Calculate a custom metric: how crowded is the park per acre?
  ROUND((`Recreation visitors _2021_` / `Area in acres`), 2) AS Visitors_Per_Acre
FROM `portfolio_games.raw_parks`
WHERE `Area in acres` IS NOT NULL
AND `Recreation visitors _2021_` > 0
ORDER BY Visitors_Per_Acre DESC;