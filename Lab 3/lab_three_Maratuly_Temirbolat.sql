-- Exercise # 1
-- A. Find all courses worth more than 3 credits;
select * from course where credits > 3;

--B. Find all classrooms situated either in ‘Watson’ or ‘Packard’ buildings
select * from classroom where building in ('Packard','Watson');

--C. Find all courses offered by the Computer Science department;

select * from course where dept_name Like 'Comp%Sci%';

--D. Find all courses offered during fall;
select * from section where semester = 'Fall';

--E. Find all students who have more than 45 credits but less than 90;
SELECT * FROM student WHERE tot_cred BETWEEN 46 AND 89;

--F. Find all students whose names end with vowels
SELECT * FROM student
WHERE name LIKE '%a' OR
      name LIKE '%e' OR
      name LIKE '%i' OR
      name LIKE '%o' OR
      name LIKE '%u';

--G. Find all courses which have course ‘CS-101’ as their prerequisite;
SELECT * FROM prereq WHERE prereq_id LIKE 'CS-101';

-- Exercise 2

-- A
-- For each department, find the average salary of instructors in that
-- department and list them in ascending order. Assume that every
-- department has at least one instructor;
select dept_name, AVG(salary) as average_dept_salary from instructor
GROUP BY dept_name
ORDER BY average_dept_salary;

--B  Find the building where the biggest number of courses takes place;

select  building, COUNT(course_id) as courses_number from section
GROUP BY building
ORDER BY courses_number DESC
LIMIT 1;

-- C. Find the department with the lowest number of courses offered;
select * from course;

select dept_name, COUNT(course_id) as number_courses
from course
GROUP BY dept_name
HAVING COUNT(course_id) =
       (select COUNT(course_id) as number_courses
        from course
        GROUP BY dept_name
        ORDER BY number_courses ASC
        LIMIT 1);

-- D. Find the ID and name of each student who has taken more than 3 courses from the Computer Science department;

select * from student;
SELECT * from takes;

SELECT student.id, student.name FROM student
WHERE student.id IN (SELECT takes.id FROM takes
WHERE course_id IN
      (SELECT course_id FROM course
        WHERE dept_name LIKE 'Comp%Sci%')
GROUP BY takes.id
HAVING COUNT(course_id) > 3);

-- E. Find all instructors who work either in Biology, Philosophy, or Music departments;
SELECT * FROM instructor
WHERE dept_name IN ('Biology','Philosophy','Music');

-- F  Find all instructors who taught in the 2018 year but not in the 2017 year
SELECT * FROM instructor
    WHERE id IN (SELECT DISTINCT(teaches.id) FROM teaches
WHERE id NOT IN (SELECT DISTINCT (id) FROM teaches
WHERE year = 2017) AND year = 2018);

-- EXERCISE 3

--A. Find all students who have taken Comp. Sci. course and got an excellent grade (i.e., A, or A-) and sort them alphabetically;
SELECT *
FROM student
WHERE id IN ( select id from takes
WHERE course_id IN (select course_id
                    FROM course
                    WHERE dept_name LIKE 'Comp%Sci%') AND
      grade IN ('A','A-'));

-- B. Find all advisors of students who got grades lower than B on any class

SELECT * from instructor
    WHERE id IN (SELECT i_id FROM advisor
WHERE s_id IN (SELECT id FROM takes WHERE grade NOT IN ('B','B+','A-','A')));

--C.  Find all departments whose students have never gotten an F or C grade
SELECT * FROM department where dept_name NOT IN  (SELECT dept_name from student
    WHERE id IN (SELECT id FROM takes WHERE grade = 'F' OR grade = 'C'));

--D. Find all instructors who have never given an A grade in any of the courses they taught;

SELECT * FROM instructor
    WHERE id NOT IN (SELECT id FROM teaches
    WHERE (course_id,sec_id,semester,year) IN (SELECT course_id,sec_id,semester,year FROM takes WHERE grade = 'A'));

-- E. Find all courses offered in the morning hours (i.e., courses ending before 13:00)

-- Some duplicates
SELECT * FROM course
    WHERE course_id IN (SELECT course_id FROM section
    WHERE time_slot_id in
(select DISTINCT (time_slot_id) from time_slot WHERE end_hr < 13));

-- With no duplicatess
SELECT * FROM course
    WHERE course_id NOT IN (SELECT course_id FROM section
    WHERE time_slot_id IN (select DISTINCT(time_slot_id) from time_slot WHERE end_hr >= 13));