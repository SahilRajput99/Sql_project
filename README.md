# Pizza Orders
Problem Statement:

Welcome to the SQL Portfolio Project focused on a fictional pizza orders. In this project, you'll be diving into a dataset comprising four tables: order_details, orders, pizzas, and pizza_types. Your mission is to leverage your SQL skills to extract valuable insights from this data and showcase your analytical prowess.

Dataset Description:

The dataset contains crucial information about the pizza ordering system:

order_details: This table holds records of individual pizza orders, including details such as the order ID, pizza ID, and quantity ordered.
orders: Stores metadata about the orders, including the order ID, date, and time of placement.
pizzas: Contains data regarding various pizza types, including their IDs, types, sizes, and prices.
pizza_types: This table provides details about different pizza types, including their names, categories, and ingredients.

Steps
Step-by-Step Procedure for Pizza Orders Analysis:

Data Import and Table Creation:
Import Data: Obtain the dataset containing information about pizza orders, including order_details, orders, pizzas, and pizza_types.
Create Tables: Set up corresponding tables in your MySQL database using SQL queries. For example:
CREATE TABLE order_details (
    order_details_id INT,
    order_id INT,
    pizza_id INT,
    quantity INT
);
Follow the same process for other tables

Step 1: Data Exploration

1.1. Examine the structure of the dataset by reviewing the schema of each table (order_details, orders, pizzas, pizza_types).

1.2. Identify the primary and foreign keys in each table to understand the relationships between them.

Step 2: Basic Queries

2.1. Retrieve the total number of orders placed:

Query the orders table to count the distinct order IDs.

2.2. Calculate the total revenue generated from pizza sales:

Join the order_details and pizzas tables on the pizza ID to calculate the revenue for each order (quantity * price).
Sum up the revenues from all orders.

2.3. Identify the highest-priced pizza:

Query the pizzas table to find the pizza with the maximum price.

2.4. Identify the most common pizza size ordered:

Count the occurrences of each pizza size in the pizzas table.

2.5. List the top 5 most ordered pizza types along with their quantities:

Join the order_details and pizza_types tables on the pizza ID.

Group by pizza type and sum up the quantities ordered, then sort in descending order and limit to the top 5.

Step 3: Intermediate Queries

3.1. Join the necessary tables to find the total quantity of each pizza category ordered:

Join order_details, pizzas, and pizza_types tables to link pizza IDs to their respective categories.
Group by category and sum up the quantities ordered.

3.2. Determine the distribution of orders by hour of the day:

Extract the hour component from the time column in the orders table.
Group by hour and count the number of orders.

3.3. Join relevant tables to find the category-wise distribution of pizzas:

Join pizzas and pizza_types tables to link pizza IDs to their categories.
Group by category and count the number of pizzas.

3.4. Group the orders by date and calculate the average number of pizzas ordered per day:

Extract the date component from the date column in the orders table.
Group by date and calculate the average quantity of pizzas ordered.

3.5. Determine the top 3 most ordered pizza types based on revenue:

Join order_details and pizza_types tables.
Group by pizza type and sum up the revenues, then sort in descending order and limit to the top 3.

Step 4: Advanced Queries

4.1. Calculate the percentage contribution of each pizza type to total revenue:

Join order_details and pizza_types tables.
Group by pizza type and calculate the revenue for each type as a percentage of total revenue.

4.2. Analyze the cumulative revenue generated over time:

Order the orders table by date.
Calculate the cumulative sum of revenue over time.

4.3. Determine the top 3 most ordered pizza types based on revenue for each pizza category:

Join order_details, pizzas, and pizza_types tables.
Group by category and pizza type, then calculate revenue for each type within the category.
Sort by revenue within each category and limit to the top 3 for each category.

Conclusion:

In this project, we followed a structured approach to extract and analyze pizza order data from the provided tables (order_details, orders, pizzas, pizza_types). 

We addressed basic, intermediate, and advanced questions to gain valuable insights into the pizza ordering system. Through data exploration, we familiarized ourselves with the dataset's structure and relationships between tables, laying the foundation for subsequent analysis.Basic queries allowed us to retrieve essential information such as the total number of orders placed, total revenue generated, highest-priced pizza, most common pizza size ordered, and top 5 most ordered pizza types.

Intermediate queries delved deeper into the data, enabling us to determine the total quantity of each pizza category ordered, analyze the distribution of orders by hour of the day, find the category-wise distribution of pizzas, calculate the average number of pizzas ordered per day, and identify the top 3 most ordered pizza types based on revenue.

Advanced queries showcased our proficiency in deriving actionable insights from complex datasets. We calculated the percentage contribution of each pizza type to total revenue, analyzed the cumulative revenue generated over time, and determined the top 3 most ordered pizza types based on revenue for each pizza category.

By completing this project, we demonstrated our SQL skills, data analysis capabilities, and problem-solving acumen. Through insightful queries and interpretations, we derived meaningful insights that can inform decision-making processes.

This project serves as a testament to our ability to extract actionable insights from data and effectively communicate findings, making it a valuable addition to our portfolio.
