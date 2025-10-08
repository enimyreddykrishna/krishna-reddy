select * from customers ;
select count(*) from customers;

select * from drivers;
select count(*) from drivers;

select * from food_items ;
select count(*) food_items;

select * from orders;
select count(*) from orders;

select * from orders_items;
select count(*) from orders_items;


select * from restaurants;
use food_hunter;



select * from orders;


DESCRIBE orders;
DESCRIBE orders_items;

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

##Identify Changes in Popular Menu Items
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    item_id,
    COUNT(*) AS item_orders
FROM orders_items
JOIN orders USING(order_id)
GROUP BY month, item_id
ORDER BY month, item_orders DESC;


SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
   order_rating,
    COUNT(customer_id) AS feedback_count
FROM orders
GROUP BY month, order_rating
ORDER BY month, feedback_count DESC;


select avg(order_rating) from orders;


select month(order_date),avg(order_rating) from orders
group by 1;



select month(order_date),count(customer_id) from orders
group by 1;
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    AVG(total_price) AS avg_order_amount
FROM orders
GROUP BY month
ORDER BY month;


SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    AVG(total_amount) AS avg_order_amount
FROM orders
GROUP BY month
ORDER BY month;

show tables;



SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    count(order_id) AS total_customer
FROM orders
GROUP BY month
ORDER BY month;

SELECT 
    DATE_FORMAT(order_rating, '%Y-%m') AS month,
   order_rating,
    COUNT(orders_id) AS count_feedback
FROM ordr
GROUP BY month, feedback_type
ORDER BY month, count_feedback DESC;


select  DATE_FORMAT(item_name, '%Y-%m') AS month, count(restaurant_id)
from food_items
group by restaurant_id ;


show tables from food_hunter ;

select * from restaurants limit 10;

select * from orders limit 5 ;

SELECT 
    COUNT(*) total_records,
    COUNT(DISTINCT customer_id) AS customers
FROM
    orders;
# lets take day wise revenue like running total 
# bfr that lets check the minimum transaction date and max tranaction to have better idea about the data 
SELECT 
    MIN(order_date) AS min_date, MAX(order_date) AS max_date
FROM
    orders;
# min date 2022-06-01 00:00:00
# max date 2022-09-29 00:00:00
-- select order_date,sum(final_price),sum(final_price) over(order by order_date) as running_total
-- from orders
-- group by 1

WITH daily_totals AS (
  SELECT 
    order_date,
    SUM(final_price) AS daily_total
  FROM orders
  GROUP BY order_date
)
SELECT 
  order_date,
  daily_total,
  SUM(daily_total) OVER (ORDER BY order_date) AS running_total
FROM daily_totals;
;

# getting month wise revenue
SELECT 
   MONTH(order_date) AS month,
 SUM(final_price) AS revenue
FROM
    orders

 GROUP BY month;
-- have noticed decline in mom
-- at what level its getting declined 
-- lets check from customer angle
-- lets calculate the KPI's
with kpis as(
select 
		month(o.order_date) as month
        ,
-- 		count(distinct o.customer_id) as customers,
        sum(o.final_price) as revenue
       --  count(distinct oi.order_id) as invoices,
--         sum(oi.quantity) as units
	from orders as o 
    left join orders_items as oi on o.order_id = oi.order_id
    -- where month(o.order_date) = 6
    group by month(o.order_date) )
    
select * from kpis ;
    
--  here i am getting revenue for the month of june is 347577

select count(order_date)
-- count(distinct order_date)
 from orders WHERE order_date BETWEEN '2022-06-01' AND '2022-06-29'
;

-- creating a master table first
with master_table as(
select o.order_id,
		o.customer_id,
        o.order_date,
        o.total_price,
        o.delivery_fee,
        o.discount,
        o.final_price,
        oi.item_id,
        oi.quantity
from orders o right join orders_items oi on o.order_id = oi.order_id
)
select month(order_date) as month,
		count(distinct customer_id) as customers,
        sum(final_price) as revenue,
		count(distinct order_id) as invoices,
        sum(quantity) as units
