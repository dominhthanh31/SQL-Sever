create table teacher (
create database BT1810

use BT1810

create table student (
	rollno nvarchar(20) primary key,
	name nvarchar(100),
	gender nvarchar(10),
	birthday date,
	que_quan nvarchar(100),
	email nvarchar(100),
	sdt int
)
go

create table teacher (
	ma_teacher nvarchar(20) primary key,
	name nvarchar(100),
	gender nvarchar(10),
	birthday date
)
go

create table subject (
	ma_monhoc nvarchar(20) primary key,
	name_subject nvarchar(50),
	tongsobuoi int
)
go

create table class (
	ma_class nvarchar(20) primary key,
	name_class nvarchar(20),
	note nvarchar(500)
)
go

create table classMember (
	rollno nvarchar(20) primary key references student(rollno),
	classno nvarchar(20) references class(ma_class),
	joinedDate date,
	outedDate date
)
go

create table schedule (
	id int primary key identity (1,1),
	ma_teacher nvarchar(20),
	ma_monhoc nvarchar(20),
	ma_class nvarchar(20),
	indate date,
	outdate date
)
go

create table attendance (
	scheduleId int references schedule(id),
	rollno nvarchar(20),
	ngaydiemdanh date,
	ddlan_1 nvarchar(20),
	ddlan_2 nvarchar(20),
	note nvarchar(500)
)
go

insert into student(rollno, name, gender, birthday, que_quan, email, sdt)
values
('MS01', 'Tran Van D', 'Nam', '1998-5-10', 'Nam Dinh', 'a@gmail.com', 0585076514),
('MS02', 'Tran Van A', 'Nam', '1991-6-11', 'Ha Noi', 'b@gmail.com', 0585076515),
('MS03', 'Tran Van B', 'Nu', '2000-12-1', 'Ha Noi', 'c@gmail.com', 0585076516),
('MS04', 'Tran Van C', 'Nu', '1998-1-19', 'Hai Phong', 'd@gmail.com', 0585076517),
('MS05', 'Tran Van E', 'Nam', '1998-12-1', 'Sai Gon', 'e@gmail.com', 0585076518)

insert into teacher(ma_teacher, name, gender, birthday)
values
('GV01', 'Tran Van A', 'Nam', '1989-06-30'),
('GV02', 'Tran Thi A', 'Nu', '1989-05-20'),
('GV03', 'Tran Van B', 'Nu', '1990-12-30'),
('GV04', 'Tran Van C', 'Nam', '1989-03-10'),
('GV05', 'Tran Van D', 'Nu', '1989-11-11')

insert into subject(ma_monhoc, name_subject, tongsobuoi)
values
('MH01', 'Lap Trinh C', 10),
('MH02', 'HTML/CSS/JS', 11),
('MH03', 'SQL Sever', 12),
('MH04', 'Boostrap', 13),
('MH05', 'Jquery', 10)

insert into class(ma_class, name_class, note)
values
('LH01', 'T2008A', ''),
('LH02', 'T2005A', ''),
('LH03', 'T2006A', ''),
('LH04', 'T2007A', ''),
('LH05', 'T2009A', '')

insert into classMember(rollno, classno, joinedDate, outedDate)
values
('MS01', 'LH01', '2020-01-12', '2020-02-12'),
('MS02', 'LH02', '2020-02-12', '2020-03-12'),
('MS03', 'LH03', '2020-04-12', '2020-05-12'),
('MS04', 'LH04', '2020-02-12', '2020-03-12'),
('MS05', 'LH05', '2020-03-12', '2020-04-12')

insert into schedule(ma_teacher, ma_monhoc, ma_class, indate, outdate)
values
('GV01', 'MH01', 'LH01', '2018-07-01', '2018-07-30'),
('GV02', 'MH02', 'LH02', '2018-07-01', '2018-07-30'),
('GV03', 'MH03', 'LH03', '2018-07-01', '2018-07-30'),
('GV04', 'MH04', 'LH04', '2018-07-01', '2018-07-30'),
('GV05', 'MH05', 'LH05', '2018-07-01', '2018-07-30')

insert into attendance(scheduleId, rollno, ngaydiemdanh, ddlan_1, ddlan_2, note)
values
(1, 'MS01', '2020-12-09', 'Co', 'Co', ''),
(2, 'MS02', '2020-12-09', 'Khong', 'Co', ''),
(3, 'MS03', '2020-12-09', 'Co', 'Co', ''),
(4, 'MS04', '2020-12-09', 'Co', 'Khong', ''),
(5, 'MS05', '2020-12-09', 'Co', 'Co', '')

select * from student
select * from teacher
select * from subject
select * from class
select * from classMember
select * from schedule
select * from attendance

create proc thong_tin_hoc_vien
 @class  nvarchar(50)
as
begin
	select class.name_class, classMember.classno, student.name, student.gender, student.birthday
	from classMember,studentc,class class 
	where classMember.rollno = student.rollno and classMember.classno = class.ma_class
end

exec thong_tin_hoc_vien 


alter table attendance
add constraint LK_at_st foreign key (rollno) references student(rollno)

alter table schedule
add constraint LK_sch_class foreign key (ma_class) references class(ma_class)

alter table schedule
add constraint LK_sch_sb foreign key (ma_monhoc) references subject(ma_monhoc)

create proc danh_sach_diem_danh
	@class nvarchar(20), @subject nvarchar(50)
as
begin
	select student.name, attendance.*, class.name_class, subject.name_subject
	from student, attendance, class, schedule, subject
	where attendance.rollno = student.rollno and schedule.ma_class = class.ma_class and schedule.id = attendance.scheduleId
	and schedule.ma_monhoc = subject.ma_monhoc and class.ma_class = @class and subject.name_subject = @subject
end

exec danh_sach_diem_danh 'LH01', 'Jquery'

create trigger detele_su_lieu on student
instead of delete
as
begin
	delete from classMember where rollno in (select rollno from deleted)
	delete from attendance where rollno in (select rollno from deleted)
	delete from student where rollno in (select rollno from deleted)
end

delete student where rollno = 'MS01'

select * from student