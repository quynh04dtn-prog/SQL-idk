-- ========================================================
-- BASIC SQL TUTORIAL - 04: JOINs - Combining Tables
-- ========================================================

-- Setup: Assume we have these tables:
-- employees (id, name, dept_id, salary)
-- departments (id, name, location)
-- projects (id, name, employee_id, status)

-- 1. INNER JOIN - Only matching records from both tables
SELECT employees.first_name, employees.salary, departments.dept_name
FROM employees
INNER JOIN departments ON employees.dept_id = departments.id;
-- Get employee names with their department names

-- Shorter syntax with aliases
SELECT e.first_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id;

-- Filter results
SELECT e.first_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id
WHERE d.dept_name = 'Sales';
-- Get Sales department employees with their info


-- 2. LEFT JOIN - All rows from left table + matching from right
SELECT e.first_name, e.salary, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id;
-- Get all employees, and their department name (if exists)

-- Find employees without a department assignment
SELECT e.first_name, e.salary, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id
WHERE d.id IS NULL;


-- 3. RIGHT JOIN - All rows from right table + matching from left
SELECT e.first_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.id;
-- Get all departments with employees (if any)

-- Find departments with no employees
SELECT d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.id
WHERE e.id IS NULL;


-- 4. FULL JOIN (or FULL OUTER JOIN) - All rows from both tables
SELECT e.first_name, d.dept_name
FROM employees e
FULL JOIN departments d ON e.dept_id = d.id;
-- Get all employees AND all departments, matching where possible
-- Note: Not all databases support FULL JOIN (use UNION in those cases)


-- 5. CROSS JOIN - Cartesian product (every row with every row)
SELECT e.first_name, p.project_name
FROM employees e
CROSS JOIN projects p;
-- Get all possible combinations of employees and projects
-- WARNING: Can create very large result sets!


-- 6. Self JOIN - Join table to itself
-- Example: Find manager and employee pairs (if manager_id exists)
SELECT e.first_name as employee, m.first_name as manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;


-- 7. Multiple JOINs - Combine more than 2 tables
SELECT e.first_name, d.dept_name, p.project_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id
INNER JOIN projects p ON e.id = p.employee_id;
-- Get employee names with their departments and projects

-- Complex example with different join types
SELECT 
    e.first_name,
    d.dept_name,
    p.project_name,
    p.status
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id
INNER JOIN projects p ON e.id = p.employee_id
WHERE p.status = 'Active';


-- 8. JOIN with GROUP BY and aggregates
SELECT 
    d.dept_name,
    COUNT(e.id) as employee_count,
    AVG(e.salary) as avg_salary
FROM departments d
LEFT JOIN employees e ON d.id = e.dept_id
GROUP BY d.dept_name;
-- Count employees and avg salary by department


-- 9. JOIN with WHERE clause
SELECT e.first_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id
WHERE e.salary > 50000 AND d.dept_name IN ('Sales', 'IT');
-- Sales or IT employees earning over 50k


-- 10. JOIN with ORDER BY
SELECT e.first_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id
ORDER BY d.dept_name, e.salary DESC;
-- Sort by department, then by salary (high to low)

-- 11. Common JOIN scenarios
-- Find employees and count their projects
SELECT 
    e.first_name,
    COUNT(p.id) as project_count
FROM employees e
LEFT JOIN projects p ON e.id = p.employee_id
GROUP BY e.first_name;

-- Get project info with employee assignments
SELECT 
    p.project_name,
    e.first_name,
    p.status
FROM projects p
LEFT JOIN employees e ON p.employee_id = e.id;
