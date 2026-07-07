 Updatable view (simple views on a single table can allow updates)
CREATE VIEW ActiveEmployees AS
SELECT employee_id, name, salary, department_id
FROM Employees
WHERE status = 'active';
 
-- This works because the view maps directly back to one table/row:
-- UPDATE ActiveEmployees SET salary = salary * 1.05 WHERE employee_id = 5;
