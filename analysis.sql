--membuat database
CREATE DATABASE test_ds;

-- gunakan database
USE test_ds;

-- create table
CREATE TABLE e_commerce_transactions (
  order_id INT,
  customer_id INT,
  order_date TEXT,
  payment_value FLOAT,
  decoy_flag FLOAT,
  decoy_noise FLOAT
);



-- import data
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'D:/WORK/REMOTE/ds-takehome/data/e_commerce_transactions.csv'
INTO TABLE e_commerce_transactions
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

