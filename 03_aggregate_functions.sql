-- ========================================================
-- BASIC SQL TUTORIAL - 03: Aggregate Functions & GROUP BY
-- ========================================================

-- 1. COUNT() - Count rows
SELECT COUNT(*) FROM employees;  -- Total number of employees

SELECT COUNT(salary) FROM employees;  -- Count non-null salary values

SELECT COUNT(DISTINCT department) FROM employees;  -- Count unique departments


-- 2. SUM() - Add up numeric values
SELECT SUM(salary) FROM employees;  -- Total salary of all employees

SELECT SUM(sales_amount) FROM sales WHERE year = 2024;


-- 3. AVG() - Calculate average
SELECT AVG(salary) FROM employees;  -- Average salary

SELECT AVG(salary) FROM employees WHERE department = 'Sales';  -- Average salary in Sales dept


-- 4. MIN() and MAX() - Find minimum and maximum values
SELECT MIN(salary) FROM employees;  -- Lowest salary

SELECT MAX(salary) FROM employees;  -- Highest salary

-- Find employee with highest salary
SELECT first_name, MAX(salary) FROM employees;


-- 5. GROUP BY - Group rows by column value
-- Aggregate functions calculate for each group

-- Total salary by department
SELECT department, SUM(salary) 
FROM employees 
GROUP BY department;

-- Count employees by department
SELECT department, COUNT(*) as employee_count
FROM employees
GROUP BY department;

-- Average salary by department
SELECT department, AVG(salary) as avg_salary
FROM employees
GROUP BY department;

-- Multiple columns in GROUP BY
SELECT department, job_title, COUNT(*) as count, AVG(salary) as avg_salary
FROM employees
GROUP BY department, job_title;


-- 6. HAVING - Filter groups (like WHERE but for groups)
-- WHERE filters rows BEFORE grouping
-- HAVING filters groups AFTER aggregation

-- Departments with average salary > 50000
SELECT department, AVG(salary) as avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;

-- Departments with more than 10 employees
SELECT department, COUNT(*) as emp_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 10;

-- Complex example: Sales and Marketing departments with avg salary > 40000
SELECT department, AVG(salary) as avg_salary
FROM employees
WHERE department IN ('Sales', 'Marketing')
GROUP BY department
HAVING AVG(salary) > 40000;
