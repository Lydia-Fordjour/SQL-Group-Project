CREATE DATABASE MINISTORE1;
USE MINISTORE1;
DESCRIBE mini_store1;

SELECT *
FROM mini_store1;

ALTER TABLE mini_store1
MODIFY COLUMN Date Date;

UPDATE mini_store1
SET Date = str_to_date(Date, '%m/%d/%Y');

ALTER TABLE mini_store1
MODIFY COLUMN `Order ID` TEXT;


UPDATE mini_store1
SET `UNIT PRICE` = REPLACE(`UNIT PRICE`, "$", " ");

UPDATE mini_store1
SET `UNIT PRICE` = REPLACE(`UNIT PRICE`, ",", "");


ALTER TABLE mini_store1
MODIFY COLUMN `UNIT PRICE` DECIMAL(10,2);


## Question 1 ##

SELECT*
FROM mini_store1
where date = '2019-01-01';


### Question 2 ###

SELECT*
FROM mini_store1
where `unit price` > 10;


### Question 3 ###

SELECT product, sum(quantity) AS `TOTAL QUANTITY`
FROM mini_store1
GROUP BY PRODUCT HAVING `TOTAL QUANTITY` <5;

### Question 4 ###

SELECT product, category, sum(`unit price`*quantity) AS Total_Sales
FROM mini_store1
GROUP BY PRODUCT, CATEGORY
HAVING `Total_Sales` > 2000;


### Question 5 ###


SELECT PRODUCT, SUM(`UNIT PRICE`*QUANTITY) AS `TOTAL REVENUE`
FROM mini_store1
WHERE `unit price` < 500
GROUP BY product
HAVING `TOTAL REVENUE` > 30000;


### Question 6 ###


SELECT COUNTRY, concat("$", sum(`UNIT PRICE`*QUANTITY)) AS `TOTAL REVENUE`
FROM mini_store1
GROUP BY COUNTRY ORDER BY `TOTAL REVENUE`DESC
LIMIT 1;


### Question 7 ###


SELECT*
FROM mini_store1
ORDER BY DATE desc
limit 5;


### Question 8 ###


SELECT COUNTRY, concat("$", SUM(`UNIT PRICE`*QUANTITY)) AS `TOTAL REVENUE`
FROM mini_store1
GROUP BY COUNTRY ORDER BY `TOTAL REVENUE` ASC
LIMIT 1;


### Question 9 ###

 SELECT *
FROM mini_store1
WHERE `UNIT PRICE` = 15 AND QUANTITY < 5;


### Question 10 ###

SELECT PRODUCT, SUM(QUANTITY) 
FROM mini_store1
GROUP BY PRODUCT
ORDER BY SUM(QUANTITY) DESC;


### Question 11 ###

WITH RankedProducts AS (
    SELECT 
        COUNTRY, 
        PRODUCT, 
        SUM(QUANTITY) AS TotalQuantity,
        RANK() OVER (PARTITION BY COUNTRY ORDER BY SUM(QUANTITY) DESC) AS rnk
    FROM mini_store1
    GROUP BY COUNTRY, PRODUCT
)
SELECT COUNTRY, PRODUCT, TotalQuantity
FROM RankedProducts
WHERE rnk = 1;
