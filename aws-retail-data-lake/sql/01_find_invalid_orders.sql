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
   OR unit_price <= 0
ORDER BY order_id;
