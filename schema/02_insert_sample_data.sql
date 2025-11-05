-- 02_insert_sample_data.sql

-- Departments
INSERT INTO departments (name, building) VALUES
('Computer Science', 'Block A'),
('Mathematics', 'Block B'),
('Physics', 'Block C');

-- Professors
INSERT INTO professors (name, dept_id, hire_date, salary) VALUES
('Dr. Aisha Khan', 1, '2015-08-10', 85000.00),
('Dr. Raj Patel', 2, '2010-03-01', 78000.00),
('Dr. Lina Gomez', 1, '2018-01-12', 72000.00);

-- Students
INSERT INTO students (roll_no, name, dob, admission_year) VALUES
('CS2023001', 'Ali', '2004-02-15', 2023),
('CS2023002', 'Uzair', '2003-10-05', 2023),
('MA2022001', 'Ayesha', '2002-06-20', 2022),
('PH2021001', 'Rohit', '2001-11-30', 2021);

-- Courses
INSERT INTO courses (code, title, credits, dept_id) VALUES
('CS101', 'Intro to Programming', 4, 1),
('CS201', 'Data Structures', 3, 1),
('MA101', 'Calculus I', 4, 2),
('PH101', 'Mechanics', 3, 3);

-- Enrollments
INSERT INTO enrollments (student_id, course_id, semester, grade) VALUES
(1, 1, '2023-Fall', 'A'),
(2, 1, '2023-Fall', 'A-'),
(2, 2, '2023-Fall', 'B+'),
(3, 3, '2022-Fall', 'A'),
(4, 4, '2021-Fall', 'B');
