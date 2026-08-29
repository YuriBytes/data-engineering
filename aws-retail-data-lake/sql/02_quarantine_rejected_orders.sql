CREATE TABLE retail_lake.rejected_orders
WITH (
    format = 'PARQUET',
    external_location = 's3://nw-retail-lake-jignac-2026/quarantine/orders/'
)
AS
SELECT
    order_id,
    order_date,
    region,
    product,
    quantity,
    unit_price
FROM retail_lake.retail_orders
WHERE region IS NULL
   OR region = ''
   OR quantity <= 0
   OR unit_price <= 0;
