# Danny's Diner SQL Case Study - Analysis Results

## Expected Query Results

### Question 1: Total Amount Spent by Each Customer
```
customer_id | total_spent
------------|------------
A           | 76
B           | 74
C           | 36
```

**Insights:**
- Customer A spent the most ($76)
- Customer C spent the least ($36)
- All customers show different spending patterns

### Question 2: Number of Days Each Customer Visited
```
customer_id | visit_count
------------|------------
A           | 4
B           | 6
C           | 2
```

**Insights:**
- Customer B visited most frequently (6 days)
- Customer C visited least frequently (2 days)
- Visit frequency doesn't directly correlate with total spending

### Question 3: First Item Purchased by Each Customer
```
customer_id | product_name
------------|-------------
A           | sushi
B           | curry
C           | ramen
```

**Insights:**
- Each customer started with a different product
- No clear pattern in first purchases
- All three menu items were chosen as first purchases

### Question 4: Most Purchased Item Overall
```
product_name | order_count
-------------|------------
ramen        | 8
```

**Insights:**
- Ramen is the most popular item overall
- Ordered 8 times across all customers
- Suggests ramen should be a focus for marketing and inventory

### Question 5: Most Popular Item for Each Customer
```
customer_id | product_name | cnt
------------|-------------|-----
A           | ramen        | 3
B           | curry        | 2
C           | ramen        | 3
```

**Insights:**
- Customers A and C both prefer ramen
- Customer B prefers curry
- Ramen shows strong popularity across multiple customers

### Question 6: First Item After Membership
```
customer_id | product_name
------------|-------------
A           | curry
B           | sushi
```

**Insights:**
- Both members chose different items for their first post-membership purchase
- No clear pattern in post-membership behavior
- Suggests membership doesn't immediately change ordering preferences

### Question 7: Last Item Before Membership
```
customer_id | product_name
------------|-------------
A           | curry
B           | sushi
```

**Insights:**
- Both customers purchased different items before joining
- No clear pattern in pre-membership behavior
- Membership decisions don't seem tied to specific food preferences

### Question 8: Pre-Membership Spending
```
customer_id | total_items | total_spent
------------|-------------|------------
A           | 2           | 25
B           | 3           | 40
```

**Insights:**
- Customer B spent more before membership ($40 vs $25)
- Customer B also bought more items (3 vs 2)
- Both customers showed commitment before joining

### Question 9: Reward Points Earned
```
customer_id | total_points
------------|-------------
A           | 860
B           | 940
C           | 360
```

**Insights:**
- Customer B earned the most points (940)
- Customer C earned the least (360)
- Points correlate with spending but are boosted by sushi purchases

### Question 10: First Week Membership Activity
```
customer_id | items_bought | total_spent
------------|--------------|------------
A           | 2            | 25
B           | 1            | 12
```

**Insights:**
- Customer A was more active in first week (2 items, $25)
- Customer B was less active (1 item, $12)
- First week activity varies significantly between members

## Key Business Insights

### Customer Behavior Patterns
1. **Spending Patterns**: Customer A leads in total spending, but Customer B visits more frequently
2. **Product Preferences**: Ramen is the clear favorite, especially among customers A and C
3. **Membership Impact**: Membership doesn't immediately change ordering behavior
4. **Loyalty Indicators**: Both members showed commitment before joining

### Strategic Recommendations
1. **Menu Optimization**: Focus marketing on ramen dishes
2. **Customer Retention**: Develop VIP program for high-spenders
3. **Membership Growth**: Target customers with consistent spending
4. **Inventory Management**: Ensure ramen availability
5. **Reward Program**: Maintain sushi double-points incentive

### Data Quality Observations
- Clean, well-structured data
- Consistent date formats
- No missing values in key fields
- Appropriate data types for each column

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