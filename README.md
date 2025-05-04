# Course Management System – SQL Project

![](https://github.com/MastingoJay/Lux-Dev-Week-2-SQL-Project/blob/main/%F0%9F%92%BB.jpg)

This project is a Course Management System built using MySQL Workbench and PostgreSQL. 
It simulates a simple academic environment where students enroll in courses taught by instructors. 
It includes table creation, data insertion, and advanced SQL queries to analyze academic data.
Attached is the word document containing queries written,run and results of each.

# 1. ERD (Entity Relationship Diagram) 

![](https://github.com/MastingoJay/Lux-Dev-Week-2-SQL-Project/blob/main/drawSQL-image-export-2025-05-04.png)
The database includes four main entities: Students, Instructors, Courses, and Enrollments.
Relationships:

- Each course is taught by one instructor.

- Each student can enroll in multiple courses.

- The Enrollments table connects students and courses (many-to-many).

# 2. Instructions to Run the SQL Code

- Open MySQL Workbench or your PostgreSQL client.

- Run the CREATE DATABASE course_management; command.

  <pre> ``` -- Create the Students table 
    CREATE TABLE Students 
    ( student_id INT PRIMARY KEY, 
    first_name VARCHAR(50), 
    last_name VARCHAR(50), 
    email VARCHAR(100) UNIQUE, 
    date_of_birth DATE ); ``` </pre>

- Use the database: USE course_management;

- Execute the table creation and data insertion scripts in order.
  
<pre> ``` INSERT INTO Instructors VALUES 
  (1, 'Thomas', 'Ndegwa', 'thomas.ndegwa@example.com'), 
  (2, 'Lilian', 'Achieng', 'lilian.a@example.com'),
  (3, 'George', 'Kariuki', 'george.kariuki@example.com'); ``` </pre>


- Run the queries section to explore insights from the dataset.

<pre> ```  -- Students enrolled in a course taught by “Lilian Achieng”
SELECT DISTINCT Students.student_id, Students.first_name, Students.last_name
FROM Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id
JOIN Instructors ON Courses.instructor_id = Instructors.instructor_id
WHERE Instructors.first_name = 'Lilian' AND Instructors.last_name = 'Achieng';  ``` </pre>

# 3. Schema Explanation

## 🗂️ Database Tables

| Table Name       | Description                                                       |
|------------------|-------------------------------------------------------------------|
| **Students**     | Stores student details (ID, name, email, DOB)                     |
| **Instructors**  | Stores instructor info (ID, name, email)                          |
| **Courses**      | Course details, each linked to an instructor                      |
| **Enrollments**  | Tracks which student is enrolled in which course and grade        |
| **Enrollment_Log** | Logs new enrollments using a trigger                            |


# 4. Key Query Highlights

- Students with more than 2 course enrollments

- Courses with the total number of students enrolled

- Average grade per course and per student (A=4 to F=0)

- Students enrolled in courses taught by a specific instructor

- Top 3 students based on grades

- Students failing more than once

- View to summarize student-course-grade relationships


# 5. Sample Output Descriptions

- Top Students by Average Grade:
Returns the names and average grades of the top 3 performers.

![](https://github.com/MastingoJay/Lux-Dev-Week-2-SQL-Project/blob/main/Screenshot%20(280).png)

- Courses with Enrollment Count:
Helps identify popular courses.

![](https://github.com/MastingoJay/Lux-Dev-Week-2-SQL-Project/blob/main/Screenshot%20(274).png)

- View student_course_summary:
Shows student names, course names, and grades in a readable format.

![](https://github.com/MastingoJay/Lux-Dev-Week-2-SQL-Project/blob/main/Screenshot%20(285).png)

# 6. Challenges and Lessons Learned

- Ensuring referential integrity using foreign keys and constraints

- Designing a normalized schema to avoid data redundancy

- Using CASE statements for grade-to-score conversion

- Creating a useful VIEW for summarized insights

- Writing aggregate queries with GROUP BY and HAVING clauses

- Implementing a TRIGGER to automatically log activity
  

