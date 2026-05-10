-- ========================================================
-- BASIC SQL TUTORIAL - 02: Sorting & Filtering Results
-- ========================================================

-- 1. ORDER BY - Sort results
SELECT * FROM employees ORDER BY salary;  -- Ascending (default)

SELECT * FROM employees ORDER BY salary ASC;  -- Explicitly ascending

SELECT * FROM employees ORDER BY salary DESC;  -- Descending

SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC;  -- Highest salary first

SELECT first_name, last_name, hire_date
FROM employees
ORDER BY hire_date ASC;  -- Oldest employees first


-- 2. Order by multiple columns
SELECT * FROM employees ORDER BY department, salary DESC;
-- First sort by department alphabetically, then by salary (high to low) within each department

SELECT first_name, department, salary
FROM employees
ORDER BY department ASC, salary DESC;


-- 3. DISTINCT - Remove duplicate rows
SELECT DISTINCT department FROM employees;  -- List each department once

SELECT DISTINCT job_title FROM employees;  -- List each job title once

-- Combine with WHERE
SELECT DISTINCT department 
FROM employees 
WHERE salary > 50000;  -- Unique departments where someone earns > 50000


-- 4. LIMIT - Get only first N rows
SELECT * FROM employees LIMIT 5;  -- Get first 5 employees

SELECT first_name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 10;  -- Top 10 highest paid employees

SELECT first_name FROM employees LIMIT 1;  -- Get 1 employee


-- 5. OFFSET - Skip rows (pagination)
SELECT * FROM employees LIMIT 5 OFFSET 0;  -- First 5 (rows 1-5)
SELECT * FROM employees LIMIT 5 OFFSET 5;  -- Next 5 (rows 6-10)
SELECT * FROM employees LIMIT 5 OFFSET 10; -- Next 5 (rows 11-15)

-- Pagination example: Show 10 results per page
-- Page 1: OFFSET 0
-- Page 2: OFFSET 10
-- Page 3: OFFSET 20


-- 6. Combining everything
SELECT first_name, last_name, salary, department
FROM employees
WHERE salary > 40000
ORDER BY salary DESC
LIMIT 10;  -- Top 10 highest paid employees earning over 40000

SELECT DISTINCT department
FROM employees
WHERE hire_date > '2021-01-01'
ORDER BY department;  -- Departments of recent hires, sorted


-- 7. Real-world examples
-- Get 5 most recent employees hired
SELECT first_name, last_name, hire_date
FROM employees
ORDER BY hire_date DESC
LIMIT 5;

-- Get top 3 departments by employee count
SELECT department, COUNT(*) as emp_count
FROM employees
GROUP BY department
ORDER BY emp_count DESC
LIMIT 3;

-- Get employees with 2nd-5th highest salaries
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 4 OFFSET 1;
