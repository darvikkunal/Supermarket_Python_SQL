**Supermarket Analysis Project**
This project involves the analysis of a supermarket dataset sourced from Kaggle. The dataset provides insights into customer purchasing behavior, product preferences, and shopping trends, enabling a comprehensive understanding of the supermarket's operations.

**About the Dataset**

The dataset used in this project originates from a Kaggle competition organized by Instacart in 2017. Instacart, an American company, offers same-day grocery delivery services through a web application and smartphone app. The dataset includes over 3 million grocery orders from more than 200,000 Instacart users, featuring 32 million basket items and 50,000 unique products. The key tables in the dataset are:

Aisles: Information about product aisles.
Departments: Information about product departments.
Order_Products: Details of products in each order.
Orders: Information about customer orders.
Products: Detailed information about each product.

**Project Workflow**

**Data Loading and Preprocessing:**

The dataset was loaded into a Jupyter Notebook using Pandas DataFrames.
Initial data exploration and manipulation were performed to ensure data quality.
Database Connection:

PostgreSQL was connected to the Jupyter Notebook using psycopg2.
A PostgreSQL engine was created using SQLAlchemy (create_engine), and a connection cursor was established.
Data was appended to the PostgreSQL tables using the to_sql method after creating the necessary tables.

**Data Analysis:**

The dataset was analyzed within PostgreSQL to derive insights. The following queries were executed:

**Question answered:**

1. Create a temporary table that joins the orders, order_products, and products tables to get information about each order, including the products that were purchased and their department and aisle information.
2. Create a temporary table that groups the orders by product and finds the total number of times each product was purchased, the total number of times each product was reordered, and the average number of times each product was added to a cart.
3. Create a temporary table that groups the orders by department and finds the total number of products purchased, the total number of unique products purchased, the total number of products purchased on weekdays vs weekends, and the average time of day that products in each department are ordered.
4. Create a temporary table that groups the orders by aisle and finds the top 10 most popular aisles, including the total number of products purchased and the total number of unique products purchased from each aisle.
5. Combine the information from the previous temporary tables into a final table that shows the product ID, product name, department ID, department name, aisle ID, aisle name, total number of times purchased, total number of times reordered, average number of times added to cart, total number of products purchased, total number of unique products purchased, total number of products purchased on weekdays, total number of products purchased on weekends, and average time of day products are ordered in each department.


**Order Information:**

A temporary table was created by joining the orders, order_products, and products tables to extract detailed information about each order, including department and aisle details.
Product Purchase Analysis:

A temporary table was generated to group orders by product, calculating metrics such as the total number of times each product was purchased, reordered, and the average times a product was added to the cart.
Department-Wise Analysis:

Another temporary table was created to group orders by department, calculating the total number of products purchased, unique products purchased, purchases on weekdays vs weekends, and the average order time for each department.

**Aisle Popularity:**

A table was created to group orders by aisle, identifying the top 10 most popular aisles based on the number of products purchased and unique products.
Comprehensive Analysis:

The previous analyses were combined into a final table that includes detailed information such as product ID, product name, department ID, department name, aisle ID, aisle name, total purchases, reorders, and additional metrics related to department and aisle-wise purchases.

**Conclusion**

This project provides a detailed analysis of the supermarket dataset, offering valuable insights into customer behavior and product trends. The PostgreSQL database was effectively used to perform complex queries and extract meaningful information. The results can help supermarkets optimize their operations, improve product placement, and enhance customer experience.

**Acknowledgements**

***Dataset:***

 Supermarket Superstore Dataset Bundle from Kaggle.

***Tools Used:***

 Jupyter Notebook, Pandas, SQLAlchemy, psycopg2, PostgreSQL.

