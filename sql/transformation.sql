CREATE TABLE sales_analytics
WITH (
  format = 'PARQUET',
  external_location = 's3://cloud-data-pipeline-demo-harish/analytics/'
) AS
SELECT
  CAST(order_date AS DATE) AS order_date,
  category,
  region,
  SUM(quantity) AS total_units_sold,
  SUM(quantity * price) AS total_revenue
FROM sales_raw
GROUP BY CAST(order_date AS DATE), category, region;