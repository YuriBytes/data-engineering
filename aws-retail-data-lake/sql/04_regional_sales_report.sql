SELECT
  region,
  COUNT(*) AS order_count,
  SUM(quantity) AS units_sold,
  SUM(revenue) AS total_revenue
FROM retail_lake.curated_orders
GROUP BY region
ORDER BY total_revenue DESC;
