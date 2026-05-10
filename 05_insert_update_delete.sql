-- ========================================================
-- BASIC SQL TUTORIAL - 05: INSERT, UPDATE, DELETE & TRANSACTIONS
-- ========================================================

-- 1. INSERT - Add new rows (single row)
INSERT INTO employees (first_name, last_name, salary, department)
VALUES ('John', 'Doe', 55000, 'IT');

-- Insert with all columns
INSERT INTO employees 
(id, first_name, last_name, salary, department, hire_date, manager_id)
VALUES (101, 'Jane', 'Smith', 60000, 'Sales', '2024-05-10', 5);

-- Insert without specifying columns (must provide all values in order)
INSERT INTO employees 
VALUES (102, 'Bob', 'Johnson', 50000, 'IT', '2024-05-10', 3);


-- 2. INSERT multiple rows at once
INSERT INTO employees (first_name, last_name, salary, department)
VALUES 
  ('Alice', 'Brown', 65000, 'HR'),
  ('Charlie', 'Davis', 55000, 'IT'),
  ('Diana', 'Evans', 72000, 'Sales');


-- 3. INSERT from SELECT (copy data from another table)
INSERT INTO employees_backup (first_name, last_name, salary)
SELECT first_name, last_name, salary FROM employees;
-- Copy all employees to backup table

INSERT INTO employees_archive
SELECT * FROM employees WHERE hire_date < '2020-01-01';
-- Archive employees hired before 2020


-- 4. UPDATE - Modify existing data
UPDATE employees SET salary = 65000 WHERE id = 5;
-- Update one specific employee's salary

UPDATE employees SET department = 'Management' WHERE id = 10;
-- Change one employee's department

-- Update multiple employees
UPDATE employees SET salary = salary * 1.1 WHERE department = 'Sales';
-- Give 10% raise to all Sales employees

-- Update multiple columns
UPDATE employees 
SET salary = 70000, department = 'IT' 
WHERE id = 15;

-- Update with WHERE clause for multiple matches
UPDATE employees 
SET salary = salary + 5000 
WHERE hire_date > '2023-01-01';
-- Raise salary for all employees hired after Jan 1, 2023


-- 5. DELETE - Remove rows
DELETE FROM employees WHERE id = 5;
-- Delete one specific employee

DELETE FROM employees WHERE department = 'Temp';
-- Delete all temporary employees

-- Delete based on multiple conditions
DELETE FROM employees 
WHERE salary < 20000 AND hire_date < '2022-01-01';

-- Delete all matching a pattern
DELETE FROM employees 
WHERE last_name LIKE '%Test%';


-- WARNING: Be careful with DELETE!
-- DELETE FROM employees;  -- This deletes ALL employees! Never do this!


-- 6. Transactions - Ensure data consistency
-- BEGIN TRANSACTION
BEGIN;  -- Start transaction

UPDATE employees SET salary = salary - 500 WHERE id = 1;
UPDATE bank_accounts SET balance = balance + 500 WHERE id = 2;

COMMIT;  -- Save all changes (if no errors)
-- OR ROLLBACK; -- Undo all changes if something went wrong


-- 7. Transaction with error handling
BEGIN;  -- Start transaction

UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;

-- If both updates succeed, commit
COMMIT;  -- All changes saved

-- If there's an error, rollback:
-- ROLLBACK;  -- Undo all changes


-- 8. Real-world examples

-- Onboard new employee
BEGIN;
INSERT INTO employees (first_name, last_name, salary, department, hire_date)
VALUES ('Mike', 'Wilson', 58000, 'IT', '2024-05-10');

INSERT INTO email (employee_id, email)
VALUES (LAST_INSERT_ID(), 'mike.wilson@company.com');

INSERT INTO office_assignment (employee_id, office_number)
VALUES (LAST_INSERT_ID(), 305);

COMMIT;

-- Give annual raises to all employees
BEGIN;

UPDATE employees 
SET salary = ROUND(salary * 1.03, 2)  -- 3% raise
WHERE hire_date < '2024-01-01';

COMMIT;

-- Fire an employee and clean up (be careful!)
BEGIN;

-- First, backup the employee
INSERT INTO employees_terminated 
SELECT * FROM employees WHERE id = 999;

-- Then delete from active table
DELETE FROM email WHERE employee_id = 999;
DELETE FROM office_assignment WHERE employee_id = 999;
DELETE FROM employees WHERE id = 999;

COMMIT;


-- 9. Safety best practices

-- Use SELECT first before DELETE/UPDATE
SELECT * FROM employees WHERE department = 'Old_Dept';
-- Check results, THEN do the update:
UPDATE employees SET department = 'New_Dept' WHERE department = 'Old_Dept';

-- Better: use LIMIT when testing
UPDATE employees SET status = 'inactive' WHERE hire_date < '2015-01-01' LIMIT 5;
-- Only update 5 rows to test

-- Use transactions for related updates
BEGIN;
  UPDATE orders SET status = 'shipped' WHERE id = 123;
  UPDATE inventory SET quantity = quantity - 5 WHERE product_id = 456;
COMMIT;

-- Verify changes
SELECT * FROM employees WHERE id = 5;  -- Check updated row
