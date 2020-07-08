-- Create the schema
CREATE SCHEMA `regression` ;

-- Create the table with the relevant fields and keys (if applicable)
CREATE TABLE regression(
   year       NUMERIC(6,1) NOT NULL
  ,month      NUMERIC(4,1) NOT NULL
  ,month_name VARCHAR(9) NOT NULL
  ,south      NUMERIC(4,1) NOT NULL
  ,west       NUMERIC(4,1) NOT NULL
  ,midwest    NUMERIC(4,1) NOT NULL
  ,northeast  NUMERIC(4,1) NOT NULL
);

-- Check for the path for which the data import is allowed in your MYSQL configuration
SHOW VARIABLES LIKE "secure_file_priv";

-- Load the data
-- The variable value above will be the path as - 'path/filename.csv'
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Raw data for the linear regression exercise.csv'
into table regression.regression
fields terminated by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
