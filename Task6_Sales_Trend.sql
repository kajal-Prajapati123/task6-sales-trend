-- This script loads data from  oniline_sales.CSV file into MySQL tables
-- Author: Kajal
-- Internship Task : Analyze monthly revenue and order volume

CREATE DATABASE online_sales_analysis;
USE online_sales_analysis;
CREATE TABLE online_sales(
transaction_id INT,
order_date DATE,
product_category VARCHAR(100),
product_name VARCHAR(100),
unit_sold INT,
unit_price DECIMAL(10,2),
total_revenue DECIMAL(12,2),
region VARCHAR(100),
payment_method VARCHAR(50)
);

-- SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Online Sales Data.csv'
INTO TABLE online_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(transaction_id, @order_date, product_category, product_name, unit_sold, unit_price, total_revenue, region, payment_method)
SET order_date = STR_TO_DATE(@order_date, '%m/%d/%Y');

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(total_revenue) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS total_orders
FROM
    online_sales
GROUP BY
    order_year, order_month
ORDER BY
    order_year, order_month;


