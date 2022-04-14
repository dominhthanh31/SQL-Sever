-- 1. Tao data
--create database StudentManagementSystem
--use StudentManagementSystem

-- 2. Tao bang
create table Class(
	ClassId int not null,
	ClassCode nvarchar(50)
)
go

create table Student(
	StudentId int not null,
	StudentName nvarchar(50),
	BirthDate datetime,
	ClassId int,
)
go

create table Subject_(
	SubjectId int not null,
	SubjectName nvarchar(100),
	SessionCount int
)
go

create table Result(
	StudentId int not null,
	SubjectId int not null,
	Mark int
)
go

-- 3. Index
create index NCL_Student_StudentName
on Student (StudentName)

alter table Result
alter column Mark float

-- 4. Constraint
alter table Class 
add constraint PK_Class primary key (ClassId)
alter table Student 
add constraint PK_Student primary key (StudentId)
alter table Subject_ 
add constraint PK_Subject primary key (SubjectId)
alter table Result 
add constraint PK_Result primary key (StudentId, SubjectId)

alter table Student
add constraint FK_Student_Class foreign key (ClassId) references Class(ClassId)
alter table Result
add constraint FK_Result_Student foreign key (StudentId) references Student(StudentId)
alter table Result
add constraint FK_Result_Subject foreign key (SubjectId) references Subject_(SubjectId)

alter table Subject_
add constraint CK_Subject_SessionCount check (SessionCount > 0)

-- 5. Inserting data
insert into Class(ClassId, ClassCode)
values
(1, 'C1106KV'),
(2, 'C1108GV'),
(3, 'C1108IV'),
(4, 'C1108HV'),
(5, 'C1109GV')

insert into Student(StudentId, StudentName, BirthDate, ClassId)
values
(1, 'Pham Tuan Anh', '1993-08-05', 1),
(2, 'Pham Van Huy', '1992-06-10', 1),
(3, 'Nguyen Hoang Minh', '1992-09-07', 2),
(4, 'Tran Tuan Tu', '1993-10-10', 2),
(5, 'Do Anh Tai', '1992-06-06', 3)

insert into Subject_(SubjectId, SubjectName, SessionCount)
values
(1, 'C Programming', 22),
(2, 'Web Design', 18),
(3, 'Database Management', 23)

insert into Result(StudentId, SubjectId, Mark)
values
(1, 1, 8),
(1, 2, 7),
(2, 3, 5),
(3, 2, 6),
(4, 3, 9),
(5, 2, 8)

-- 6. Query
select Student.StudentId 'Mã sinh viên', Student.StudentName 'Tên sinh viên', Student.BirthDate 'Ngày sinh'
from Student
where BirthDate between '1992-10-10' and '1993-10-10'

select Class.ClassId 'Mã lớp', Class.ClassCode 'Tên lớp', count(Student.ClassId) 'Sĩ số lớp'
from Class left join Student on Student.ClassId = Class.ClassId
group by Class.ClassId, Class.ClassCode

select Student.StudentId 'Mã sinh viên', Student.StudentName 'Tên sinh viên', sum(Result.Mark) 'Tổng điểm'
from Student, Result
where Student.StudentId = Result.StudentId
group by Student.StudentId, Student.StudentName
having sum(Result.Mark) > 10

-- 7. Views
create view view_StudentSubjectMark
as
select top(3) Student.StudentId, Student.StudentName, Subject_.SubjectName, Result.Mark
from Student left join Result on Student.StudentId = Result.StudentId
		left join Subject_ on Subject_.SubjectId = Result.SubjectId
order by Result.Mark desc

select * from view_StudentSubjectMark

-- 8. Procedures
create proc up_IncreaseMark
	@SubjectId int
as
begin
	update Result set Mark = Mark + 1
	where SubjectId = @SubjectId
end

select * from Result
exec up_IncreaseMark 2
select * from Result

-- 9. Trigger
create trigger TG_Result_Insert on Result
for insert
as
begin
	if (select count(*) from inserted where Mark < 0 ) > 0
	begin
		print 'Cannot insert mark < 0'
		rollback transaction 
	end
end

insert into Result (StudentId,SubjectId,Mark)
values
(1,3,-2)


create trigger TG_Subject_Update on Subject
for UPDATE
as 
begin
	if UPDATE(SubjectName)
	begin
		print 'You don’t update this column'
		rollback transaction 
	end
end

UPDATE Subject set SubjectName = 'abc' where SubjectName='Web Design'