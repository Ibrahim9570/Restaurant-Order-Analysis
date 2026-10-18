# Restaurant Order Analysis: What Drives High-Spend Orders

SQL analysis of a restaurant's new menu and 3 months of orders, to find the most and least popular dishes and what the highest-spending customers order.

## Business need
Taste of the World Café launched a new menu at the start of 2023. The restaurant wanted to know which menu items were doing well or badly, and what its top customers seemed to prefer.

## Data
- **menu_items:** 32 dishes across 4 cuisines (American, Asian, Mexican, Italian)
- **order_details:** 12,234 ordered items from 5,370 orders, January to March 2023
- Source: Maven Analytics guided project

## Approach
1. **Explored the menu:** item count, price range, average price by category
2. **Explored the orders:** date range, order and item counts, order sizes
3. **Combined both tables** with a LEFT JOIN to analyse what was ordered and how much each order spent

All queries are in [`restaurant_analysis.sql`](restaurant_analysis.sql), with the result of each one noted in comments.

## Key insights

### Most and least ordered items
The **Hamburger** was the most ordered item (622), and **Chicken Tacos** was the least ordered (123).

![Most and least ordered items](images/most_least_ordered.png)

### Top 5 orders by spend
The highest-spend order was **$192.15** (order 440).

![Top 5 orders by spend](images/top_5_orders.png)

### What the biggest spenders ordered
In the highest-spend order, **8 of 14 items were Italian**. Across the top 5 orders, Italian dishes made up about 38% of all items.

![Highest spend order by category](images/highest_order_details.png)

### Other findings
- **Italian** is the most expensive category (average $16.75), and **American** is the cheapest ($10.07)
- 20 orders had more than 12 items

## Recommendations
1. **Keep and promote the Italian dishes.** They sell less often but drive the most valuable orders
2. **Review the lowest performers,** such as Chicken Tacos and Potstickers, and consider replacing or repricing them
3. **Target group orders** with Italian sharing options to raise the average order value

## Tools
MySQL: SELECT, WHERE, ORDER BY, GROUP BY, HAVING, aggregate functions, subqueries, LEFT JOIN
