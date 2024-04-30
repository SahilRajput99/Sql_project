-- Retrieve the total number of orders placed.

select count(ORDER_ID) from orders;

-- Calculate the total revenue generated from pizza sales.

select sum(pizzas.price * order_details.quantity) as total_sales
from pizzas
join order_details
on pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza

select pizza_types.name, pizzas.price
from pizza_types
join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
order by pizzas.price desc limit 1;

-- Identify the most common pizza size ordered.

select pizzas.size, count(order_details.ORDER_DETAILS_ID)
from pizzas
join order_details
on pizzas.pizza_id = order_details.PIZZA_ID
group by pizzas.size
order by count(order_details.ORDER_DETAILS_ID) desc;

-- List the top 5 most ordered pizza types along with their quantities.

select pizza_types.name, sum(order_details.QUANTITY) as most_ordered
from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.PIZZA_ID
group by pizza_types.name
order by most_ordered desc limit 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered
select pizza_types.category, sum(order_details.QUANTITY) as quantity
from pizza_types
join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.PIZZA_ID
group by pizza_types.category desc;

-- Determine the distribution of orders by hour of the day
select hour(order_TIME), count(ORDER_ID)
from orders
group by hour(order_TIME)
order by hour(order_TIME);

-- Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name)
from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quantity)) from
(select orders.order_date, sum(order_details.QUANTITY) as quantity
from orders
join order_details
on orders.ORDER_ID = order_details.ORDER_ID
group by order_DATE) as order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue
select pizza_types.name, sum(order_details.QUANTITY * pizzas.price) as revenue
from pizza_types
join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.PIZZA_ID
group by pizza_types.name
order by revenue desc limit 3;

-- Calculate the percentage contribution of each pizza type to total revenue

Select pizza_types.category, (sum(order_details.QUANTITY * pizzas.price) / (select sum(pizzas.price * order_details.quantity) as total_sales
from pizzas
join order_details
on pizzas.pizza_id = order_details.pizza_id) ) * 100 as percentage_pizza_type
from pizza_types
join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.PIZZA_ID
group by pizza_types.category;

-- Analyze the cumulative revenue generated over time.

select order_DATE,
sum(revenue) over(order by order_date)
from
(select orders.order_DATE, sum(pizzas.price * order_details.QUANTITY) as revenue
from
orders
join order_details
on order_details.ORDER_ID = orders.ORDER_ID
join pizzas
on order_details.PIZZA_ID = pizzas.pizza_id
group by orders.ORDER_date) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name, revenue
from
(select category, name, revenue,
rank() over(partition by category order by revenue desc) as rk
from
(select pizza_types.category, pizza_types.name, sum(pizzas.price * order_details.QUANTITY) as revenue
from pizza_types
join pizzas
on pizzas.pizza_type_id =pizza_types.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.PIZZA_ID
group by pizza_types.category, pizza_types.name) as a) as b
where rk <=3;