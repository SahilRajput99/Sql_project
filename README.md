
# Comprehensive Analysis of Pizza Sales Data
## Problem Statement:
In today's competitive food industry, understanding sales patterns and customer preferences is crucial for business success. The objective of this project is to analyze pizza sales data to derive meaningful insights that can help optimize inventory, improve marketing strategies, and enhance customer satisfaction.

## Objective:
- Understanding Customer Behavior: Analyze the ordering patterns and preferences of customers to identify trends and popular choices.
- Performance Evaluation: Evaluate the company's performance metrics such as total orders placed, revenue generated, highest-priced pizza, and common pizza sizes ordered.
- Improvement Opportunities: Identify areas for improvement based on customer satisfaction ratings, average order delay, and distribution of orders by hour of the day.
- Strategic Decision Making: Provide actionable insights to assist the company in making strategic decisions to enhance customer satisfaction and operational efficiency.

## Data Description
The project utilizes four tables containing pizza sales data:

### Orders Table
Columns: order_id, date, time
### Order Details Table
Columns: order_details_id, order_id, pizza_id, quantity
### Pizza Types Table
Columns: pizza_type_id, name, category, ingredients
### Pizzas Table
Columns: pizza_id, pizza_type_id, size, price

## Step-by-Step Process:

### Step 1: Log into MySQL:
Open the MySQL command-line client and log in with your username and password:

        mysql -u root -p
- -u root: Specifies the username (root).
- -p: Prompts for the password.

### Step 2: Create the Database and Tables:
1. Create a New Database: Create a database to store your pizza sales data:

        CREATE DATABASE pizza_sales;
        USE pizza_sales;
- CREATE DATABASE pizza_sales;: Creates a new database named pizza_sales.
- USE pizza_sales;: Selects the pizza_sales database for use.

2. Create Tables: Create the necessary tables (orders, order_details, pizza_types, pizzas) using the following SQL commands:

        CREATE TABLE orders (
            order_id INT PRIMARY KEY,
            date DATE,
            time TIME
        );

        CREATE TABLE order_details (
            order_details_id INT PRIMARY KEY,
            order_id INT,
            pizza_id INT,
            quantity INT,
            FOREIGN KEY (order_id) REFERENCES orders(order_id)
        );

        CREATE TABLE pizza_types (
            pizza_type_id INT PRIMARY KEY,
            name VARCHAR(255),
            category VARCHAR(255),
            ingredients TEXT
        );

        CREATE TABLE pizzas (
            pizza_id INT PRIMARY KEY,
            pizza_type_id INT,
            size VARCHAR(50),
            price DECIMAL(10, 2),
            FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id)
        );
- Each CREATE TABLE statement creates a table with specified columns and data types.
- PRIMARY KEY: Defines the primary key for each table.
- FOREIGN KEY: Establishes a relationship between tables.

### Step 3: Import Data into Tables
1. Prepare Data Files: Ensure you have CSV files for each table. For example:
- orders.csv
- order_details.csv
- pizza_types.csv
- pizzas.csv

2. Load Data into Tables: Use the LOAD DATA INFILE command to import data from CSV files into the MySQL tables. Adjust the file paths as needed.

        LOAD DATA INFILE '/path/to/orders.csv'
        INTO TABLE orders
        FIELDS TERMINATED BY ',' 
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;

        LOAD DATA INFILE '/path/to/order_details.csv'
        INTO TABLE order_details
        FIELDS TERMINATED BY ',' 
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;

        LOAD DATA INFILE '/path/to/pizza_types.csv'
        INTO TABLE pizza_types
        FIELDS TERMINATED BY ',' 
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;

        LOAD DATA INFILE '/path/to/pizzas.csv'
        INTO TABLE pizzas
        FIELDS TERMINATED BY ',' 
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;

