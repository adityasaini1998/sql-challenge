-- Retrieve detailed information about each employee
SELECT
    emp.emp_no AS EmployeeID,
    emp.last_name AS LastName,
    emp.first_name AS FirstName,
    emp.sex AS Gender,
    sal.salary AS Salary
FROM employees emp
LEFT JOIN salaries sal ON emp.emp_no = sal.emp_no
ORDER BY emp.emp_no;

-- List employees hired in the year 1986
SELECT
    emp.last_name AS LastName,
    emp.first_name AS FirstName,
    emp.hire_date AS HireDate
FROM employees emp
WHERE EXTRACT(YEAR FROM emp.hire_date) = 1986;

-- Department Managers with their details
SELECT
    dept.dept_no AS DeptNumber,
    dept.dept_name AS DeptName,
    emp.emp_title_id AS TitleID,
    emp.last_name AS LastName,
    emp.first_name AS FirstName
FROM dept_emp de
LEFT JOIN employees emp ON de.emp_no = emp.emp_no
LEFT JOIN departments dept ON de.dept_no = dept.dept_no
WHERE emp.emp_title_id LIKE 'm%';

-- Create a view for employee-department relationship
CREATE VIEW emp_department AS
SELECT
    emp.emp_no AS EmployeeID,
    emp.last_name AS LastName,
    emp.first_name AS FirstName,
    dept.dept_name AS Department
FROM dept_emp de
LEFT JOIN employees emp ON de.emp_no = emp.emp_no
LEFT JOIN departments dept ON de.dept_no = dept.dept_no;

-- Display the department of each employee
SELECT *
FROM emp_department;

-- List employees named Hercules with last names beginning with 'B'
SELECT
    emp.first_name AS FirstName,
    emp.last_name AS LastName,
    emp.sex AS Gender
FROM employees emp
WHERE emp.first_name = 'Hercules'
    AND emp.last_name LIKE 'B%';

-- Create a view for Sales and Development department employees
CREATE VIEW sales_dev_emp AS
SELECT
    EmployeeID,
    LastName,
    FirstName,
    Department
FROM emp_department;

-- List all employees in the Sales department
SELECT *
FROM sales_dev_emp
WHERE Department = 'Sales';

-- List employees in both Sales and Development departments
SELECT *
FROM sales_dev_emp
WHERE Department IN ('Sales', 'Development');

-- Count the frequency of each last name among employees
SELECT
    emp.last_name AS LastName,
    COUNT(emp.last_name) AS NameFrequency
FROM employees emp
GROUP BY emp.last_name
ORDER BY NameFrequency DESC;
