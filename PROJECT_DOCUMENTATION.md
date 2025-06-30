# Danny's Diner SQL Case Study - Complete Project Documentation

## Project Structure

```
Dannys Diner/
├── README.md                           # Main project overview
├── sql_queries.sql                     # Complete SQL script with all queries
├── analysis_results.md                 # Detailed analysis with expected results
├── PROJECT_DOCUMENTATION.md            # This comprehensive documentation
└── Dannys_Diner_SQL_Case_Study_Report.pdf  # Generated PDF report
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

## Project Deliverables

### Core Files

1. **`sql_queries.sql`** - Complete SQL implementation
   - Table creation scripts
   - Sample data insertion
   - All 10 case study queries
   - Bonus questions solutions
   - Ready to run in any SQL database

2. **`analysis_results.md`** - Detailed analysis
   - Expected query results
   - Business insights and interpretations
   - Performance metrics
   - Strategic recommendations

3. **`Dannys_Diner_SQL_Case_Study_Report.pdf`** - Professional report
   - Complete project overview
   - Technical implementation details
   - Business insights and recommendations
   - Professional formatting

4. **`README.md`** - Project overview
   - Quick start guide
   - Key findings summary
   - Usage instructions

5. **`PROJECT_DOCUMENTATION.md`** - This comprehensive guide
   - Detailed technical documentation
   - Implementation guidelines
   - Troubleshooting guide

## Usage Instructions

### For SQL Execution

1. **Choose your database system** (SQLite, MySQL, PostgreSQL)
2. **Create a new database** (if needed)
3. **Run the SQL script** using the appropriate command
4. **Review results** in your database client or terminal

### For Analysis Review

1. **Open the PDF report** for comprehensive analysis
2. **Check analysis_results.md** for detailed insights
3. **Review README.md** for quick overview

## Troubleshooting

### Common Issues

1. **SQL Query Errors**
   - Database-specific syntax differences
   - Date function variations between systems
   - Missing table creation scripts

2. **Data Import Issues**
   - Check data format consistency
   - Verify foreign key relationships
   - Ensure proper data types

### Database-Specific Notes

#### MySQL
```sql
-- Use DATE_ADD instead of DATE function
WHERE s.order_date BETWEEN mem.join_date AND DATE_ADD(mem.join_date, INTERVAL 6 DAY)
```

#### PostgreSQL
```sql
-- Use + INTERVAL instead of DATE function
WHERE s.order_date BETWEEN mem.join_date AND mem.join_date + INTERVAL '6 days'
```

#### SQLite
```sql
-- Use DATE function as shown in original queries
WHERE s.order_date BETWEEN mem.join_date AND DATE(mem.join_date, '+6 days')
```

## Learning Resources

### SQL Concepts
- [Window Functions](https://www.postgresql.org/docs/current/tutorial-window.html)
- [CTEs (Common Table Expressions)](https://www.postgresql.org/docs/current/queries-with.html)
- [JOINs](https://www.w3schools.com/sql/sql_join.asp)

### Business Analytics
- [Customer Segmentation](https://www.investopedia.com/terms/c/customer-segmentation.asp)
- [Loyalty Programs](https://www.investopedia.com/terms/l/loyalty-program.asp)
- [Data-Driven Decision Making](https://www.mckinsey.com/business-functions/mckinsey-analytics/our-insights/the-business-value-of-data-science)

## Contributing

To contribute to this project:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is part of the 8-Week SQL Challenge by Danny Ma and is intended for educational purposes.

## Author

**Jaden Joseph Moncy**
- B.Tech | IIT Guwahati
- LinkedIn: [Your LinkedIn]
- Portfolio: [Your Portfolio]
- Email: [Your Email]

---

*This documentation provides a comprehensive guide to the Danny's Diner SQL Case Study project. The project focuses on SQL implementation and business analysis, with all necessary files included for immediate use.* 