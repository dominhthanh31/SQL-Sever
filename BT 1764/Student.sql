create database bt1764
use bt1764

--Create table
create table student (
	rollno int primary key identity(1,1),
	fullname nvarchar(50) not null,
	dob date,
	email nvarchar(50),
	phoneNumber nvarchar(25) not null,
	gender nvarchar(10)
)

create table class(
	id int primary key identity(1,1),
	name_class nvarchar(50)
)

create table subject(
	id int primary key identity(1,1),
	namesubject nvarchar(50),
)

create table mark(
	mark int,
	id_rollno int references student(rollno),
	id_subject int references subject(id)
)

create table classroom(
	id int primary key identity(1,1),
	name nvarchar(50),
	numTable int,
	numChair int,
	address nvarchar(250)
)

create table managerClass (
	id int primary key identity(1,1),
	id_class int references class(id),
	id_rollno int references student(rollno),
	id_subject int references subject(id)
)

create table bookStudy (
	id_class int references class(id),
	study_in datetime,
	study_out datetime,
	id_classroom int references classroom(id)
	CONSTRAINT PK_book PRIMARY KEY (id_class,id_classroom)
)

insert into student (fullname,dob,email,phoneNumber,gender)
values
('Nguyen Huu Hieu','1990-09-20','hieuuct209@gmail.com','0389945947','Nam'),
('Nguyen Van A','1991-09-20','hieuuct209@gmail.com','0389945947','Nam'),
('Nguyen Van B','1992-09-20','hieuuct209@gmail.com','0389945947','Nu'),
('Nguyen Van C','1993-09-20','hieuuct209@gmail.com','0389945947','Nam'),
('Nguyen Van D','1994-09-20','hieuuct209@gmail.com','0389945947','Nu'),
('Nguyen Van E','1995-09-20','hieuuct209@gmail.com','0389945947','Nam')
select * from student

insert into class(name_class)
values
('T2008A'),
('Cau Ham K49'),
('T2009B'),
('T2010E'),
('T2007M')
select * from class

insert into subject(namesubject)
values
('Javascript'),
('SQL Server'),
('PHP'),
('C# nang cao'),
('Suc ben vat lieu')
select * from subject

insert into mark(mark, id_rollno, id_subject)
values
(10,2,3),
(8,2,1),
(6,1,3),
(5,4,2),
(7,5,4),
(9,2,1),
(8,5,2)

select * from mark

insert into classroom(name,numTable,numChair,address)
values
('P202A2',20,20,'Tang 2 nha A2'),
('P302A2',20,20,'Tang 3 nha A2'),
('P402A3',30,30,'Tang 4 nha A3'),
('P202A1',210,210,'Tang 2 nha A1'),
('P202A4',50,50,'Tang 2 nha A4')

select * from classroom

insert into managerClass (id_class,id_rollno,id_subject)
values
(2,1,3),
(2,1,4),
(3,2,2),
(3,3,2),
(1,2,2),
(1,2,3),
(1,3,3)
select * from managerClass


insert into bookStudy (id_class,study_in,study_out,id_classroom)
values
(1,'2020-10-22 12:30:45', '2020-10-22 14:00:00', 2),
(2,'2020-10-22 12:30:45', '2020-10-22 14:00:00', 1),
(3,'2020-10-22 12:30:45', '2020-10-22 14:00:00', 3),
(4,'2020-10-22 12:30:45', '2020-10-22 14:00:00', 2),
(4,'2020-10-22 12:30:45', '2020-10-22 14:00:00', 4),
(5,'2020-10-22 12:30:45', '2020-10-22 14:00:00', 1)
select * from bookStudy
--Hien thi class co chu 'K'
select * from class
where class.name_class like '%K%'

--Hien thi (RollNo, tên, và điểm thi) cua SV co ten 'Nguyen Van A'
select student.rollno 'Ma Sinh Vien', student.fullname 'Ten SV', 
		mark.mark 'Diem thi', subject.namesubject 'Ten Mon Hoc'
from student, mark,subject
where student.rollno = mark.id_rollno and subject.id = mark.id_subject 
		and student.fullname = 'Nguyen Van A'

--- Hiển thị thông tin điểm thi (RollNo, tên, điểm thi) của tất cả sinh viên

select student.rollno, student.fullname, mark.mark
from student,mark
where student.rollno = mark.id_rollno

--- Hiển thị thông tin điểm thì (RollNo, tên, điểm thi, môn học) của tất cả sinh viên
create proc show_fullname_mark_subject
	@fullname nvarchar(50)
as
begin
	select student.rollno 'Ma Sinh Vien', student.fullname 'Ten SV', 
		mark.mark 'Diem thi', subject.namesubject 'Ten Mon Hoc'
from student, mark,subject
where student.rollno = mark.id_rollno and subject.id = mark.id_subject 
		and student.fullname = @fullname
end

exec show_fullname_mark_subject 'Nguyen Huu Hieu'
