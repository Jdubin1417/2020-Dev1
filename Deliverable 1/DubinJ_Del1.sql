/* 
Programmer's Name: Justin Dubin
Course: CSCI 2020 Section Number: 940 
Creation Date: 02/16/2022 Date of Last Modification: 02/20/2022
E-mail Address: dubinj@etsu.edu 
Purpose - 
Project Deliverable 1
Identifier dictionary - 
Not Applicable 
 
Notes and Assumptions ? 
*/
-----------------------------------------------------------------
--4.1
UPDATE student
SET last_name = 'Pathak-Smith'
WHERE student_id = 1182;

--4.2
INSERT INTO student_exam (student_id, exam_id, test_date, score)
VALUES ('140', '0', '15-JAN-22', '924');

INSERT INTO student_exam (student_id, exam_id, test_date, score)
VALUES ('464', '0', '15-JAN-22', '1232');

INSERT INTO student_exam (student_id, exam_id, test_date, score)
VALUES ('2844', '0', '15-JAN-22', '1015');

--4.3
DELETE FROM STUDENT_exam 
WHERE student_id = 10086;

DELETE FROM STUDENT_GUARDIAN 
WHERE student_id = 10086;

DELETE FROM SCHOOL_ATTEND 
WHERE student_id = 10086;

DELETE FROM SCHOOL_APPLY 
WHERE student_id = 10086;

DELETE FROM volunteer_work 
WHERE student_id = 10086;

DELETE FROM activity 
WHERE student_id = 10086;

DELETE FROM student
WHERE student_id = 10086;

--4.4
UPDATE school_attend
SET end_date = '20-DEC-2020'
WHERE student_ID = '1007'
and school_id = '12106';

UPDATE school_attend
SET end_reason = 'Transfer'
WHERE student_ID = '1007'
and school_id = '12106';

INSERT INTO school_attend (student_id, school_id, enroll_date)
VALUES ('1007', '12460', '15-JAN-21');

--4.5
INSERT INTO guardian (guardian_id, first_name, last_name, STREET_ADDR, city, state, zip, phone)
VALUES ('22583', 'Margaret', 'Yuters', '1382 N. 5th Ave', 'Sarasota', 'FL', '34234', '9413411961');

DELETE FROM student_guardian 
WHERE guardian_id = 9914
and student_id = 8992;

INSERT INTO student_guardian (student_id, guardian_id, relation)
VALUES ('8992', '22583', 'Legal Guardian');

--------------------------------------------------------------------------------------------------------

--5.1 Using distinct assuming we are counting multiple attempts for students only once
SELECT e.name "Exam Name", AVG (s.score) "Average Score", COUNT(distinct s.student_id) "Students that have attempted to take exam"
FROM student_exam s
INNER JOIN exam e
ON s.exam_id = e.exam_id
WHERE test_date > '01-JAN-2008'
GROUP BY e.name
ORDER BY "Students that have attempted to take exam" DESC;

--5.2
SELECT s.last_name || ', ' || s.first_name "Student Name", COUNT(decision) "Count"
FROM student s
INNER JOIN school_apply a
ON s.student_id = a.student_id
WHERE s.grade_level = 8 
    and decision = 'accepted'
group by s.last_name, s.first_name
HAVING COUNT(decision) < 3;

--5.3
SELECT s.name "College Name", COUNT(v.volunteer_work_id) "Volunteer Assignments Completed"
FROM volunteer_work v
INNER JOIN school_attend a
ON a.student_id = v.student_id
INNER JOIN school s
ON s.school_id = a.school_id
where type = 'C'
GROUP BY s.name
HAVING COUNT(v.volunteer_work_id) > 9
ORDER BY "Volunteer Assignments Completed" DESC;

--5.4
SELECT s.first_name || ' ' || s.last_name "Student Name", LOWER(v.description) "Description", (v.end_date - v.start_date) "Days Worked on Project"
from student s
INNER JOIN volunteer_work v
ON s.student_id = v.student_id
WHERE s.grade_level = 5
GROUP BY s.first_name || ' ' || s.last_name, LOWER(v.description), (v.end_date - v.start_date)
HAVING(v.end_date - v.start_date) > 29 and (v.end_date - v.start_date) < 91
ORDER BY "Days Worked on Project" DESC;

--5.5
SELECT s.last_name || ', ' || s.first_name "student_name", g.last_name || ', ' || g.first_name "guardian_name"
FROM student s
INNER JOIN student_guardian t
ON s.student_id = t.student_id
INNER JOIN guardian g
ON t.guardian_id = g.guardian_id
WHERE t.relation = 'Foster Father'
OR t.relation = 'Foster Mother'
AND s.city != g.city
ORDER BY "student_name" ASC;

--5.6
SELECT s.student_id "Student ID", s.last_name || ', ' || s.first_name "Student Name", AVG(e.score) "Average SAT Score"
FROM student s
INNER JOIN student_exam e
ON s.student_id = e.student_id
WHERE e.exam_id = 1
GROUP BY s.student_id, s.last_name || ', ' || s.first_name
HAVING COUNT(e.student_id) > 3
ORDER BY "Average SAT Score" DESC;

--5.7
SELECT s.name "College Name", s.state "State", COUNT(p.decision) "Acceptances after December, 2009"
FROM school s
INNER JOIN school_attend a
ON s.school_id = a.school_id 
INNER JOIN school_apply p
ON s.school_id = p.school_id 
WHERE type = 'C' 
and p.decision = 'accepted'
GROUP BY s.name, s.state, a.enroll_date
HAVING a.enroll_date > '01-DEC-09'
ORDER BY "Acceptances after December, 2009" DESC;