-- RevoGrocers Sales Performance Analysis
-- Source: Revou FSDA assignment
-- SQL Analyst


-- 1. Highest-performing product categories by revenue after discount
SELECT
  cat.categoryname AS category_name,
  SUM(prod.price * sales.Quantity * (1 - sales.Discount)) AS total_revenue
FROM fsda-sql-01.grocery_dataset.categories AS cat
JOIN fsda-sql-01.grocery_dataset.products AS prod
  ON cat.categoryid = prod.categoryid
JOIN fsda-sql-01.grocery_dataset.sales AS sales
  ON sales.ProductID = prod.productid
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;


-- 2. Relationship between revenue after discount and total units sold
SELECT
  cat.categoryname AS category_name,
  SUM(sales.Quantity) AS total_unit_sold,
  SUM(prod.price * sales.Quantity * (1 - sales.Discount)) AS total_revenue
FROM fsda-sql-01.grocery_dataset.categories AS cat
JOIN fsda-sql-01.grocery_dataset.products AS prod
  ON cat.categoryid = prod.categoryid
JOIN fsda-sql-01.grocery_dataset.sales AS sales
  ON sales.ProductID = prod.productid
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5;


-- 3. Revenue after discount and unique customers by category
SELECT
  cat.categoryname AS category_name,
  COUNT(DISTINCT sales.CustomerID) AS total_unique_cust,
  SUM(prod.price * sales.Quantity * (1 - sales.Discount)) AS total_revenue
FROM fsda-sql-01.grocery_dataset.categories AS cat
JOIN fsda-sql-01.grocery_dataset.products AS prod
  ON cat.categoryid = prod.categoryid
JOIN fsda-sql-01.grocery_dataset.sales AS sales
  ON sales.ProductID = prod.productid
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5;


-- 4. Average unit price by product category
SELECT
  cat.categoryname AS category_name,
  AVG(prod.price) AS average_price_unit
FROM fsda-sql-01.grocery_dataset.categories AS cat
JOIN fsda-sql-01.grocery_dataset.products AS prod
  ON cat.categoryid = prod.categoryid
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- 5. Average price and unique customers by category
WITH avg_price AS (
  SELECT
    cat.categoryname AS category_name,
    AVG(prod.price) AS average_price_unit
  FROM fsda-sql-01.grocery_dataset.categories AS cat
  JOIN fsda-sql-01.grocery_dataset.products AS prod
    ON cat.categoryid = prod.categoryid
  GROUP BY 1
),
uniq_cust AS (
  SELECT
    cat.categoryname AS category_name,
    COUNT(DISTINCT sales.CustomerID) AS total_uniq_cust
  FROM fsda-sql-01.grocery_dataset.categories AS cat
  JOIN fsda-sql-01.grocery_dataset.products AS prod
    ON cat.categoryid = prod.categoryid
  JOIN fsda-sql-01.grocery_dataset.sales AS sales
    ON sales.ProductID = prod.productid
  GROUP BY 1
)
SELECT
  avg_price.category_name,
  avg_price.average_price_unit,
  uniq_cust.total_uniq_cust
FROM avg_price
JOIN uniq_cust
  ON avg_price.category_name = uniq_cust.category_name
LIMIT 5;


-- 6. Category contribution to overall revenue after discount
WITH category_revenue AS (
  SELECT
    cat.categoryname AS category_name,
    SUM(prod.price * sales.Quantity * (1 - sales.Discount)) AS total_revenue
  FROM fsda-sql-01.grocery_dataset.categories AS cat
  JOIN fsda-sql-01.grocery_dataset.products AS prod
    ON cat.categoryid = prod.categoryid
  JOIN fsda-sql-01.grocery_dataset.sales AS sales
    ON sales.ProductID = prod.productid
  GROUP BY 1
)
SELECT
  category_name,
  total_revenue,
  SUM(total_revenue) OVER () AS sum_total_rev,
  ROUND(total_revenue / SUM(total_revenue) OVER () * 100, 1) AS rev_percentage
FROM category_revenue
ORDER BY 4;
