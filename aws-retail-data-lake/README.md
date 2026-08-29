## Overview

My very first project demonstrates a serverless data pipeline built entirely on AWS. It transforms raw and messy retail transaction logs into a clean, highly optimized analytics layer.  

Goals:

1. Enforce strict, deterministic data typing instead of relying on automated crawler guesswork.
2. Automatically filter out anomalous records before they corrupt downstream reporting. 
3. Drastically reduce query costs and execution time by transitioning data from plain-text CSVs to compressed, columnar Parquet files.  
4. Establish a fully traceable Quarantine Zone for invalid records to enable future root-cause analysis without discarding source evidence.

### Data Visualization
*Final Output:*
<img width="878" height="279" alt="regional-sales-report" src="https://github.com/user-attachments/assets/8b63b24f-4077-4723-a605-4b9f6541ec4c" />


### Data Architecture

<img width="5030" height="2413" alt="architecturediagram" src="https://github.com/user-attachments/assets/a7e63017-d692-479c-80ad-25ac4a1ef531" />


I'm still very new to architecturing cloud diagrams, but I used Amazon S3 for durable, highly scalable, and cost-effective storage. By separating the data into Raw, Curated, and Quarantine zones, I was able to preserve the original source evidence behind every data quality decision. For the metadata layer, I configured AWS Glue with a custom CSV classifier to make the table predictable by explicitly defining the schema upfront, guaranteeing that my Amazon Athena queries will always hit the exact table structure I expect. I chose Athena for serverless SQL querying because it completely separates computing from storage. Since Athena uses a pay-per-query model based exactly on the amount of data scanned, I used CTAS queries to transform messy plain-text data into analytics-ready Parquet datasets. Parquet's columnar format naturally minimizes that "data scanned" metric, driving down costs and making the entire pipeline highly cost-effective.

## Prerequisites

- An active AWS Account.
- IAM permissions configured to create and manage resources in Amazon S3, AWS Glue, and Amazon Athena.
- The source data file (orders.csv).

## How to Run This Project

1. Set Up S3 Storage Zones: Create an Amazon S3 bucket and establish distinct prefixes for your data lifecycle: /raw/orders/, /curated/orders/, /quarantine/orders/, and an athena-results/ location for query logs.
2. Ingest Raw Data: Upload the orders.csv file into the /raw/orders/ prefix.
3. Catalog the Data: In AWS Glue, create a custom CSV classifier to explicitly define column types (e.g., LONG, STRING, DOUBLE). Run an AWS Glue Crawler using this classifier to register the retail_lake database and table.  
4. Data Quality Checks: Open Amazon Athena and execute 01_find_invalid_orders.sql to identify records with missing regions or non-positive quantities and prices.
5. Create Curated Dataset: Run the CTAS (Create Table As Select) query (02_create_curated_parquet.sql) to convert valid records into Apache Parquet format and store them in the Curated Zone.
6. Quarantine Invalid Records: Run 03_quarantine_rejected_records.sql to route failing records into a dedicated Parquet-backed quarantine table for traceability.
7. Generate Business Insights: Execute 04_regional_sales_report.sql against the curated Parquet dataset to aggregate total revenue by region.

## Lessons Learned

The most challenging part of this project was navigating AWS console errors. Specifically, I was facing IAM role problems during the Glue crawler setup. I also learned how to debug path-formatting issues to prevent 403 Forbidden errors when writing query results to S3.

## Contact

Please feel free to contact me if you have any questions at:
[LinkedIn](https://www.linkedin.com/in/eurilaya/)
