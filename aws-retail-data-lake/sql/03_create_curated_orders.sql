CREATE TABLE retail_lake.curated_orders
WITH (
    format = 'PARQUET',
    external_location = 's3://nw-retail-lake-jignac-2026/curated/orders/'
)
AS
SELECT
    order_id,
    CAST(order_date AS DATE) AS order_date,
    region,
    product,
    quantity,
    unit_price,
    quantity * unit_price AS revenue
FROM retail_lake.retail_orders
WHERE region IS NOT NULL
  AND region <> ''
  AND quantity > 0
  AND unit_price > 0;