- LOAD DATA INFILE '/path/to/file.csv': Specifies the file to load data from.
- INTO TABLE table_name: Specifies the table to load data into.
- FIELDS TERMINATED BY ',': Specifies that fields in the file are separated by commas.
- LINES TERMINATED BY '\n': Specifies that lines in the file are separated by newlines.
- IGNORE 1 ROWS: Ignores the first row, typically the header.

### Step 4: Basic Queries
### 1. Retrieve the total number of orders placed:

        SELECT COUNT(order_id) AS total_orders FROM orders;

- SELECT COUNT(order_id): Counts the number of rows in the orders table, which corresponds to the total number of orders placed.
- AS total_orders: Aliases the result as total_orders

### 2. Calculate the total revenue generated from pizza sales:

        select sum(pizzas.price * order_details.quantity) as total_sales
        from pizzas
        join order_details
        on pizzas.pizza_id = order_details.pizza_id;

- SELECT SUM(pizzas.price * order_details.quantity): Calculates the total revenue by multiplying the price of each pizza by the quantity ordered.
- FROM pizzas JOIN order_details ON pizzas.pizza_id = order_details.pizza_id: Joins the pizzas and order_details tables on the pizza_id column to match each order detail with its corresponding pizza.

### 3. Identify the highest-priced pizza:

        select pizza_types.name, pizzas.price
        from pizza_types
        join pizzas
        on pizzas.pizza_type_id = pizza_types.pizza_type_id
        order by pizzas.price desc limit 1;

- SELECT pizza_types.name, pizzas.price: Selects the name and price of the pizzas.
- FROM pizza_types JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id: Joins the pizza_types and pizzas tables on the pizza_type_id column to match each pizza with its type.
- ORDER BY pizzas.price DESC LIMIT 1: Orders the result by price in descending order and limits the result to the top one, which gives the highest-priced pizza.

### 4. Identify the most common pizza size ordered:

        SELECT pizzas.size, COUNT(order_details.order_details_id) AS size_count
        FROM pizzas
        JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
        GROUP BY pizzas.size
        ORDER BY size_count DESC LIMIT 1;

- SELECT pizzas.size, COUNT(order_details.order_details_id) AS size_count: Selects the size of the pizzas and counts the number of orders for each size.
- FROM pizzas JOIN order_details ON pizzas.pizza_id = order_details.pizza_id: Joins the pizzas and order_details tables on the pizza_id column to match each order detail with its corresponding pizza.
- GROUP BY pizzas.size: Groups the result by the size of the pizzas.
- ORDER BY size_count DESC LIMIT 1: Orders the result by the count in descending order and limits the result to the top one, which gives the most common pizza size ordered.

### 5. List the top 5 most ordered pizza types along with their quantities:

        SELECT pizza_types.name, SUM(order_details.quantity) AS most_ordered
        FROM pizza_types
        JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
        GROUP BY pizza_types.name
        ORDER BY most_ordered DESC LIMIT 5;

- SELECT pizza_types.name, SUM(order_details.quantity) AS most_ordered: Selects the name of the pizza types and sums the quantities ordered for each type.
- FROM pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id JOIN order_details ON pizzas.pizza_id = order_details.pizza_id: Joins the pizza_types, pizzas, and order_details tables to match each order detail with its corresponding pizza and pizza type.
- GROUP BY pizza_types.name: Groups the result by the name of the pizza types.
- ORDER BY most_ordered DESC LIMIT 5: Orders the result by the total quantity ordered in descending order and limits the result to the top five, which gives the top 5 most ordered pizza types along with their quantities.

### 6. Join the necessary tables to find the total quantity of each pizza category ordered:

        SELECT pizza_types.category, SUM(order_details.quantity) AS quantity
        FROM pizza_types
        JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
        GROUP BY pizza_types.category
        ORDER BY quantity DESC;

- SELECT pizza_types.category, SUM(order_details.quantity) AS quantity: Selects the category of pizzas and sums the quantities ordered for each category.
- FROM pizza_types JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id JOIN order_details ON pizzas.pizza_id = order_details.pizza_id: Joins the pizza_types, pizzas, and order_details tables to match each order detail with its corresponding pizza and pizza type.
- GROUP BY pizza_types.category: Groups the result by the category of pizzas.
- ORDER BY quantity DESC: Orders the result by the total quantity ordered in descending order.

