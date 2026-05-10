````markdown name=README.md
# SQL Tutorial - Very Basic SQL 🎓

Welcome! This repository contains **5 beginner-friendly SQL tutorials** with clear explanations and practical examples.

## 📚 Files Overview

### 1. **01_basics.sql** - SELECT & WHERE
Start here! Learn how to retrieve and filter data.

**Topics:**
- `SELECT` statements (all columns, specific columns)
- `WHERE` clause for filtering
- Comparison operators: `=`, `>`, `<`, `>=`, `<=`, `<>`
- Logical operators: `AND`, `OR`, `NOT`
- Pattern matching: `IN`, `BETWEEN`, `LIKE`
- `IS NULL` / `IS NOT NULL`

**Example:**
```sql
SELECT first_name, salary 
FROM employees 
WHERE department = 'Sales' AND salary > 50000;
```

---

### 2. **02_sorting_and_filtering.sql** - ORDER BY & Pagination
Organize and limit your results effectively.

**Topics:**
- `ORDER BY` (ascending/descending)
- `DISTINCT` (remove duplicates)
- `LIMIT` (get first N rows)
- `OFFSET` (skip rows for pagination)
- Combining all concepts

**Example:**
```sql
SELECT first_name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 10;  -- Top 10 highest paid
```

---

### 3. **03_aggregate_functions.sql** - COUNT, SUM, AVG & GROUP BY
Summarize and analyze your data.

**Topics:**
- `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`
- `GROUP BY` (group rows)
- `HAVING` (filter groups)
- Multiple columns in GROUP BY

**Example:**
```sql
SELECT department, AVG(salary) as avg_salary, COUNT(*) as emp_count
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;
```

---

### 4. **04_joins.sql** - Combining Tables
Work with data from multiple tables.

**Topics:**
- `INNER JOIN` (matching records only)
- `LEFT JOIN` (all from left table)
- `RIGHT JOIN` (all from right table)
- `FULL JOIN` (all from both tables)
- `CROSS JOIN` (all combinations)
- `Self JOIN` (table to itself)
- Multiple JOINs
- JOINs with GROUP BY and WHERE

**Example:**
```sql
SELECT e.first_name, d.dept_name, COUNT(p.id) as project_count
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id
LEFT JOIN projects p ON e.id = p.employee_id
GROUP BY e.first_name, d.dept_name;
```

---

### 5. **05_insert_update_delete.sql** - Modifying Data
Add, change, and remove data safely.

**Topics:**
- `INSERT` (single & multiple rows)
- `INSERT INTO ... SELECT` (copy data)
- `UPDATE` (modify existing data)
- `DELETE` (remove rows)
- `TRANSACTIONS` (BEGIN, COMMIT, ROLLBACK)
- Best practices & safety tips

**Example:**
```sql
BEGIN;  -- Start transaction
UPDATE employees SET salary = salary * 1.03 WHERE department = 'Sales';
INSERT INTO salary_history SELECT * FROM employees WHERE updated = NOW();
COMMIT;  -- Save all changes
```

---

## 🚀 Quick Start

1. **Read files in order** (01 → 05)
2. **Read the comments** in each SQL file
3. **Copy and run examples** in your SQL database
4. **Modify examples** to practice

## 📖 Recommended Learning Path

| Step | Focus | File |
|------|-------|------|
| 1 | Basic queries | `01_basics.sql` |
| 2 | Organize results | `02_sorting_and_filtering.sql` |
| 3 | Analyze data | `03_aggregate_functions.sql` |
| 4 | Combine tables | `04_joins.sql` |
| 5 | Modify data | `05_insert_update_delete.sql` |

## 💡 Key Concepts Cheat Sheet

### Filtering Data
```sql
WHERE department = 'IT'           -- Exact match
WHERE salary > 50000              -- Comparison
WHERE name LIKE 'J%'              -- Pattern (starts with J)
WHERE id IN (1, 2, 3)             -- In a list
WHERE age BETWEEN 25 AND 35       -- In range
```

### Sorting & Limiting
```sql
ORDER BY salary DESC              -- Sort high to low
LIMIT 10                          -- Get first 10
LIMIT 10 OFFSET 20                -- Get 10 after skipping 20 (page 3)
```

### Summarizing Data
```sql
COUNT(*)                          -- Count all rows
COUNT(DISTINCT dept)              -- Count unique departments
SUM(salary)                       -- Total salary
AVG(salary)                       -- Average salary
GROUP BY department               -- Group by department
HAVING COUNT(*) > 5               -- Filter groups
```

### Joining Tables
```sql
INNER JOIN dept ON e.dept_id = d.id    -- Only matches
LEFT JOIN dept ON e.dept_id = d.id     -- All from left
RIGHT JOIN dept ON e.dept_id = d.id    -- All from right
```

## ⚠️ Common Mistakes to Avoid

| Mistake | Example | Fix |
|---------|---------|-----|
| Forgetting WHERE with DELETE | `DELETE FROM users;` | `DELETE FROM users WHERE id = 5;` |
| Wrong table join | `JOIN users` | `JOIN users ON orders.user_id = users.id` |
| GROUP BY without aggregates | `SELECT * FROM users GROUP BY dept;` | `SELECT dept, COUNT(*) FROM users GROUP BY dept;` |
| Forgetting quotes on text | `WHERE name = John` | `WHERE name = 'John'` |
| Using AND/OR incorrectly | `WHERE dept = 'IT' OR 'Sales'` | `WHERE dept IN ('IT', 'Sales')` |

## 🎯 Practice Ideas

1. **Query your own data:**
   - Find your top 5 customers by spending
   - List employees by department and salary
   - Count orders per month

2. **Use multiple concepts:**
   - Combine WHERE, ORDER BY, and LIMIT
   - Use GROUP BY with HAVING
   - JOIN 2+ tables with aggregate functions

3. **Transactions:**
   - Practice with test data
   - Run UPDATE, then ROLLBACK
   - Understand BEGIN/COMMIT

## 📝 Notes

- These examples use common SQL syntax (MySQL, PostgreSQL, SQL Server, SQLite)
- Some features may differ slightly by database (e.g., FULL JOIN not in MySQL)
- Always test on non-production data first!
- Use `SELECT` to preview data before `DELETE` or `UPDATE`

## 🤔 Need Help?

- Read the comments in each `.sql` file
- Study the examples carefully
- Modify examples and see what changes
- Start simple, then combine concepts

---

**Happy Learning! 📊**
````
