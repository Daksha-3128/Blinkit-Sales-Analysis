create database blinkit_sales_analysis;
use blinkit_sales_analysis;
# What are the major reasons behind delivery delays and are they related to distance?
select
reasons_if_delayed,
count(dp.order_id) as total_orders,
round(avg(dp.distance_km),2) as avg_distance,
round(avg(dp.delivery_time_minutes),2) as avg_delivery_time
from delivery_performance as dp
group by reasons_if_delayed
order by avg_distance desc
limit 7;
#ANALYSIS
#Traffic was the most common recorded reason for delivery delays,affecting 666 orders.
#The average distance for these orders was 2.68km, while the average delay was 8.4 minutes.
#This suggests that traffic congestion can cause delivery delays even when the average distance is 2.68 km.


# Which marketing campaigns perform best in terms of reach,engagement,conversions and revenue generations ?
select
campaign_name,
sum(mp.impressions) as total_impressions,
sum(mp.clicks) as total_clicks,
sum(mp.conversions) as total_conversions,
sum(mp.revenue_generated) as total_rev,
round(avg(roas),2) as avg_roas
from market_performance as mp
group by campaign_name
order by total_rev desc,
total_conversions desc,
total_impressions desc,
total_clicks desc;
#ANALYSIS
#Referral Program performed best based on highest revenue generated.
#It showed strong conversion performance, driving more purchases.
#The campaign achieved good reach through higher impressions and clicks.
#Good ROAS indicates efficient ad spending.
#Overall, Festival Offer was the most effective campaign.

# Which products generate the highest sale revenue?
select
p.product_name,
sum(od.revenue) as total_rev
from cleaned_order_item as od
join product as p on od.product_id=p.product_id
group by p.product_name
order by total_rev desc
limit 10;
#ANALYSIS
#Vitamins was the top revenue-generating product, indicating strong sales performance.

# What are the major factors driving negative customer feedback?
select
cf.feedback_category,
count(cf.feedback_id) as negative_feedback_count,
round(avg(cf.rating),2) as avg_rating
from customer_feedback as cf
where cf.sentiment='negative'
group by cf.feedback_category
order by negative_feedback_count desc;
#ANALYSIS
#Product Quality received the highest negative feedback, indicating customer dissatisfaction with product quality.

# How do customer segments differ in purchasing behaviour and value?
select
co.customer_segment,
sum(co.total_orders) as sum_of_total_orders,
round(avg(co.avg_order_value),2) as avg_of_orders
from cleaned_customers as co
group by co.customer_segment
order by avg_of_orders desc;
#ANALYSIS
# New customers showed the highest purchasing value, with the highest total orders and average order value among all segments.

# Which product category generate the highest revenue?
select
p.category,
sum(od.revenue) as total_rev
from cleaned_order_item as od
join Product as p on od.product_id=p.product_id
group by p.category
order by total_rev desc
limit 10;
#ANALYSIS
# The Dairy and Breakfast generated the highest revenue among all products categories. 

# Which brands are the top performers in terms of sales?
select
p.brand,
sum(od.quantity*od.unit_price) as total_sales
from cleaned_order_item as od
join Product as p on od.product_id=p.product_id
group by p.brand
order by total_sales desc
limit 10;
#ANALYSIS
# Chahal Group generated the highest revenue among all brands. 

# Which products are the best selling products?
select
od.product_id,
p.product_name,
sum(od.quantity) as total_quantity
from cleaned_order_item as od
join Product as p on od.product_id=p.product_id
group by od.product_id,p.product_name
order by total_quantity desc
limit 10;
#ANALYSIS
# Pet Treats was the best selling product based on total quantity sold. 
 
 # Does product price affect demand?
select
od.product_id,
p.product_name,
p.price,
case
when p.price<500 then 'low'
when p.price between 500 and 1000 then 'medium'
else 'high'
end as price_category,
sum(od.quantity) as total_quantity
from cleaned_order_item as od
join Product as p on od.product_id=p.product_id
group by od.product_id,p.product_name,p.price
order by total_quantity desc
limit 10;
#ANALYSIS
# Price alone does not determine demand, as other factors like product preferences and category also influence sales. 

# Does discount impact product sales?
select
case
when p.discount_percentage<10 then 'low discount'
when p.discount_percentage between 10 and 30 then 'medium discount'
else 'high discount'
end as discount_category,
count(distinct p.product_id) as total_products,
sum(od.quantity) as total_quantity
from cleaned_order_item as od
join Product as p on od.product_id=p.product_id
group by discount_category
order by total_quantity desc
limit 10;
#ANALYSIS
#Medium discount products generated higher total quantity sold compared to high discount products,
# indicating that higher discounts do not always lead to higher sales.

# Are high margins product also generating high revenue?
select
p.product_name,
p.margin_percentage,
sum(od.revenue) as total_rev
from cleaned_order_item as od
join Product as p on od.product_id=p.product_id
group by p.product_name,p.margin_percentage
order by total_rev desc
limit 10;
#ANALYSIS
# High margin products do not always generate higher revenue, 
#indicating that margin percentage alone does not determine revenue performance.






