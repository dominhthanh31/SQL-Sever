create table Hotel (
	Id int primary key identity(1,1),
	Name_ nvarchar(50),
	Address_ nvarchar(100),
	Area float,
	Ower_Name nvarchar(50)
)
go

create table Room (
	Room_No int primary key identity(1,1),
	Id_Hotel int references Hotel (Id),
	Area float,
	Type_ nvarchar(20),
	Floor_ int
)
go

create table Book (
	Id int primary key identity(1,1),
	Room_No int references Room (Room_No),
	CheckIn datetime,
	CheckOut datetime,
	Number int,
	Price float
)
go

insert into Hotel (Name_, Address_, Area, Ower_Name)
values
('KS A', 'Ha Noi', 100, 'A'),
('KS B', 'Nam Dinh', 200, 'B')
go

insert into Room (Id_Hotel, Area, Type_, Floor_)
values
	('1', 30, 'Pro', '1'),
	('1', 60, 'Vip', '2'),
	('1', 60, 'Vip', '2'),
	('2', 30, 'Pro', '1'),
	('2', 20, 'Normal', '2')
go

insert into Book (Room_No, CheckIn, CheckOut, Number, Price)
values
	(1, '2022-01-02 08:00:00', '2022-01-05 08:00:00', 2, 2000000),
	(2, '2022-01-01 08:00:00', '2022-01-15 08:00:00', 4, 16000000),
	(3, '2022-01-02 08:00:00', '2022-01-10 08:00:00', 4, 20000000)
go

select Hotel.Name_ 'Tên Khách Sạn', Hotel.Address_ 'Địa Chỉ', Room.Room_No 'Mã Phòng', Room.Type_ 'Loại Phòng', Room.Floor_ 'Tầng', Room.Area 'Diện Tích Phòng'
from Hotel left join Room on Hotel.Id = Room.Id_Hotel
order by Room.Area asc
go

select Hotel.Name_ 'Tên Khách Sạn', Hotel.Address_ 'Địa Chỉ', Room.Room_No 'Mã Phòng', Room.Type_ 'Loại Phòng', Room.Floor_ 'Tầng', Room.Area 'Diện Tích Phòng'
from Hotel left join Room on Hotel.Id = Room.Id_Hotel
where Room.Area > 30
order by Room.Area asc
go

select Hotel.Name_ 'Tên Khách Sạn', Hotel.Address_ 'Địa Chỉ', count (Room.Room_No) 'Số Phòng'
from Hotel left join Room on Hotel.Id = Room.Id_Hotel
group by Hotel.Name_, Hotel.Address_
go

select Hotel.Name_ 'Tên Khách Sạn', Hotel.Address_ 'Địa Chỉ', count (Room.Room_No) 'Số Phòng'
from Hotel left join Room on Hotel.Id = Room.Id_Hotel
group by Hotel.Name_, Hotel.Address_
having count (Room.Room_No) > 5
go

select Hotel.Name_ 'Tên Khách Sạn', Hotel.Address_ 'Địa Chỉ', max(Room.Area) 'Phòng có diện tích lớn nhất'
from Hotel left join Room on Hotel.Id = Room.Id_Hotel
group by Hotel.Name_, Hotel.Address_
go

select Hotel.Name_ 'Tên Khách Sạn', Hotel.Address_ 'Địa Chỉ', min(Room.Area) 'Phòng có diện tích nhỏ nhất'
from Hotel left join Room on Hotel.Id = Room.Id_Hotel
group by Hotel.Name_, Hotel.Address_
go

select Hotel.Name_ 'Tên Khách Sạn', Hotel.Address_ 'Địa Chỉ', sum(Room.Area) 'Tổng diện tích các phòng'
from Hotel left join Room on Hotel.Id = Room.Id_Hotel
group by Hotel.Name_, Hotel.Address_
go

select Hotel.Name_ 'Tên Khách Sạn', Hotel.Address_ 'Địa Chỉ', avg(Room.Area) 'Diện tích phòng trung bình'
from Hotel left join Room on Hotel.Id = Room.Id_Hotel
group by Hotel.Name_, Hotel.Address_
go

select Hotel.Name_ 'Tên Khách Sạn', Hotel.Address_ 'Địa Chỉ', count(Room.Room_No) 'Khách sạn không có phòng'
from Hotel left join Room on Hotel.Id = Room.Id_Hotel
group by Hotel.Name_, Hotel.Address_
having count(Room.Room_No) = 0
go