from master_table
group by month(order_date)
# ------------------------------------- 
-- joins with detail tables multiply rows, so any calculation done on repeated columns (like final_price) is over-counted
WITH monthly_orders AS (
  SELECT
    MONTH(order_date) AS month,
    COUNT(DISTINCT customer_id) AS customers,
    SUM(final_price) AS revenue,
    COUNT(DISTINCT order_id) AS invoices
  FROM orders
  GROUP BY MONTH(order_date)
),
monthly_units AS (
  SELECT
    MONTH(o.order_date) AS month,
    SUM(oi.quantity) AS units
  FROM orders o
  JOIN orders_items oi ON o.order_id = oi.order_id
  GROUP BY MONTH(o.order_date)
)
SELECT
  mo.month,
  mo.customers,
  mo.revenue,
  mo.invoices,
  mu.units
FROM monthly_orders mo
JOIN monthly_units mu ON mo.month = mu.month
ORDER BY mo.month;

-- Monthly Active Customers with Cohort Classification (New, Returning, Churned)




## analysis

use food_hunter;

show tables from food_hunter;

-- lets check this at restaurent wise monthly revenue and customers
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m-01') AS month_start,
    r.restaurant_name,
    SUM(o.final_price) AS revenue
FROM
    orders o
    JOIN orders_items oi ON o.order_id = oi.order_id
    JOIN food_items fi ON oi.item_id = fi.item_id
    JOIN restaurants r ON fi.restaurant_id = r.restaurant_id
GROUP BY
    month_start, r.restaurant_name
ORDER BY
    month_start, revenue DESC;
    
    
    SELECT
    MONTHNAME(o.order_date) AS month,
    r.restaurant_name,
    SUM(o.final_price) AS revenue
FROM
    orders o
    JOIN orders_items oi ON o.order_id = oi.order_id
    JOIN food_items fi ON oi.item_id = fi.item_id
    JOIN restaurants r ON fi.restaurant_id = r.restaurant_id
GROUP BY
    month, r.restaurant_name
ORDER BY
    FIELD(month, 'January','February','March','April','May','June',
                  'July','August','September','October','November','December'),
    revenue DESC;
    
-- lets check the churn rate month wise (new vs existing)
-- dlvry time ?
-- restaurent rating
-
    
    
    
    
  ##  driver performance analysis
    
 SELECT
    d.driver_id,
    d.name,
    d.rating,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.order_rating), 2) AS avg_order_rating,
    ROUND(AVG(
        TIMESTAMPDIFF(MINUTE, o.order_time, o.delivered_time)
    ), 2) AS avg_delivery_time_mins
FROM drivers d
LEFT JOIN orders o ON d.driver_id = o.driver_id
WHERE o.order_date >= '2022-06-01'
GROUP BY d.driver_id, d.name, d.rating
HAVING COUNT(o.order_id) > 0
ORDER BY avg_order_rating ASC, avg_delivery_time_mins DESC
LIMIT 15;

-- New vs. Returning Customer Analysis

