

--- CREATING DATABSE---
CREATE DATABASE sales_db ;

 --Shows existing databases 
SHOW DATABASES ; 

--- JUST CHECKING THE TABLE BEFORE ENTERING THE DATA
SELECT * FROM sales; 

----Creating a table named 'sales' to store sales data
CREATE TABLE sales (
    SalesID INT PRIMARY KEY AUTO_INCREMENT,
    Year INT,
    SalesAmount DECIMAL(10,2),
    ProductCategory VARCHAR(50)
)
 ----Describing the structure of the 'sales' table ----
DESC sales;

-- Insert sample sales data into the 'sales' table
INSERT INTO sales (Year, SalesAmount, ProductCategory)
VALUES
  (2022, 1000, 'Electronics'),
  (2022, 1500, 'Electronics'),
  (2022, 2000, 'Electronics'),
  (2022, 2500, 'Electronics'),
  (2023, 1100, 'Electronics'),
  (2023, 1600, 'Electronics'),
  (2023, 2100, 'Electronics'),
  (2023, 2600, 'Electronics'),
  (2024, 1200, 'Electronics'),
  (2024, 1700, 'Electronics'),
  (2022,  800, 'Furniture'),
  (2022, 1300, 'Furniture'),
  (2022, 1800, 'Furniture'),
  (2022, 2300, 'Furniture'),
  (2023,  900, 'Furniture'),
  (2023, 1400, 'Furniture'),
  (2023, 1900, 'Furniture'),
  (2023, 2400, 'Furniture'),
  (2024, 1000, 'Furniture'),
  (2024, 1500, 'Furniture');


--- RETRIVING THE DATA FROM THE TABLE
SELECT * FROM sales; 
    
  WITH SalesData AS (   
  SELECT
    Year,
    QUARTER(DATE_FORMAT(CONCAT(Year, '-01-01'), '%Y-%m-%d')) AS Quarter,
    ProductCategory,
    SUM(SalesAmount) AS TotalSales
  FROM sales
  GROUP BY Year, QUARTER(DATE_FORMAT(CONCAT(Year, '-01-01'), '%Y-%m-%d')), ProductCategory
),
GrandTotals AS (
  SELECT
    'Grand Total' AS Year,
    'Grand Total' AS Quarter,
    ProductCategory,
    SUM(TotalSales) AS TotalSales
  FROM SalesData
  GROUP BY ProductCategory
  UNION ALL
  SELECT
    'Grand Total' AS Year,
    'Grand Total' AS Quarter,
    'Grand Total' AS ProductCategory,
    SUM(TotalSales) AS TotalSales
  FROM SalesData
)
SELECT
  Year,
  Quarter,
  ProductCategory,
  TotalSales
FROM SalesData
UNION ALL
SELECT
  Year,
  Quarter,
  ProductCategory,
  TotalSales
FROM GrandTotals
ORDER BY
  CASE WHEN Year = 'Grand Total' THEN 2 ELSE 1 END,
  CASE WHEN Quarter = 'Grand Total' THEN 2 ELSE 1 END,
  ProductCategory;


  DESC sales ;