--dim_students
INSERT INTO dim_Students (name, last_Name, phone_number, passport_id, id, email, start_date, end_date)
SELECT TOP 100000 p1.name, p2.last_name, p1.phone_number, p2.passport_id
ABS(CHECKSUM(NEWID()))%100000 + 1 as id,
CONCAT(LEFT(p1.NameStudent, 1), p2.LastNameStudent, '@gmail.com'),
DATEADD(DAY,ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, '2022-01-01', '2022-03-01'), '2022-01-01') as start_date,
DATEADD(DAY,ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, '2022-03-31', '2022-05-31'), '2022-03-31') as end_date
FROM dbo.Students1 p1
CROSS JOIN
dbo.Students2 p2 

alter table dim_students add Date_of_Birth date;
update dim_students 
set Date_of_Birth=DATEADD(DAY, ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, '1986-01-01', '2004-12-31'), '1986-01-01')

alter table dim_students add gender nvarchar(45);
update dim_students 
set gender='Male' where id between 1 and 64152
update dim_students 
set gender='Female' where id between 64153 and 100000

--dim_teachers
Insert Into Dim_Teachers (id, name, last_name, dob, Major)
Select Top 100000 t1.NameStudent, t2.LastNameStudent, t1.DateOfBirth, t2.speciality
FLOOR(RAND(CHECKSUM(NEWID()))*(100000)+1)
From dbo.Teachers1 t1
cross join
dbo.Teachers2 t2

--dim_lessons 
INSERT INTO dim_lessons(Name, description, course_name, id)
SELECT TOP 1000 NameLesson, description, NameCourse,
FLOOR(RAND(CHECKSUM(NEWID()))*(1000)+1) as id
FROM dbo.Lessons

update dim_lessons
set course_name='FrontEnd developer' where id between 1 and 135
update dim_lessons
set course_name='Python developer' where id between 136 and 283
update dim_lessons
set course_name='Java developer' where id between 284 and 376
update dim_lessons
set course_name='C#(.NET) developer' where id between 377 and 459
update dim_lessons
set course_name='Business analyst' where id between 460 and 548
update dim_lessons
set course_name='UX/UI designer' where id between 549 and 589
update dim_lessons
set course_name='QA' where id between 589 and 678
update dim_lessons
set course_name='Ruby developer' where id between 679 and 735
update dim_lessons
set course_name='Project IT Manager' where id between 736 and 763
update dim_lessons
set course_name='BI developer' where id between 764 and 835
update dim_lessons
set course_name='WEB developer' where id between 836 and 856
update dim_lessons
set course_name='GOdeveloper' where id between 857 and 935
update dim_lessons
set course_name='DevOps' where id between 936 and 962
update dim_lessons
set course_name='Data Scientist' where id between 963 and 1000

--fct_timetable
INSERT INTO fct_timetable (student_id, date_time, lesson_id, room, teacher_id)
SELECT TOP 1000000 std.id,
DATEADD(hh, FLOOR(RAND(CHECKSUM(NEWID())) * (19 - 9 + 1)) + 9, DATEADD(DAY, ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, CONVERT(DATETIME, std.start_date), CONVERT(DATETIME, std.end_date)), CONVERT(DATETIME, std.start_date))), 
FLOOR(RAND(CHECKSUM(NEWID()))*(1000)+1),
concat('Classroom ', FLOOR(RAND(CHECKSUM(NEWID())) * (20)) + 1), 
FLOOR(RAND(CHECKSUM(NEWID()))*(100000)+1)
FROM dim_students std
CROSS JOIN 
(SELECT TOP 100 *
FROM dim_students
ORDER BY NEWID()) std2

--fct_attendance_and_marks
INSERT INTO fct_attendance_and_marks (student_id, lesson_id, date, attendance, mark, id)
SELECT TOP 1000000 ttb.student_id, ttb.lesson_id,
CONVERT(DATE, ttb.date_time), 
FLOOR(RAND(CHECKSUM(NEWID()))*2), 
FLOOR(RAND(CHECKSUM(NEWID())) * (10)) + 1,
FLOOR(RAND(CHECKSUM(NEWID()))*(1000000)+1)
FROM fct_timetable ttb







