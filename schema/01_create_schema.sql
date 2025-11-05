-- 01_create_schema.sql
-- University sample DB: students, departments, professors, courses, enrollments

-- Drop if exists (safe for repeated runs)
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS professors;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS departments;

-- Departments
CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    building VARCHAR(100)
);

-- Professors
CREATE TABLE professors (
    prof_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dept_id INT NOT NULL,
    hire_date DATE,
    salary NUMERIC(12,2) CHECK (salary >= 0),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE RESTRICT
);

-- Students
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    roll_no VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    admission_year INT CHECK (admission_year BETWEEN 1900 AND 2100)
);

-- Courses
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    code VARCHAR(10) UNIQUE NOT NULL,
    title VARCHAR(150) NOT NULL,
    credits INT CHECK (credits > 0),
    dept_id INT NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE SET NULL
);

-- Enrollments (many-to-many: students <-> courses)
CREATE TABLE enrollments (
    enroll_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    semester VARCHAR(10),
    grade CHAR(2),
    enrolled_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (student_id, course_id, semester),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- Example domain constraint (domain integrity)
ALTER TABLE students
  ADD CONSTRAINT chk_name_nonempty CHECK (char_length(name) > 0);
