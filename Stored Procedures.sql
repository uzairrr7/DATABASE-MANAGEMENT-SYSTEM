View with aggregation: Department salary summary
CREATE VIEW DeptSalarySummary AS
SELECT department_id,
       COUNT(*) AS total_employees,
       SUM(salary) AS total_salary,
       AVG(salary) AS avg_salary
FROM Employees
GROUP BY department_id;
 
-- Query it:
-- SELECT * FROM DeptSalarySummary ORDER BY avg_salary DESC;
