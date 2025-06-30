# Danny's Diner SQL Case Study - Complete Project Documentation

## Project Structure

```
Dannys Diner/
├── README.md                           # Main project overview
├── sql_queries.sql                     # Complete SQL script with all queries
├── analysis_results.md                 # Detailed analysis with expected results
├── PROJECT_DOCUMENTATION.md            # This comprehensive documentation
└── Dannys_Diner_SQL_Case_Study_Report.pdf  # PDF report
```

## Quick Start Guide

### 1. Run SQL Queries

You can run the SQL queries in any SQL database system (MySQL, PostgreSQL, SQLite, etc.):

```bash
# For SQLite
sqlite3 dannys_diner.db < sql_queries.sql

# For MySQL
mysql -u username -p database_name < sql_queries.sql

# For PostgreSQL
psql -U username -d database_name -f sql_queries.sql
```

### 2. View Results

- **PDF Report**: Open `Dannys_Diner_SQL_Case_Study_Report.pdf` for the complete analysis
- **Analysis Results**: Check `analysis_results.md` for detailed insights and expected outcomes
- **SQL Scripts**: Review `sql_queries.sql` for all queries and solutions

## Dataset Overview

### Tables Structure

#### 1. sales Table
- **customer_id** (VARCHAR): Customer identifier
- **order_date** (DATE): Date of the order
- **product_id** (INTEGER): Product identifier

#### 2. menu Table
- **product_id** (INTEGER): Product identifier
- **product_name** (VARCHAR): Name of the product
- **price** (INTEGER): Price of the product

#### 3. members Table
- **customer_id** (VARCHAR): Customer identifier
- **join_date** (DATE): Date when customer joined membership

### Sample Data

#### sales Table
```
customer_id | order_date  | product_id
------------|-------------|------------
A           | 2021-01-01  | 1
A           | 2021-01-01  | 2
A           | 2021-01-07  | 2
...
```

#### menu Table
```
product_id | product_name | price
-----------|--------------|-------
1          | sushi        | 10
2          | curry        | 15
3          | ramen        | 12
```

#### members Table
```
customer_id | join_date
------------|----------
A           | 2021-01-07
B           | 2021-01-09
```

## Case Study Questions

### Core Questions (1-10)

1. **Total spending per customer** - Basic aggregation with JOIN
2. **Visit frequency** - COUNT DISTINCT on dates
3. **First purchase per customer** - Window functions with RANK()
4. **Most popular item** - Aggregation with ORDER BY and LIMIT
5. **Customer-specific favorites** - Window functions with partitioning
6. **First post-membership purchase** - Date filtering with window functions
7. **Last pre-membership purchase** - Date filtering with reverse ranking
8. **Pre-membership spending** - Date-based filtering with aggregation
9. **Reward points calculation** - CASE statements with conditional logic
10. **First week membership activity** - Date range filtering

### Bonus Questions

1. **Join All The Things** - Comprehensive customer view with membership status
2. **Rank All The Things** - Ranking system for member purchases

## Technical Implementation Details

### SQL Techniques Used

#### 1. Window Functions
```sql
RANK() OVER (PARTITION BY customer_id ORDER BY order_date)
```
- Used for ranking orders chronologically per customer
- Essential for finding first/last purchases

#### 2. Common Table Expressions (CTEs)
```sql
WITH ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS rk
    FROM sales
)
```
- Breaks complex queries into readable parts
- Improves query maintainability

#### 3. JOINs
```sql
FROM sales s
JOIN menu m ON s.product_id = m.product_id
LEFT JOIN members mem ON s.customer_id = mem.customer_id
```
- Combines related data from multiple tables
- LEFT JOIN preserves customers without membership

#### 4. Conditional Logic
```sql
CASE 
    WHEN m.product_name = 'sushi' THEN m.price * 20
    ELSE m.price * 10
END
```
- Implements business rules (sushi double-points)
- Flexible reward system calculation

### Performance Considerations

1. **Indexing**: Ensure indexes on join columns (product_id, customer_id)
2. **Date Functions**: Use appropriate date arithmetic for your database system
3. **Window Functions**: Consider performance impact on large datasets

## Business Insights

### Key Findings

1. **Customer Spending Patterns**
   - Customer A: Highest total spending ($76)
   - Customer B: Most frequent visits (6 days)
   - Customer C: Lowest engagement ($36, 2 visits)

2. **Product Performance**
   - Ramen: Most popular (8 orders)
   - Curry: Mid-tier performance (4 orders)
   - Sushi: Premium positioning (3 orders, highest price)

3. **Membership Effectiveness**
   - 66.7% conversion rate (2/3 customers)
   - Varied post-membership engagement
   - Strong pre-membership commitment indicators

### Strategic Recommendations

1. **Menu Optimization**
   - Focus marketing on ramen (best seller)
   - Maintain sushi premium positioning
   - Consider curry promotions for variety

2. **Customer Retention**
   - Develop VIP program for high-spenders
   - Increase visit frequency for high-value customers
   - Target membership conversion for consistent spenders

3. **Inventory Management**
   - Ensure ramen availability (high demand)
   - Monitor sushi stock (premium item)
   - Balance curry inventory (steady demand)


## Author

**Jaden Joseph Moncy**
---
