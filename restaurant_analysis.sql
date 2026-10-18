-- =====================================================
-- Restaurant Order Analysis (MySQL)
-- Data: Taste of the World Cafe, Jan to Mar 2023
-- Tables: menu_items, order_details
-- =====================================================

USE restaurant_db;

-- =====================================================
-- OBJECTIVE 1: Explore the menu_items table
-- =====================================================

-- 1. View the table and count the items on the menu
SELECT * FROM menu_items;

SELECT COUNT(*) AS num_items
FROM menu_items;
-- Result: 32 items

-- 2. Least and most expensive items
SELECT * FROM menu_items
ORDER BY price
LIMIT 1;
-- Result: Edamame, $5.00

SELECT * FROM menu_items
ORDER BY price DESC
LIMIT 1;
-- Result: Shrimp Scampi, $19.95

-- 3. Italian dishes: count, cheapest and most expensive
SELECT COUNT(*) AS num_italian_dishes
FROM menu_items
WHERE category = 'Italian';
-- Result: 9

SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price
LIMIT 1;
-- Result: Spaghetti / Fettuccine Alfredo (tied at $14.50)

SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1;
-- Result: Shrimp Scampi, $19.95

-- 4. Number of dishes and average price by category
SELECT category,
       COUNT(menu_item_id) AS num_dishes,
       ROUND(AVG(price), 2) AS avg_price
FROM menu_items
GROUP BY category;
-- Result: Italian has the highest average price ($16.75), American the lowest ($10.07)


-- =====================================================
-- OBJECTIVE 2: Explore the order_details table
-- =====================================================

-- 1. View the table and find the date range
SELECT * FROM order_details;

SELECT MIN(order_date) AS first_date,
       MAX(order_date) AS last_date
FROM order_details;
-- Result: 2023-01-01 to 2023-03-31

-- 2. Number of orders and items in the date range
SELECT COUNT(DISTINCT order_id) AS num_orders
FROM order_details;
-- Result: 5,370 orders

SELECT COUNT(*) AS num_items
FROM order_details;
-- Result: 12,234 items

-- 3. Orders with the most items
SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;
-- Result: 7 orders tied at 14 items

-- 4. Number of orders with more than 12 items
SELECT COUNT(*) AS num_big_orders
FROM (
    SELECT order_id, COUNT(item_id) AS num_items
    FROM order_details
    GROUP BY order_id
    HAVING num_items > 12
) AS big_orders;
-- Result: 20 orders


-- =====================================================
-- OBJECTIVE 3: Analyze customer behavior
-- =====================================================

-- 1. Combine the two tables
SELECT *
FROM order_details od
LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id;

-- 2. Least and most ordered items, with category
SELECT item_name, category, COUNT(order_details_id) AS num_purchases
FROM order_details od
LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases DESC;
-- Result: most ordered = Hamburger (American, 622)
--         least ordered = Chicken Tacos (Mexican, 123)
--         (137 rows have no item and show as NULL)

-- 3. Top 5 orders by total spend
SELECT order_id, SUM(price) AS total_spend
FROM order_details od
LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;
-- Result: 440 ($192.15), 2075, 1957, 330, 2675

-- 4. Details of the highest spend order
SELECT category, COUNT(item_id) AS num_items
FROM order_details od
LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;
-- Result: 8 of 14 items were Italian

-- 5. BONUS: Details of the top 5 highest spend orders
SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od
LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;
-- Result: Italian is the largest category in 4 of the 5 top orders
--         (about 38% of their items)
