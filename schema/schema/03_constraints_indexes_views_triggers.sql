-- 03_constraints_indexes_views_triggers.sql

-- Indexes for performance
CREATE INDEX idx_students_roll ON students(roll_no);
CREATE INDEX idx_courses_code ON courses(code);
CREATE INDEX idx_enroll_student ON enrollments(student_id);
CREATE INDEX idx_enroll_course ON enrollments(course_id);

-- View: student transcript (aggregated)
CREATE OR REPLACE VIEW vw_student_transcript AS
SELECT s.student_id, s.roll_no, s.name AS student_name,
       c.code AS course_code, c.title AS course_title,
       e.semester, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

-- Trigger example (Postgres syntax): update a log table when new enrollment occurs
CREATE TABLE IF NOT EXISTS audit_enrollments (
    audit_id SERIAL PRIMARY KEY,
    enroll_id INT,
    student_id INT,
    course_id INT,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action TEXT
);

CREATE OR REPLACE FUNCTION fn_log_enroll() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO audit_enrollments(enroll_id, student_id, course_id, action, action_time)
    VALUES (NEW.enroll_id, NEW.student_id, NEW.course_id, 'INSERT', CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_enroll
AFTER INSERT ON enrollments
FOR EACH ROW EXECUTE FUNCTION fn_log_enroll();
