create table BaiDoXe(
	TenBai nvarchar(50),
	MaBai int primary key,
	DiaChi nvarchar(100)
)

create table ThongTinGui(
	TenXe nvarchar(50),
	BienSoXe nvarchar(50) primary key,
	MaBai int,
	NgayGui datetime,
	NgayLay datetime,
	ChiPhi money,
	IdChuSoHuu int
)

create table ChuSoHuu(
	IdChuSoHuu int primary key,
	Ten nvarchar(100),
	SoCmtnd nvarchar(20) unique,
	DiaChi nvarchar(100)
)

alter table ThongTinGui 
add foreign key (MaBai) references BaiDoXe(MaBai)

alter table ThongTinGui 
add foreign key (IdChuSoHuu) references ChuSoHuu(IdChuSoHuu)

insert into BaiDoXe(MaBai,TenBai,DiaChi)
values 
(1, 'Vin1','Thanh Xuan'),
(2, 'Vin2','Bach Mai'),
(3, 'Vin3','Giai Phong')

insert into ChuSoHuu(IdChuSoHuu, Ten, SoCmtnd, DiaChi)
values
(1, 'Nam', '202631526', 'Thanh Xuan'),
(2, 'Long', '212631524', 'Giai Phong'),
(3, 'Nhan', '222631525', 'Bach Mai')

insert into ThongTinGui(TenXe, BienSoXe, MaBai, NgayGui, NgayLay, ChiPhi, IdChuSoHuu)
values
('Vinfast', 'AB1-123-868', 3, '2021-03-03', '2021-03-10', 70000, 2),
('Toyota', 'AB1-123-989', 1, '2021-03-06', '2021-03-10', 40000, 1),
('Toyota', 'AB1-123-999', 1, '2021-03-05', '2021-03-10', 50000, 1),
('Vinfast', 'AB1-123-888', 3, '2021-03-06', '2021-03-10', 40000, 2),
('Toyota', 'AB1-123-777', 2, '2021-03-01', '2021-03-10', 90000, 3)

select ChuSoHuu.SoCmtnd, ChuSoHuu.Ten, BaiDoXe.TenBai, ThongTinGui.BienSoXe
from ChuSoHuu, BaiDoXe, ThongTinGui
where ThongTinGui.IdChuSoHuu=ChuSoHuu.IdChuSoHuu and ThongTinGui.MaBai=BaiDoXe.MaBai

create proc proc_DemSoLuotGui
		@IDchusohuu int
as
begin 
	select ChuSoHuu.IdChuSoHuu, ChuSoHuu.Ten, Count(ThongTinGui.IdChuSoHuu)as SoLanGui
	from ChuSoHuu, ThongTinGui
	where ChuSoHuu.IdChuSoHuu=ThongTinGui.IdChuSoHuu and ChuSoHuu.IdChuSoHuu=@IDchusohuu
	Group by ChuSoHuu.IdChuSoHuu, ChuSoHuu.Ten
end

exec proc_DemSoLuotGui 1

create proc proc_ChiPhi
	@IDchusohuu int
as
begin
	select ChuSoHuu.IdChuSoHuu, ChuSoHuu.Ten, Count(ThongTinGui.IdChuSoHuu)as SoLanGui, Sum(ThongTinGui.ChiPhi) as TongChiPhi
	from ChuSoHuu, ThongTinGui
	where ChuSoHuu.IdChuSoHuu=ThongTinGui.IdChuSoHuu and  ChuSoHuu.IdChuSoHuu=@IDchusohuu
	Group by ChuSoHuu.IdChuSoHuu, ChuSoHuu.Ten
end

exec proc_ChiPhi 1

create proc proc_check
	@IDchusohuu int
as
begin
	select ChuSoHuu.SoCmtnd, ChuSoHuu.Ten, BaiDoXe.TenBai, ThongTinGui.BienSoXe
	from ChuSoHuu, BaiDoXe, ThongTinGui
	where ThongTinGui.IdChuSoHuu=ChuSoHuu.IdChuSoHuu and ThongTinGui.MaBai=BaiDoXe.MaBai and GETDATE() between ThongTinGui.NgayGui and ThongTinGui.NgayLay and ChuSoHuu.IdChuSoHuu=@IDchusohuu
end

exec proc_check 2


create proc proc_History
	@IDchusohuu int
as
begin
	select ChuSoHuu.Ten, ChuSoHuu.IdChuSoHuu, BaiDoXe.TenBai, ThongTinGui.BienSoXe
	from ChuSoHuu, BaiDoXe, ThongTinGui
	where ThongTinGui.IdChuSoHuu=ChuSoHuu.IdChuSoHuu and ThongTinGui.MaBai=BaiDoXe.MaBai and ChuSoHuu.IdChuSoHuu=@IDchusohuu
end

exec proc_History 2
