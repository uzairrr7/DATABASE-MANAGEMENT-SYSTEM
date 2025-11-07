-- 03_queries_exercises.sql
-- Exercises (prompt + query). Use these as practice tasks or in README.

-- Q1: List students with their enrolled courses and grades.
-- Answer:
SELECT s.roll_no, s.name AS student_name, c.code, c.title, e.semester, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.roll_no, e.semester;

-- Q2: Find the department with the highest number of courses.
-- Answer:
SELECT d.name, COUNT(c.course_id) AS course_count
FROM departments d
LEFT JOIN courses c ON d.dept_id = c.dept_id
GROUP BY d.dept_id, d.name
ORDER BY course_count DESC
LIMIT 1;

-- Q3: Get average grade per course using a grade-to-number mapping (example mapping).
-- For demonstration, map A=4, A-=3.7, B+=3.3, B=3.0, etc. (use CASE)
-- Note: real implementations might store numeric grade points in DB.
SELECT c.code, c.title,
       AVG(
         CASE e.grade
           WHEN 'A'  THEN 4.0
           WHEN 'A-' THEN 3.7
           WHEN 'B+' THEN 3.3
           WHEN 'B'  THEN 3.0
           WHEN 'B-' THEN 2.7
           WHEN 'C+' THEN 2.3
           WHEN 'C'  THEN 2.0
           WHEN 'D'  THEN 1.0
           WHEN 'F'  THEN 0.0
           ELSE NULL
         END
       ) AS avg_grade_points
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.code, c.title
ORDER BY avg_grade_points DESC NULLS LAST;

-- Q4: Find students not enrolled in any course.
SELECT s.roll_no, s.name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.enroll_id IS NULL;

-- Q5: Second highest salary among professors (without using LIMIT)
SELECT DISTINCT salary
FROM professors
ORDER BY salary DESC
OFFSET 1 LIMIT 1;

-- Q6: Update: give 5% raise to professors in Computer Science dept.
UPDATE professors
SET salary = salary * 1.05
WHERE dept_id = (SELECT dept_id FROM departments WHERE name = 'Computer Science');

-- Q7: Create a view for student course summary
CREATE OR REPLACE VIEW student_course_summary AS
SELECT s.student_id, s.roll_no, s.name AS student_name,
       c.course_id, c.code, c.title, e.semester, e.grade
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id;
