create database starbucks;
use starbucks;

-- How do sales vary by day of the week and hour of day

SELECT 
    DAYNAME(transaction_date) AS day_of_week,
    HOUR(orders_table.transaction_time) AS hour_of_day,
    round(SUM(products_table.unit_price * orders_table.transaction_qty),2) AS total_sales
FROM orders_table join products_table
on orders_table.product_id = products_table.product_id
GROUP BY day_of_week, hour_of_day
ORDER BY FIELD(day_of_week, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'),
         hour_of_day;

-- Are there any peak time for sales activity  

select hour(orders_table.transaction_time) as peak_time, 
round(sum(products_table.unit_price * orders_table.transaction_qty),2) as total_sales
from orders_table join products_table
on orders_table.product_id  = products_table.product_id
group by peak_time
order by total_sales desc; 

-- What is the total sales revenue for each month

select monthname(orders_table.transaction_date) as month_name,
round(sum(products_table.unit_price * orders_table.transaction_qty),2) as total_sales
from orders_table join products_table
on orders_table.product_id = products_table.product_id
group by month(orders_table.transaction_date), month_name
order by month(orders_table.transaction_date);

-- How to sales vary across different store locations

select orders_table.store_location as location, 
round(sum(products_table.unit_price * orders_table.transaction_qty),2) as total_sales
from orders_table join products_table
on orders_table.product_id = products_table.product_id
group by location;

-- What is the average price/order per person

select products_table.product_id, 
round(avg(products_table.unit_price * orders_table.transaction_qty),2) as average_price 
from products_table join orders_table
group by products_table.product_id
order by average_price desc;

-- Which products are best selling in terms of quantity and revenue

select products_table.product_type, count(orders_table.transaction_qty) as total_count,
round(avg(products_table.unit_price * orders_table.transaction_qty),2) as revenue
from products_table join orders_table
on products_table.product_id = orders_table.product_id
group by products_table.product_type;


-- How do sales vary by product, category and type

select products_table.product_category, products_table.product_type,
round(sum(products_table.unit_price * orders_table.transaction_qty),2) as total_sales
from products_table join orders_table
on products_table.product_id = orders_table.product_id
group by products_table.product_category, products_table.product_type
order by total_sales desc;








