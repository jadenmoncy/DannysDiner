-- Danny's Diner SQL Case Study
-- Complete SQL Script with all queries and solutions

-- =============================================
-- TABLE CREATION AND DATA INSERTION
-- =============================================

-- Create sales table
CREATE TABLE sales (
    customer_id VARCHAR(1),
    order_date DATE,
    product_id INTEGER
);

-- Create menu table
CREATE TABLE menu (
    product_id INTEGER,
    product_name VARCHAR(5),
    price INTEGER
);

-- Create members table
CREATE TABLE members (
    customer_id VARCHAR(1),
    join_date DATE
);

-- Insert data into sales table
INSERT INTO sales VALUES
    ('A', '2021-01-01', 1),
    ('A', '2021-01-01', 2),
    ('A', '2021-01-07', 2),
    ('A', '2021-01-10', 3),
    ('A', '2021-01-11', 3),
    ('A', '2021-01-11', 3),
    ('B', '2021-01-01', 2),
    ('B', '2021-01-02', 2),
    ('B', '2021-01-04', 1),
    ('B', '2021-01-11', 1),
    ('B', '2021-01-16', 3),
    ('B', '2021-02-01', 3),
    ('C', '2021-01-01', 3),
    ('C', '2021-01-01', 3),
    ('C', '2021-01-07', 3);

-- Insert data into menu table
INSERT INTO menu VALUES
    (1, 'sushi', 10),
    (2, 'curry', 15),
    (3, 'ramen', 12);

-- Insert data into members table
INSERT INTO members VALUES
    ('A', '2021-01-07'),
    ('B', '2021-01-09');

-- =============================================
-- CASE STUDY QUESTIONS AND SOLUTIONS
-- =============================================

-- Question 1: What is the total amount each customer spent at the restaurant?
SELECT 
    s.customer_id,
    SUM(m.price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- Question 2: How many days has each customer visited the restaurant?
SELECT 
    customer_id,
    COUNT(DISTINCT order_date) AS visit_count
FROM sales
GROUP BY customer_id
ORDER BY customer_id;

-- Question 3: What was the first item purchased by each customer?
WITH ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS rk
    FROM sales
)
SELECT r.customer_id, m.product_name
FROM ranked r
JOIN menu m ON r.product_id = m.product_id
WHERE rk = 1
ORDER BY r.customer_id;

-- Question 4: What is the most purchased item and how many times was it ordered?
SELECT 
    m.product_name, 
    COUNT(*) AS order_count
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY order_count DESC
LIMIT 1;

-- Question 5: Which item was most popular for each customer?
WITH counts AS (
    SELECT 
        s.customer_id, 
        m.product_name, 
        COUNT(*) AS cnt
    FROM sales s
    JOIN menu m ON s.product_id = m.product_id
    GROUP BY s.customer_id, m.product_name
),
ranked AS (
    SELECT *, 
           RANK() OVER (PARTITION BY customer_id ORDER BY cnt DESC) AS rk
    FROM counts
)
SELECT customer_id, product_name, cnt
FROM ranked
WHERE rk = 1
ORDER BY customer_id;

-- Question 6: What was the first item purchased after becoming a member?
WITH joined AS (
    SELECT 
        s.customer_id, 
        s.order_date, 
        s.product_id, 
        m.join_date
    FROM sales s
    JOIN members m ON s.customer_id = m.customer_id
    WHERE s.order_date >= m.join_date
),
ranked AS (
    SELECT *, 
           RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS rk
    FROM joined
)
SELECT j.customer_id, menu.product_name
FROM ranked j
JOIN menu ON j.product_id = menu.product_id
WHERE rk = 1
ORDER BY j.customer_id;

-- Question 7: What item was purchased just before becoming a member?
WITH pre_join AS (
    SELECT 
        s.customer_id, 
        s.order_date, 
        s.product_id, 
        m.join_date
    FROM sales s
    JOIN members m ON s.customer_id = m.customer_id
    WHERE s.order_date < m.join_date
),
ranked AS (
    SELECT *, 
           RANK() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rk
    FROM pre_join
)
SELECT r.customer_id, menu.product_name
FROM ranked r
JOIN menu ON r.product_id = menu.product_id
WHERE rk = 1
ORDER BY r.customer_id;

-- Question 8: What is the total items and spend by each customer before they became a member?
SELECT 
    s.customer_id,
    COUNT(*) AS total_items,
    SUM(m.price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- Question 9: If each $1 spent = 10 points and sushi gets double points, how many points did each customer earn?
SELECT 
    s.customer_id,
    SUM(
        CASE 
            WHEN m.product_name = 'sushi' THEN m.price * 20
            ELSE m.price * 10
        END
    ) AS total_points
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- Question 10: In the first week of membership, what did each customer buy and spend?
SELECT 
    s.customer_id,
    COUNT(*) AS items_bought,
    SUM(m.price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
WHERE s.order_date BETWEEN mem.join_date AND DATE(mem.join_date, '+6 days')
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- =============================================
-- BONUS QUESTIONS
-- =============================================

-- Bonus Question 1: Join All The Things
-- Create a table with customer_id, order_date, product_name, price, and member status
SELECT 
    s.customer_id,
    s.order_date,
    m.product_name,
    m.price,
    CASE 
        WHEN mem.join_date IS NULL THEN 'N'
        WHEN s.order_date < mem.join_date THEN 'N'
        ELSE 'Y'
    END AS member
FROM sales s
JOIN menu m ON s.product_id = m.product_id
LEFT JOIN members mem ON s.customer_id = mem.customer_id
ORDER BY s.customer_id, s.order_date;

-- Bonus Question 2: Rank All The Things
-- Add ranking for member purchases only
WITH customer_data AS (
    SELECT 
        s.customer_id,
        s.order_date,
        m.product_name,
        m.price,
        CASE 
            WHEN mem.join_date IS NULL THEN 'N'
            WHEN s.order_date < mem.join_date THEN 'N'
            ELSE 'Y'
        END AS member
    FROM sales s
    JOIN menu m ON s.product_id = m.product_id
    LEFT JOIN members mem ON s.customer_id = mem.customer_id
)
SELECT 
    *,
    CASE 
        WHEN member = 'Y' THEN 
            RANK() OVER (PARTITION BY customer_id, member ORDER BY order_date)
        ELSE NULL
    END AS ranking
FROM customer_data
ORDER BY customer_id, order_date; 