
-- Top 5 products by revenue
SELECT Product, ROUND(SUM(Revenue), 2) AS total_revenue
FROM sales
GROUP BY Product
ORDER BY total_revenue DESC
LIMIT 5;

-- Monthly revenue trend
SELECT strftime('%Y-%m', Date) AS YearMonth, ROUND(SUM(Revenue), 2) AS revenue
FROM sales
GROUP BY YearMonth
ORDER BY YearMonth;

-- Revenue by region and category
SELECT Region, Category, ROUND(SUM(Revenue), 2) AS revenue
FROM sales
GROUP BY Region, Category
ORDER BY Region, revenue DESC;

-- Customer segmentation (high vs low spenders using threshold)
WITH spend AS (
  SELECT CustomerID, SUM(Revenue) AS total_spend
  FROM sales
  GROUP BY CustomerID
)
SELECT
  CASE WHEN total_spend >= 2000 THEN 'High' ELSE 'Low' END AS segment,
  COUNT(*) AS customers,
  ROUND(SUM(total_spend), 2) AS segment_revenue
FROM spend
GROUP BY segment
ORDER BY segment_revenue DESC;
