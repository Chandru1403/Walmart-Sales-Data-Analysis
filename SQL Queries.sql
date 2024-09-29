CREATE DATABASE WALMART;


-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT,
    gross_income DECIMAL(12, 4),
    rating FLOAT
);


SELECT * FROM sales;

-- ADDING NEW COLUMN FROM THE EXISTING ONE
  
  SELECT time,CASE
            WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
            WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN  "Afternoon"
            ELSE "Evening"
            END as time_of_day
FROM sales;
            
alter table sales add column time_of_day varchar(30);

UPDATE sales
SET time_of_day = case 
            WHEN  time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
			WHEN  time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
            ELSE "Evening"
            END;

SELECT time, time_of_day from sales;

-- ADDING MONTH NAME AS NEW COLUMN

SELECT * from sales;
alter table sales add column month varchar(15);

UPDATE sales
SET month = monthname(date);


-- ADDING DAY NAME AS NEW COLUMN

SELECT * from sales;
alter table sales add column DAY varchar(20);

 UPDATE sales
SET day = dayname(date);

-- HOW MANY UNIQUE CITY DOES THE DATA HAVE

SELECT distinct city from sales;

-- IN WHICH CITY IS EACH BRANCH

SELECT distinct branch from sales;

SELECT distinct city, branch from sales;

--  How many unique product lines does the data have?

SELECT DISTINCT product_line FROM sales;

-- What is the most selling product line

SELECT 
      product_line,
      SUM(quantity) AS total_qty 
FROM sales
GROUP BY product_line
ORDER BY total_qty DESC;

-- What is the total revenue by month
SELECT 
         month,
          SUM(total) as total_revenue 
FROM sales
GROUP BY month
ORDER BY total_revenue DESC;

-- What month had the largest COGS?
SELECT 
	 month ,
     SUM(cogs)as total_cogs 
FROM sales
GROUP BY month
ORDER BY  total_cogs desc;

-- What product line had the largest revenue?

SELECT 
      product_line,
	SUM(total) as total_revenue 
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?

SELECT 
       city,
	SUM(total) as total_revenue 
FROM sales
GROUP BY city
ORDER BY total_revenue DESC;

-- What product line had the largest VAT?

SELECT 
      product_line,
	AVG(tax_pct) as tax  
FROM sales
GROUP BY product_line
ORDER BY tax DESC;


-- Which branch sold more products than average product sold?

SELECT 
      branch, 
      SUM(quantity) as total_sales 
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) from sales);

-- -- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

SELECT 
      AVG(quantity) AS avg_qnty
FROM sales;

SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 5.5 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM sales
GROUP BY product_line;



-- What is the most common product line by gender

SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY product_line ASC;

-- What is the average rating of each product line
SELECT
      product_line,
	ROUND(AVG(rating), 2) as avg_rating 
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- Number of sales made in each time of the day per weekday 
SELECT 
       time_of_day,
        COUNT(total) 
FROM sales
GROUP BY time_of_day ;

-- Which of the customer types brings the most revenue?

SELECT
      customer_type,
      SUM(total) AS Total_sales 
FROM sales
GROUP BY customer_type
ORDER BY Total_sales DESC;

-- Which city has the largest tax/VAT percent?

SELECT
      city,
      ROUND(AVG(tax_pct),2) AS tax FROM sales
GROUP BY city
ORDER BY tax DESC;

-- Which customer type pays the most in VAT?

SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax DESC;



-- How many unique customer types does the data have?
SELECT 
       DISTINCT customer_type as total_customer_type 
FROM sales;
       
-- How many unique payment methods does the data have?

SELECT 
		DISTINCT payment as total_customer_type
FROM sales;
        
-- What is the most common customer type?

SELECT
	customer_type,
	count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?

SELECT
	customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type;

-- What is the gender of most of the customers?

SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?

SELECT
	gender,branch,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender,branch
ORDER BY branch ASC ;

-- Which time of the day do customers give most ratings?

SELECT
	time_of_day,
	ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

