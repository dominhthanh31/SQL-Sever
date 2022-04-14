create table Class (
	ClassId int primary key not null,
	ClassCode nvarchar(50)
)
go

create table Student (
	StudentId int primary key not null,
	StudentName nvarchar(50),
	BrithDate date,
	ClassId int
)
go

create table _Subject (
	SubjectId int primary key not null,
	SubjectName nvarchar(100),
	SessionCount int
)
go

create table Result (
	StudentId int not null,
	SubjectId int not null,
	Mark int
)
go

alter table Result 
alter column Mark float
go

insert into Class (ClassId, ClassCode)
values
('1','C1106KV'),
('2','C1108GV'),
('3','C1108IV'),
('4','C1108HV'),
('5','C1109GV')

insert into Student (StudentId, StudentName, BrithDate, ClassId)
values
('1','Phạm Tuấn Anh','1993-08-05','1'),
('2','Phan Văn Huy','1992-06-10','1'),
('3','Nguyễn Hoàng Minh','1992-09-07','2'),
('4','Trần Tuấn Tú','1993-10-10','2'),
('5','Đỗ Anh Tài','1992-06-06','3')

select * from Student
go

insert into _Subject (SubjectId, SubjectName, SessionCount)
values
('1','C Programming','22'),
('2','Web Design','18'),
('3','Database Management','23')

insert into Result (StudentId, SubjectId, Mark)
values
('1','1','8'),
('1','2','7'),
('2','3','5'),
('3','2','6'),
('4','3','9'),
('5','2','8')

alter table Student 
add constraint fk_Student_ClassId foreign key (ClassId) references Class (ClassId)

alter table Result 
add constraint fk_Result_StudentId foreign key (StudentId) references Student (StudentId)

alter table Result 
add constraint fk_Result_SubjectId foreign key (SubjectId) references _Subject (SubjectId)

alter table _Subject add constraint pk_Suject_SubjectId primary key (SubjectId)

alter table Class add constraint pk_Class_ClassId primary key (ClassId)


select Student.StudentId 'Ma Sinh Vien', Student.StudentName 'Ten Sinh Vien', Student.BrithDate 'Ngay Sinh' from Student 
where BrithDate between '1992-10-10' and '1993-10-10'
go

select Class.ClassId, Class.ClassCode ,count(Student.StudentId) SiSoLop
from Class left join Student on Class.ClassId = Student.ClassId
group by Class.ClassCode, Class. ClassId

select Student.StudentId, Student.StudentName , sum(Result.Mark)
from Result left join Student on Student.StudentId = Result.StudentId
group by Student.StudentId, Student.StudentName
having sum(Result.Mark) > 10