### 7. Determine the distribution of orders by hour of the day

        SELECT HOUR(order_time) AS hour, COUNT(order_id) AS order_count
        FROM orders
        GROUP BY hour
        ORDER BY hour;
- SELECT HOUR(order_time) AS hour, COUNT(order_id) AS order_count: Selects the hour of the order time and counts the number of orders for each hour.
- FROM orders: Specifies the table to select data from.
- GROUP BY hour: Groups the result by the hour of the day.
- ORDER BY hour: Orders the result by the hour of the day.

### 8. Join relevant tables to find the category-wise distribution of pizzas

        SELECT category, COUNT(name) AS category_count
        FROM pizza_types
        GROUP BY category;
    
- SELECT category, COUNT(name) AS category_count: Selects the category of pizzas and counts the number of pizza types in each category.
- FROM pizza_types: Specifies the table to select data from.
- GROUP BY category: Groups the result by the category of pizzas.


### 9. Group the orders by date and calculate the average number of pizzas ordered per day:

        SELECT ROUND(AVG(quantity)) AS avg_pizzas_per_day
        FROM (
        SELECT orders.order_date, SUM(order_details.quantity) AS quantity
        FROM orders
        JOIN order_details ON orders.order_id = order_details.order_id
        GROUP BY orders.order_date
        ) AS daily_orders;

- SELECT ROUND(AVG(quantity)) AS avg_pizzas_per_day: Selects the average number of pizzas ordered per day and rounds the result.
- FROM (...) AS daily_orders: Specifies a subquery that calculates the total quantity of pizzas ordered for each day.
- SELECT orders.order_date, SUM(order_details.quantity) AS quantity FROM orders JOIN order_details ON orders.order_id = order_details.order_id GROUP BY orders.order_date: The subquery that groups the orders by date and sums the quantities ordered for each day.

### 10. Determine the top 3 most ordered pizza types based on revenue:

        SELECT pizza_types.name, SUM(order_details.quantity * pizzas.price) AS revenue
        FROM pizza_types
        JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
        GROUP BY pizza_types.name
        ORDER BY revenue DESC
        LIMIT 3;

- SELECT pizza_types.name, SUM(order_details.quantity * pizzas.price) AS revenue: Selects the name of the pizza types and sums the revenue generated from each type.
- FROM pizza_types JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id JOIN order_details ON pizzas.pizza_id = order_details.pizza_id: Joins the pizza_types, pizzas, and order_details tables to match each order detail with its corresponding pizza and pizza type.
- GROUP BY pizza_types.name: Groups the result by the name of the pizza types.
- ORDER BY revenue DESC LIMIT 3: Orders the result by the total revenue in descending order and limits the result to the top three, which gives the top 3 most ordered pizza types based on revenue.

### 11. Calculate the percentage contribution of each pizza type to total revenue:

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

- SELECT pizza_types.category, (SUM(order_details.quantity * pizzas.price) / (SELECT SUM(pizzas.price * order_details.quantity) AS total_sales FROM pizzas JOIN order_details ON pizzas.pizza_id = order_details.pizza_id)) * 100 AS percentage_pizza_type: Selects the category of pizzas and calculates the percentage contribution of each pizza type to the total revenue.
- FROM pizza_types JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id JOIN order_details ON pizzas.pizza_id = order_details.pizza_id: Joins the pizza_types, pizzas, and order_details tables to match each order detail with its corresponding pizza and pizza type.
- GROUP BY pizza_types.category: Groups the result by the category of pizzas

### 12. Analyze the cumulative revenue generated over time:

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

