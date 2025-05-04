-- create the course_management database
CREATE DATABASE course_management;

-- we select it for use
USE course_management;

-- create the Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE
);

 -- create the Instructors table
 CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

-- create the Courses table to store details about the courses.
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    course_description TEXT,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

-- create the Enrollments table, which will track the courses that each student is enrolled in
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- view tables
show tables;

-- Inserting Data into the Tables
-- Insert 10 students:
INSERT INTO Students VALUES
(1, 'Alice', 'Mwangi', 'alice.mwangi@example.com', '2000-05-12'),
(2, 'Brian', 'Otieno', 'brian.otieno@example.com', '1999-07-19'),
(3, 'Cynthia', 'Kariuki', 'cynthia.k@example.com', '2001-01-15'),
(4, 'David', 'Mutua', 'david.mutua@example.com', '1998-12-03'),
(5, 'Eunice', 'Kamau', 'eunice.k@example.com', '2002-06-25'),
(6, 'Frank', 'Omondi', 'frank.omondi@example.com', '1997-03-09'),
(7, 'Grace', 'Wanjiku', 'grace.w@example.com', '2000-11-30'),
(8, 'Henry', 'Kiprono', 'henry.k@example.com', '2001-08-21'),
(9, 'Irene', 'Njeri', 'irene.n@example.com', '1999-09-14'),
(10, 'James', 'Maina', 'james.maina@example.com', '1998-02-02');
-- view students table if data has been updated
select * from Students;

-- Insert 3 instructors
INSERT INTO Instructors VALUES
(1, 'Thomas', 'Ndegwa', 'thomas.ndegwa@example.com'),
(2, 'Lilian', 'Achieng', 'lilian.a@example.com'),
(3, 'George', 'Kariuki', 'george.kariuki@example.com');

-- view instructors table if data has been inserted
select * from Instructors;

-- Insert 5 courses
INSERT INTO Courses VALUES
(101, 'Intro to SQL', 'Learn basics of SQL and querying data.', 1),
(102, 'Python for Data Analysis', 'Use Python to explore and analyze data.', 2),
(103, 'Business Intelligence', 'Tools and techniques in BI.', 3),
(104, 'Data Visualization', 'Create dashboards with Power BI and Tableau.', 1),
(105, 'Statistics 101', 'Foundational concepts in statistics.', 2);

-- view courses table if data has been inserted
select * from Courses;

-- Insert 15 enrollments:
INSERT INTO Enrollments VALUES
(1, 1, 101, '2024-01-10', 'A'),
(2, 2, 101, '2024-01-11', 'B'),
(3, 3, 102, '2024-01-15', 'A'),
(4, 4, 102, '2024-01-16', 'C'),
(5, 5, 103, '2024-01-20', 'B'),
(6, 6, 103, '2024-01-21', 'A'),
(7, 7, 104, '2024-01-25', 'A'),
(8, 8, 104, '2024-01-26', 'B'),
(9, 9, 105, '2024-02-01', 'C'),
(10, 10, 105, '2024-02-02', 'B'),
(11, 1, 102, '2024-02-03', 'B'),
(12, 2, 103, '2024-02-04', 'C'),
(13, 3, 104, '2024-02-05', 'A'),
(14, 4, 105, '2024-02-06', 'B'),
(15, 5, 101, '2024-02-07', 'A');

-- view enrollments table if data has been inserted
select * from Enrollments;

-- Running SQL Queries
-- Students who enrolled in at least one course:
SELECT DISTINCT s.student_id, s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id;

-- Students enrolled in more than two courses
SELECT s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS total_courses
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 2;

-- Courses with total enrolled students
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- Average grade per course (A=4, ..., F=0)
SELECT 
    c.course_id,
    c.course_name,
    ROUND(AVG(
        CASE e.grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            WHEN 'F' THEN 0
        END
    ), 2) AS average_grade
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- Students who haven’t enrolled in any course
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- Students with their average grade across all courses
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    ROUND(AVG(
        CASE e.grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            WHEN 'F' THEN 0
        END
    ), 2) AS avg_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name;

-- Instructors with the number of courses they teach
SELECT 
    i.instructor_id,
    i.first_name,
    i.last_name,
    COUNT(c.course_id) AS total_courses
FROM Instructors i
LEFT JOIN Courses c ON i.instructor_id = c.instructor_id
GROUP BY i.instructor_id, i.first_name, i.last_name;

-- Students enrolled in a course taught by “Lilian Achieng”
SELECT DISTINCT Students.student_id, Students.first_name, Students.last_name
FROM Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id
JOIN Instructors ON Courses.instructor_id = Instructors.instructor_id
WHERE Instructors.first_name = 'Lilian' AND Instructors.last_name = 'Achieng';

-- Top 3 students by average grade
SELECT 
    Students.student_id,
    Students.first_name,
    Students.last_name,
    ROUND(AVG(
        CASE Enrollments.grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            WHEN 'F' THEN 0
        END
    ), 2) AS avg_grade
FROM Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id
GROUP BY Students.student_id, Students.first_name, Students.last_name
ORDER BY avg_grade DESC
LIMIT 3;

-- Students failing (grade = 'F') in more than one course
SELECT 
    Students.student_id,
    Students.first_name,
    Students.last_name,
    COUNT(*) AS fail_count
FROM Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id
WHERE Enrollments.grade = 'F'
GROUP BY Students.student_id, Students.first_name, Students.last_name
HAVING COUNT(*) > 1;

-- Advanced SQL
-- Create a VIEW named student_course_summary
CREATE VIEW student_course_summary AS
SELECT 
    CONCAT(Students.first_name, ' ', Students.last_name) AS student_name,
    Courses.course_name,
    Enrollments.grade
FROM Enrollments
JOIN Students ON Enrollments.student_id = Students.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id;

-- viewing the student course summary
SELECT * FROM student_course_summary;

-- Add an INDEX on Enrollments.student_id
CREATE INDEX idx_student_id ON Enrollments(student_id);

-- Create a TRIGGER to log new enrollments
-- create a log table
CREATE TABLE Enrollment_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create the trigger
DELIMITER $$

CREATE TRIGGER after_enrollment_insert
AFTER INSERT ON Enrollments
FOR EACH ROW
BEGIN
    INSERT INTO Enrollment_Log (student_id, course_id)
    VALUES (NEW.student_id, NEW.course_id);
END$$

DELIMITER ;



















































































