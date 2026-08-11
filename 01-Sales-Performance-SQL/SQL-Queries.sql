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



-- 7. Product category has the highest repeat purchase
WITH cust_purchase AS (
    SELECT 
        cat.categoryname AS cat_name,
        sales.CustomerID AS cust_id,
        COUNT(DISTINCT sales.SalesID) AS total_purchase
    FROM fsda-sql-01.grocery_dataset.categories AS cat
    JOIN fsda-sql-01.grocery_dataset.products AS prod
        ON cat.categoryid = prod.categoryid
    JOIN fsda-sql-01.grocery_dataset.sales AS sales
        ON sales.ProductID = prod.productid
    GROUP BY 1, 2
),

repeat_cust AS (
    SELECT 
        cat.categoryname AS cat_name,
        sales.CustomerID AS cust_id,
        COUNT(DISTINCT sales.SalesID) AS total_purchase
    FROM fsda-sql-01.grocery_dataset.categories AS cat
    JOIN fsda-sql-01.grocery_dataset.products AS prod
        ON cat.categoryid = prod.categoryid
    JOIN fsda-sql-01.grocery_dataset.sales AS sales
        ON sales.ProductID = prod.productid
    GROUP BY 1, 2
    HAVING COUNT(DISTINCT sales.SalesID) > 1
),

CTE1 AS (
    SELECT 
        cat_name,
        COUNT(DISTINCT cust_id) AS tot_cust
    FROM cust_purchase
    GROUP BY 1
),

CTE2 AS (
    SELECT 
        cat_name,
        COUNT(DISTINCT cust_id) AS tot_cust_repeat
    FROM repeat_cust
    GROUP BY 1
)

SELECT 
    CTE1.cat_name,
    CTE1.tot_cust,
    CTE2.tot_cust_repeat,
    ROUND(tot_cust_repeat / tot_cust * 100, 2) AS cust_repeat_pct
FROM CTE1
JOIN CTE2 
    ON CTE1.cat_name = CTE2.cat_name
ORDER BY 4 DESC;

-- 8.  the cumulative amount of transaction of the top user 

WITH cte1 AS (
    SELECT 
        CustomerID,
        SUM(price * Quantity * (1 - Discount)) AS total_rev
    FROM fsda-sql-01.grocery_dataset.sales AS sales
    LEFT JOIN fsda-sql-01.grocery_dataset.products AS prod
        ON sales.productID = prod.productid
    GROUP BY 1
),

cte2 AS (
    SELECT 
        CustomerID
    FROM cte1
    ORDER BY total_rev DESC
    LIMIT 1
)

SELECT 
    cte2.CustomerID,
    cust.firstname,
    cust.lastname,
    TransactionNumber,
    SalesDate,
    prod.price * sales.Quantity * (1 - sales.Discount) AS transaction_value,
    SUM(prod.price * sales.Quantity * (1 - sales.Discount)) OVER (
        ORDER BY SalesDate, TransactionNumber
    ) AS cumulative_amount
FROM cte2
JOIN fsda-sql-01.grocery_dataset.sales AS sales
    ON cte2.CustomerID = sales.CustomerID
JOIN fsda-sql-01.grocery_dataset.customers AS cust
    ON cte2.CustomerID = cust.customerid
JOIN fsda-sql-01.grocery_dataset.products AS prod
    ON sales.productID = prod.productid;
