create table SinhVien (
	Roll_No nvarchar(12) primary key,
	Full_Name nvarchar(50),
	Age int,
	Address nvarchar(200),
	Email nvarchar(100),
	Phone_Number nvarchar(20),
	Gender nvarchar(10),
)
go

create table MonHoc (
	Ma_Mon_Hoc int primary key identity(1,1),
	Ten_Mon_Hoc nvarchar(50)
)
go

create table DiemThi (
	Diem int ,
	Roll_No nvarchar(12),
	Ma_Mon_Hoc int identity(1,1)
)
go

create table LopHoc (
	Ma_Lop_Hoc int primary key identity(1,1),
	Ten_Lop_Hoc nvarchar(10),
	Roll_No nvarchar(12)
)
go

create table PhongHoc (
	Ten_Phong_Hoc nvarchar(20),
	Ma_Phong_Hoc int primary key identity(1,1),
	So_Ban_Hoc int,
	So_Ghe_Hoc int,
	Dia_Chi_Lop_Hoc nvarchar(20)
)
go

insert into SinhVien(Roll_No, Full_Name, Age, Address, Email, Phone_Number, Gender)
values
	('R001','Nguyen A',18,'Ha Noi','a@gmail.com','+84123432532','Nam'),
	('R002','Nguyen B',19,'Nam Dinh','b@gmail.com','+84123858392','Nu'),
	('R003','Nguyen C',20,'Hung Yen','c@gmail.com','+84123433642','Nam'),
	('R004','Nguyen D',21,'Thanh Hoa','d@gmail.com','+84123464232','Nam'),
	('R005','Nguyen E',22,'Thai Nguyen','e@gmail.com','+84123432987','Nu')

insert into MonHoc(Ten_Mon_Hoc)
values
	('Triet hoc'),
	('Kinh Te Chinh Tri'),
	('Chu Nghia Xa Hoi Khoa Hoc'),
	('Lich Su Dang'),
	('Xac Suat Thong Ke')
	
insert into DiemThi(Diem, Roll_No)
values
	('6','R001'),
	('7','R002'),
	('8','R003'),
	('9','R004'),
	('10','R005')

insert into LopHoc(Ten_Lop_Hoc, Roll_No)
values
	('A','R001'),
	('B','R002'),
	('C','R003'),
	('D','R004'),
	('E','R005')

insert into PhongHoc(Ten_Phong_Hoc, So_Ban_Hoc, So_Ghe_Hoc, Dia_Chi_Lop_Hoc)
values
	('class1',7,20,'tang 5'),
	('class1',2,3,'tang 5'),
	('class1',10,30,'tang 5'),
	('class1',5,20,'tang 5'),
	('class1',6,18,'tang 5')

select * from SinhVien 
select * from MonHoc 
select * from DiemThi 
select * from LopHoc 
select * from PhongHoc 

select * from PhongHoc 
where So_Ban_Hoc>5 and So_Ghe_Hoc>5

select * from PhongHoc 
where So_Ban_Hoc between 5 and 20 and So_Ghe_Hoc between 5 and 20
