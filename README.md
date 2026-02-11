# Cloud-Based Data Pipeline using AWS & SQL

## 📌 Project Overview
This project demonstrates a **serverless cloud-based data pipeline** built using AWS services.  
The pipeline ingests structured CSV data into cloud storage, performs **SQL-based transformations**, and produces **analytics-ready datasets** optimized for reporting and analysis.

The solution follows a **data lake architecture** using Amazon S3 and avoids infrastructure management by leveraging serverless services.

---

## 🎯 Problem Statement
Organizations receive large volumes of structured data that must be stored, transformed, and prepared for analytics in a scalable and cost-effective way.  
Manual or on-premise solutions are difficult to scale and maintain.

This project addresses the problem by building a **cloud-based ELT pipeline** using AWS and SQL.

---

## 🏗️ Architecture
CSV Data Source
↓
Amazon S3 (Raw Data Layer)
↓
AWS Glue Data Catalog
↓
Amazon Athena (SQL Transformations)
↓
Amazon S3 (Analytics Layer – Parquet)


- **Architecture Type:** Serverless  
- **Processing Type:** Batch Processing  
- **Approach:** ELT (Extract, Load, Transform)

---

## 🛠️ Technology Stack
- **Cloud Platform:** AWS  
- **Storage:** Amazon S3  
- **Metadata Management:** AWS Glue Data Catalog  
- **Query Engine:** Amazon Athena  
- **Language:** SQL  
- **Data Formats:** CSV (raw), Parquet (analytics)  

---

## 🔄 Data Pipeline Workflow

### 1️⃣ Data Ingestion
- Structured CSV data is uploaded to Amazon S3.
- S3 acts as the raw data layer of the data lake.

### 2️⃣ Schema Definition
- AWS Glue Data Catalog stores the table metadata.
- Athena uses this schema to query data directly from S3.

### 3️⃣ Data Transformation
- SQL queries in Amazon Athena transform raw data.
- Aggregations and calculations are applied for analytics use cases.

### 4️⃣ Analytics-Ready Output
- Transformed data is stored back in S3 in **Parquet format**.
- This improves query performance and reduces cost.

---

## 📊 Sample SQL Queries

### Create External Table
```sql
CREATE EXTERNAL TABLE sales_raw (
  order_id INT,
  order_date STRING,
  product STRING,
  category STRING,
  quantity INT,
  price INT,
  region STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  'separatorChar' = ',',
  'quoteChar' = '"'
)
LOCATION 's3://cloud-data-pipeline-demo-harish/'
TBLPROPERTIES (
  'skip.header.line.count'='1',
  'use.null.for.invalid.data'='true'
);

Transform Data to Analytics Table
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

✅ Key Features
Serverless and scalable architecture
SQL-based transformations
Optimized storage using Parquet
Cost-efficient pay-per-query model
No infrastructure management

🚧 Challenges & Solutions
Challenge	Solution
Parsing CSV date fields	Stored dates as STRING and cast during transformation
Query performance	Used columnar Parquet format
Cost optimization	Reduced data scanned using optimized SQL


📈 Use Cases
Sales analytics and reporting
Business intelligence dashboards
Learning cloud data engineering concepts


Data warehousing fundamentals
🔮 Future Enhancements
Automate ingestion using AWS Lambda
Add AWS Glue ETL jobs
Implement partitioning for large datasets
Integrate Amazon QuickSight for visualization


👤 Author
Harish Raj S
B.Tech – Computer Science and Business Systems

⭐ How to Use
Upload CSV data to Amazon S3
Create external tables using Athena
Run SQL transformations
Query analytics-ready Parquet data

⭐ If you find this project useful, give it a star!