- SELECT order_date, SUM(revenue) OVER(ORDER BY order_date) AS cumulative_revenue: Selects the order date and calculates the cumulative revenue over time.
- FROM (...) AS daily_sales: Specifies a subquery that calculates the daily revenue.
- SELECT orders.order_date, SUM(pizzas.price * order_details.quantity) AS revenue FROM orders JOIN order_details ON order_details.order_id = orders.order_id JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id GROUP BY orders.order_date: The subquery that groups the orders by date and sums the revenue for each day.

### 13. Determine the top 3 most ordered pizza types based on revenue for each pizza category:

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

- SELECT name, revenue: Selects the name of the pizza types and their revenue.
- FROM (...) AS b: Specifies an outer subquery to rank the pizza types within each category based on revenue.
- SELECT category, name, revenue, RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS rk FROM (...) AS a: Specifies an inner subquery to calculate the revenue for each pizza type and rank them within their category.
- SELECT pizza_types.category, pizza_types.name, SUM(pizzas.price * order_details.quantity) AS revenue FROM pizza_types JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id JOIN order_details ON pizzas.pizza_id = order_details.pizza_id GROUP BY pizza_types.category, pizza_types.name: The innermost query that calculates the revenue for each pizza type.
- WHERE rk <= 3: Filters the result to include only the top 3 pizza types within each category based on revenue.

## Insights:

Based on the analysis of our pizza sales data using SQL queries, we have gained several valuable insights into the performance of our pizza business. These insights can help us make data-driven decisions to optimize our operations, marketing strategies, and overall business growth. Here's a comprehensive summary of our findings:

### Basic Insights:

### Total Number of Orders Placed:

- Total Orders: 21,350

