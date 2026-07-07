 Basic view: Employees with department names
CREATE VIEW EmployeeDeptView AS
SELECT e.employee_id, e.name, e.salary, d.department_name
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id;
 
-- Query it like a normal table:
-- SELECT * FROM EmployeeDeptView WHERE salary > 60000;
