-- Tao bang
create table HangHoa (
	Id int primary key identity(1,1),
	TenMatHang nvarchar(50),
	NhaSanXuat nvarchar(50),
	XuatXu nvarchar(50),
	GiaNhap money,
	GiaBan money,
	NgaySanXuat date
)
go

create table BanHang (
	Id int primary key identity(1,1),
	Id_HangHoa int references HangHoa(Id),
	ChuThich nvarchar(100),
	NgayBan date,
	SoLuong int, 
	GiaBan money
)
go

-- Du lieu
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


insert into BanHang (Id_HangHoa, ChuThich, NgayBan, SoLuong, GiaBan)
values
(2, '', '2022-12-24', 2, 7000000),
(1, '', '2021-07-24', 1, 40000000),
(3, '', '2022-01-24', 5, 30000000),
(10, '', '2021-07-24', 1, 4000000),
(5, '', '2021-08-21', 2, 3200000),
(7, '', '2021-12-12', 4, 7000000),
(8, '', '2021-05-12', 2, 14990000),
(3, '', '2022-02-28', 6, 10990000),
(2, '', '2022-12-30', 1, 11980000),
(9, '', '2021-07-24', 10, 36980000)

select * from HangHoa
select * from BanHang

-- View
create view View_Don_Hang_Da_Ban
as
select HangHoa.Id, HangHoa.TenMatHang, BanHang.NgayBan, BanHang.SoLuong
from HangHoa left join BanHang on BanHang.Id_HangHoa = HangHoa.Id

select * from View_Don_Hang_Da_Ban

-- Proc xuat xu
create proc Proc_Xuat_Xu
			@XuatXu nvarchar(50)
as
begin
	select HangHoa.Id, HangHoa.TenMatHang, HangHoa.XuatXu, BanHang.NgayBan, BanHang.SoLuong
	from HangHoa left join BanHang on BanHang.Id_HangHoa = HangHoa.Id
	where HangHoa.XuatXu = @XuatXu
	order by HangHoa.Id asc
end

exec Proc_Xuat_Xu 'Trung Quoc'
exec Proc_Xuat_Xu 'Han Quoc'
exec Proc_Xuat_Xu 'My'

-- Proc Tong gia
create proc Proc_Hang_Da_Ban
			@ProdructId int,
			@Total int output
as 
begin
	select HangHoa.TenMatHang, HangHoa.XuatXu, sum(BanHang.GiaBan * BanHang.SoLuong) 'Total'
	from HangHoa left join BanHang on BanHang.Id_HangHoa = HangHoa.Id
	where HangHoa.Id = @ProdructId
	group by HangHoa.TenMatHang, HangHoa.XuatXu

	select @Total = sum(BanHang.GiaBan * BanHang.SoLuong)
	from HangHoa left join BanHang on BanHang.Id_HangHoa = HangHoa.Id
	where HangHoa.Id = @ProdructId
end

declare @total int
exec Proc_Hang_Da_Ban 1, @total = @Total output
print N'Tong tien : ' + convert(nvarchar, @total)