![Total Number of order placed](https://github.com/SahilRajput99/Sql_project/assets/168499493/5f8d516f-8d72-4464-a622-97a3911e0b78)

This high number indicates a significant volume of business and customer demand for our pizzas.

### Total Revenue Generated from Pizza Sales:

Total Sales: $817,860.05

![Total revenue](https://github.com/SahilRajput99/Sql_project/assets/168499493/c453ffae-322a-482b-a1e3-06ceea91ae1e)

The substantial revenue generated reflects a healthy business operation and strong market presence.

### Highest-Priced Pizza:

- Pizza Name: The Greek Pizza
- Price: $35.95

![Highest priced pizza](https://github.com/SahilRajput99/Sql_project/assets/168499493/164c6632-1b2e-4311-b809-120b83d5371d)

This premium-priced pizza offers an opportunity to promote high-margin items and explore similar high-end products.

### Most Common Pizza Size Ordered:

- Large (L): 18,526 orders
- Medium (M): 15,385 orders
- Small (S): 14,137 orders
- Extra Large (XL): 544 orders
- Extra Extra Large (XXL): 28 orders

![Common pizza ordered](https://github.com/SahilRajput99/Sql_project/assets/168499493/4e5d98f6-caf0-4938-b4b4-09d2e9943c2d)

Large pizzas are the most popular, indicating customer preference for larger portions.

### Top 5 Most Ordered Pizza Types:

- The Classic Deluxe Pizza: 2,453 orders
- The Barbecue Chicken Pizza: 2,432 orders
- The Hawaiian Pizza: 2,422 orders
- The Pepperoni Pizza: 2,418 orders
- The Thai Chicken Pizza: 2,371 orders

![Top 5 most ordered pizza](https://github.com/SahilRajput99/Sql_project/assets/168499493/c99ff4ee-d57d-4cd7-8cbf-c32f36669684)

These top-selling pizzas should be highlighted in promotions and marketing efforts.

### Intermediate Insights:

### Total Quantity of Each Pizza Category Ordered:

- Classic: 14,888 orders
- Supreme: 11,987 orders
-  Veggie: 11,649 orders
- Chicken: 11,050 orders

![category total](https://github.com/SahilRajput99/Sql_project/assets/168499493/33dd4d69-3d8b-4ecb-95a0-5b24b1490167)![top 3 most ordered pizzas types](https://github.com/SahilRajput99/Sql_project/assets/168499493/19aa34c5-9a4e-42b2-81c2-8abe272cb1a9)


The Classic category has the highest quantity ordered, making it the most popular category among customers. This suggests a strong preference for traditional and familiar pizza options. The relatively balanced distribution among other categories indicates a diverse menu appeal, with substantial interest in Supreme, Veggie, and Chicken options.

### Distribution of Orders by Hour of the Day:

- Peak hours are between 11 AM to 1 PM and 5 PM to 7 PM, with the highest number of orders at noon (12 PM) and 1 PM.
- This information can be used to manage staffing levels and ensure sufficient inventory during peak times.

![Order by hour of day](https://github.com/SahilRajput99/Sql_project/assets/168499493/9d936ad0-9a00-490e-9b94-172141eb228d)

### Category-Wise Distribution of Pizzas:

- Chicken: 6 types
- Classic: 8 types
- Supreme: 9 types
- Veggie: 9 types

This distribution indicates a diverse menu with a good balance across different categories, catering to various customer preferences.

![category wise distribution](https://github.com/SahilRajput99/Sql_project/assets/168499493/1010c39c-929c-4105-a8d7-2842f922da84)

### Average Number of Pizzas Ordered Per Day:

Average: 138 pizzas per day

![Average daily ordered pizzas](https://github.com/SahilRajput99/Sql_project/assets/168499493/c4bc3243-f01d-4674-9739-63df39b2d484)

This metric helps in forecasting demand and planning daily operations.

### Top 3 Most Ordered Pizza Types Based on Revenue:

- The Thai Chicken Pizza: 43,434.25
- The Barbecue Chicken Pizza: 42,768
- The California Chicken Pizza: 41,409.5

![Top 3 most ordered pizzas on revenue](https://github.com/SahilRajput99/Sql_project/assets/168499493/0ebcbbda-36f9-4647-80a1-8ced7382a08f)
These pizzas contribute significantly to our revenue and should be prioritized in marketing campaigns.

### Advanced Insights:
### Percentage Contribution of Each Pizza Type to Total Revenue:

- Classic: 26.91%
- Veggie: 23.68%
- Supreme: 25.46%
- Chicken: 23.96%
The balanced revenue contribution across different categories highlights a well-rounded menu offering.

### Cumulative Revenue Generated Over Time:

This analysis shows the cumulative revenue for selected dates, demonstrating the revenue growth and consistency in our sales over time. It provides a clear picture of our revenue growth trajectory, which can be visualized using charts to identify trends and patterns over time.

![Cumulative revenue](https://github.com/SahilRajput99/Sql_project/assets/168499493/f0be7ad2-2648-4a39-bde0-f68b2287bacd)

### Top 3 Most Ordered Pizza Types Based on Revenue for Each Pizza Category:

Chicken:
- The Thai Chicken Pizza: 43,434.25
- The Barbecue Chicken Pizza: 42,768
- The California Chicken Pizza: 41,409.5
Classic:
- The Classic Deluxe Pizza: 38,180.5
- The Hawaiian Pizza: 32,273.25
- The Pepperoni Pizza: 30,161.75
Supreme:
- The Spicy Italian Pizza: 34,831.25
- The Italian Supreme Pizza: 33,476.75
- The Sicilian Pizza: 30,940.5
Veggie:
- The Four Cheese Pizza: 32,265.7
- The Mexicana Pizza: 26,780.75
- The Five Cheese Pizza: 26,066.5

![top 3 most ordered pizzas types](https://github.com/SahilRajput99/Sql_project/assets/168499493/19aa34c5-9a4e-42b2-81c2-8abe272cb1a9)


This breakdown shows the top performers within each category, guiding targeted promotions and menu adjustments.

## Conclusion:

The comprehensive analysis of our pizza sales data reveals crucial insights into customer preferences, peak ordering times, and revenue distribution across different pizza types. These insights can be leveraged to optimize our menu offerings, enhance marketing strategies, and improve operational efficiency, ultimately driving growth and profitability for our pizza business. By continuously analyzing and acting on this data, we can stay ahead of the competition and better serve our customers.
