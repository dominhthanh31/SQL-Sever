create table HangHoa (
	Id int primary key identity(1,1),
	TenMatHang nvarchar(50),
	NhaSanXuat nvarchar(50),
	XuatXu nvarchar(50),
	GiaNhap int,
	GiaBan int,
	NgaySanXuat date
)
go

create table BanHang (
	Id int primary key identity(1,1),
	Id_HangHoa int,
	ChuThich nvarchar(100),
	NgayBan date,
	SoLuong int
)
go

alter table HangHoa
alter column GiaNhap money
go

alter table HangHoa
alter column GiaBan money
go

alter table BanHang
add constraint fk_BanHang_Id foreign key (Id_HangHoa) references HangHoa (Id)

insert into HangHoa (TenMatHang, NhaSanXuat, XuatXu, GiaNhap, GiaBan, NgaySanXuat)
values
('Oppo F11', 'OPPO', 'Trung Quoc', 5000000, 7000000, '2021-05-19'),
('Macbook Pro', 'Apple', 'My', 34000000, 40000000, '2022-12-23'),
('Iphone 13', 'Apple', 'My', 24000000, 30000000, '2021-12-28'),
('Samsung M12', 'Samsung', 'Han Quoc', 3000000, 4000000, '2021-05-09'),
('AirPods', 'Apple', 'My', 3000000, 3200000, '2021-04-04'),
('Oppo A74', 'OPPO', 'Trung Quoc', 6190000, 7000000, '2022-01-24'),
('Tivi LG', 'LG', 'Han Quoc', 1339000, 14990000, '2020-10-09'),
('Apple Watch', 'Apple', 'My', 9690000, 10990000, '2020-03-31'),
('Samsung Galaxy Tab S7', 'Samsung', 'Han Quoc', 9890000, 11980000, '2020-05-27'),
('Samsung Galaxy Z Fold3', 'Samsung', 'Han Quoc', 34490000, 36980000, '2020-08-23')


insert into BanHang (Id_HangHoa, ChuThich, NgayBan, SoLuong)
values
(2, '', '2022-12-24', 2),
(1, '', '2021-07-24', 1),
(3, '', '2022-01-24', 5),
(10, '', '2021-07-24', 1),
(5, '', '2021-08-21', 2),
(7, '', '2021-12-12', 4),
(8, '', '2021-05-12', 2),
(3, '', '2022-02-28', 6),
(2, '', '2022-12-30', 1),
(9, '', '2021-07-24', 10)

select * from HangHoa
select * from BanHang

select HangHoa.Id, HangHoa.TenMatHang, BanHang.NgayBan, BanHang.SoLuong
from HangHoa left join BanHang on BanHang.Id_HangHoa = HangHoa.Id
order by HangHoa.Id
go

select HangHoa.Id, HangHoa.TenMatHang, HangHoa.XuatXu, BanHang.NgayBan, BanHang.SoLuong
from HangHoa left join BanHang on BanHang.Id_HangHoa = HangHoa.Id
where HangHoa.XuatXu = 'Viet Nam'
group by HangHoa.Id, HangHoa.TenMatHang, HangHoa.XuatXu, BanHang.NgayBan, BanHang.SoLuong
go

select HangHoa.Id, HangHoa.TenMatHang, HangHoa.GiaBan, BanHang.SoLuong ,(HangHoa.GiaBan * count(BanHang.SoLuong)) 'Tong'
from HangHoa left join BanHang on BanHang.Id_HangHoa = HangHoa.Id
group by HangHoa.Id, HangHoa.TenMatHang, HangHoa.GiaBan, BanHang.SoLuong
order by HangHoa.Id
go
