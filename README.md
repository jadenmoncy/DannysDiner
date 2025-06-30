# Danny's Diner SQL Case Study

This project is part of the [8-Week SQL Challenge](https://8weeksqlchallenge.com/case-study-1/) by Danny Ma. I used SQL to answer real-world business questions based on fictional sales data from a Japanese restaurant.

---

## Tools & Concepts Used

- SQL (Window Functions, CTEs, Joins, Aggregations)
- Customer segmentation
- Time-based filtering
- Reward logic modeling
- Data storytelling & business insights

---

## Dataset Overview

- sales: Customer orders (product + date)
- menu: Product names and prices
- members: Customer membership join dates

---

## Case Study Questions & SQL Solutions

### 1. What is the total amount each customer spent at the restaurant?

```sql
SELECT 
  s.customer_id,
  SUM(m.price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;
```

---

### 2. How many days has each customer visited the restaurant?

```sql
SELECT 
  customer_id,
  COUNT(DISTINCT order_date) AS visit_count
FROM sales
GROUP BY customer_id;
```

---

### 3. What was the first item purchased by each customer?

```sql
WITH ranked AS (
  SELECT *,
         RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS rk
  FROM sales
)
SELECT r.customer_id, m.product_name
FROM ranked r
JOIN menu m ON r.product_id = m.product_id
WHERE rk = 1;
```

---

### 4. What is the most purchased item and how many times was it ordered?

```sql
SELECT m.product_name, COUNT(*) AS count
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY count DESC
LIMIT 1;
```

---

### 5. Which item was most popular for each customer?

```sql
WITH counts AS (
  SELECT s.customer_id, m.product_name, COUNT(*) AS cnt
  FROM sales s
  JOIN menu m ON s.product_id = m.product_id
  GROUP BY s.customer_id, m.product_name
),
ranked AS (
  SELECT *, RANK() OVER (PARTITION BY customer_id ORDER BY cnt DESC) AS rk
  FROM counts
)
SELECT customer_id, product_name, cnt
FROM ranked
WHERE rk = 1;
```

---

### 6. First item purchased after becoming a member

```sql
WITH joined AS (
  SELECT s.customer_id, s.order_date, s.product_id, m.join_date
  FROM sales s
  JOIN members m ON s.customer_id = m.customer_id
  WHERE s.order_date >= m.join_date
),
ranked AS (
  SELECT *, RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS rk
  FROM joined
)
SELECT j.customer_id, menu.product_name
FROM ranked j
JOIN menu ON j.product_id = menu.product_id
WHERE rk = 1;
```

---

### 7. Item purchased just before becoming a member

```sql
WITH pre_join AS (
  SELECT s.customer_id, s.order_date, s.product_id, m.join_date
  FROM sales s
  JOIN members m ON s.customer_id = m.customer_id
  WHERE s.order_date < m.join_date
),
ranked AS (
  SELECT *, RANK() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rk
  FROM pre_join
)
SELECT r.customer_id, menu.product_name
FROM ranked r
JOIN menu ON r.product_id = menu.product_id
WHERE rk = 1;
```

---

### 8. Total items and spend before becoming a member

```sql
SELECT 
  s.customer_id,
  COUNT(*) AS items,
  SUM(m.price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id;
```

---

### 9. Reward points (10x per $1, sushi = 2x)

```sql
SELECT 
  s.customer_id,
  SUM(
    CASE 
      WHEN m.product_name = 'sushi' THEN m.price * 20
      ELSE m.price * 10
    END
  ) AS points
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;
```

---

### 10. First week of membership activity

```sql
SELECT 
  s.customer_id,
  COUNT(*) AS items_bought,
  SUM(m.price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
WHERE s.order_date BETWEEN mem.join_date AND DATE(mem.join_date, '+6 days')
GROUP BY s.customer_id;
```

---

## Project Files

### Complete Project Structure

- **`sql_queries.sql`** - Complete SQL script with all queries and table creation
- **`analysis_results.md`** - Detailed analysis with expected results and insights
- **`requirements.txt`** - Python dependencies for PDF generation
- **`PROJECT_DOCUMENTATION.md`** - Comprehensive project documentation
- **`Dannys_Diner_SQL_Case_Study_Report.pdf`** - Generated professional PDF report

### Quick Start

1. **Run SQL Queries:**
   ```bash
   # For SQLite
   sqlite3 dannys_diner.db < sql_queries.sql
   
   # For MySQL
   mysql -u username -p database_name < sql_queries.sql
   
   # For PostgreSQL
   psql -U username -d database_name -f sql_queries.sql
   ```

2. **View Results:**
   - Open `Dannys_Diner_SQL_Case_Study_Report.pdf` for complete analysis
   - Check `analysis_results.md` for detailed insights
   - Review `sql_queries.sql` for all queries and solutions

---

## Expected Results Summary

| Question | Key Finding | Business Impact |
|----------|-------------|-----------------|
| Total Spending | Customer A: $76, Customer B: $74, Customer C: $36 | Focus retention on high-value customers |
| Visit Frequency | Customer B visits most (6 days) | Frequency doesn't correlate with spending |
| Product Popularity | Ramen is most ordered (8 times) | Prioritize ramen in marketing and inventory |
| Membership | 2/3 customers became members | Strong conversion rate for loyalty program |
| Reward Points | Customer B earned most points (940) | Sushi double-points system drives engagement |

---

## Key Business Insights

### Customer Behavior Patterns
1. **Spending Patterns**: Customer A leads in total spending, but Customer B visits more frequently
2. **Product Preferences**: Ramen is the clear favorite, especially among customers A and C
3. **Membership Impact**: Membership doesn't immediately change ordering behavior
4. **Loyalty Indicators**: Both members showed commitment before joining

### Strategic Recommendations
1. **Menu Optimization**: Focus on ramen as it's the most popular item
2. **Membership Marketing**: Target customers who show consistent spending patterns
3. **Reward Program**: The sushi double-points system effectively drives higher-value purchases
4. **Customer Engagement**: Develop strategies to increase visit frequency for high-spending customers

---

## Performance Metrics

### Customer Segmentation
- **High Value**: Customer A ($76 total spent)
- **High Frequency**: Customer B (6 visits)
- **Low Engagement**: Customer C ($36 total spent, 2 visits)

### Product Performance
- **Best Seller**: Ramen (8 orders)
- **Mid-tier**: Curry (4 orders)
- **Premium**: Sushi (3 orders, but highest price point)

### Membership Effectiveness
- **Conversion Rate**: 2 out of 3 customers (66.7%)
- **Pre-membership Investment**: $65 total before joining
- **Post-membership Activity**: Varied engagement levels

---

## PDF Report

A fully documented PDF of this case study is available: **`Dannys_Diner_SQL_Case_Study_Report.pdf`**

The PDF includes:
- Complete project overview
- Detailed dataset description
- All SQL queries with explanations
- Analysis results and insights
- Business recommendations
- Technical implementation details
- Professional formatting and styling

---

## Author

**Jaden Joseph Moncy**
- B.Tech | IIT Guwahati
- LinkedIn | Portfolio | Email

---

## Summary

This project reinforced key SQL concepts like:

- CTEs and subqueries
- Window functions for ranking
- Customer behavior analysis
- Business insights from raw data
- Professional report generation
- Data storytelling techniques

The complete project demonstrates advanced SQL techniques while providing actionable business insights for restaurant management and customer analytics.