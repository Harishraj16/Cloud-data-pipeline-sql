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