WITH
cust_base_june AS (
    SELECT DISTINCT customer_id
    FROM orders
    WHERE MONTH(order_date) = 6
),
cust_base_july AS (
    SELECT DISTINCT customer_id
    FROM orders
    WHERE MONTH(order_date) = 7
),
cust_base_aug AS (
    SELECT DISTINCT customer_id
    FROM orders
    WHERE MONTH(order_date) = 8
),
cust_base_sep AS (
    SELECT DISTINCT customer_id
    FROM orders
    WHERE MONTH(order_date) = 9
),
existing_jun_jul_cust AS (
    SELECT 'existing_jun_jul_cust' AS flag,
           COUNT(DISTINCT cj.customer_id) AS cust
    FROM cust_base_june cj
    INNER JOIN cust_base_july cjl ON cj.customer_id = cjl.customer_id
),
existing_jun_aug_cust AS (
    SELECT 'existing_jun_aug_cust' AS flag,
           COUNT(DISTINCT cj.customer_id) AS cust
    FROM cust_base_june cj
    INNER JOIN cust_base_aug caug ON cj.customer_id = caug.customer_id
),
existing_jun_sep_cust AS (
    SELECT 'existing_jun_sep_cust' AS flag,
           COUNT(DISTINCT cj.customer_id) AS cust
    FROM cust_base_june cj
    INNER JOIN cust_base_sep csep ON cj.customer_id = csep.customer_id
),
existing_jul_aug_cust AS (
    SELECT 'existing_jul_aug_cust' AS flag,
           COUNT(DISTINCT cj.customer_id) AS cust
    FROM cust_base_july cj
    INNER JOIN cust_base_aug caug ON cj.customer_id = caug.customer_id
),
existing_jul_sep_cust AS (
    SELECT 'existing_jul_sep_cust' AS flag,
           COUNT(DISTINCT cj.customer_id) AS cust
    FROM cust_base_july cj
    INNER JOIN cust_base_sep csep ON cj.customer_id = csep.customer_id
),
existing_aug_sep_cust AS (
    SELECT 'existing_aug_sep_cust' AS flag,
           COUNT(DISTINCT cj.customer_id) AS cust
    FROM cust_base_aug cj
    INNER JOIN cust_base_sep csep ON cj.customer_id = csep.customer_id
)

-- ✅ Final SELECT must be part of the same query block
SELECT * FROM existing_jun_jul_cust
UNION
SELECT * FROM existing_jun_aug_cust
UNION
SELECT * FROM existing_jun_sep_cust
UNION
SELECT * FROM existing_jul_aug_cust
UNION
SELECT * FROM existing_jul_sep_cust
UNION
SELECT * FROM existing_aug_sep_cust;
-- total june customers
   SELECT month(order_date) as month, count(DISTINCT customer_id) as customers
    FROM orders
     WHERE MONTH(order_date) = 9
     group by 1 ;
-- 


SELECT
    month(order_date) AS order_month,
    ROUND(AVG(order_rating), 3) AS avg_monthly_rating,
    COUNT(order_id) AS invoices -- to ensure we have enough data points
FROM orders
WHERE order_date >= '2022-06-01' 
  AND order_date < '2022-10-01'
GROUP BY 1 ;

-- 
SELECT
    r.restaurant_name,
    DATE_FORMAT(o.order_date, '%Y-%m-01') AS order_month,
    ROUND(AVG(o.order_rating), 3) AS avg_monthly_rating,
    COUNT(o.order_id) AS rating_count -- to ensure we have enough data points
FROM orders o
JOIN orders_items oi ON o.order_id = oi.order_id
JOIN food_items fi ON oi.item_id = fi.item_id
JOIN restaurants r ON fi.restaurant_id = r.restaurant_id
WHERE o.order_date >= '2022-06-01' 
  AND o.order_date < '2022-10-01'
GROUP BY 1,2
ORDER BY 1,2;

with time_calc as(
select order_date, (delivered_time-order_time) as time_of_dlvry
from orders)
select month(order_date) month,avg(time_of_dlvry) avg_time_dlvry
from time_calc 
group by 1;

with time_calc as (
  select order_date,
         TIME_TO_SEC(delivered_time) - TIME_TO_SEC(order_time) as time_of_dlvry_seconds
  from orders
)
select month(order_date) as month,
       round(avg(time_of_dlvry_seconds)/60, 2) as avg_time_dlvry_minutes
from time_calc
group by 1;

-- lets look at mom discount 

select month(order_date) , avg(discount) as avg_dscnt 
from orders 
group by 1 ;





