-- tao bang HocVien--
create table HocVien(
	Id int primary key identity(1,1) not null,
	TenHocVien nvarchar(50),
	Diachi_HV nvarchar(200),
	HoTenBo nvarchar(50),
	HoTenMe nvarchar(50),
	SDT_Bo nvarchar(11),
	SDT_Me nvarchar(11),
	NgaySinh_HV datetime,
	GioiTinh_HV nvarchar(10),
	Id_DiaDiemDon int not null
)
go
-- tao bang ThongTinXeBus--
create table ThongTinXeBus(
	Id_Xe int primary key identity(1,1) not null,
	BienSoXe nvarchar(10),
	LoaiXe nvarchar(20),
	SoGheNgoi int,
	Id_TaiXe int not null,
)
go
-- tao bang TaiXe--
create table TaiXe(
	Id_TaiXe int primary key identity(1,1) not null,
	TenTaiXe nvarchar(50),
	SDT_TaiXe nvarchar(11),
	GioiTich_TX nvarchar(10),
	DiaChi_TX nvarchar(300),
)
go
-- tao bang Lo Trinh Xe Di--
create table LoTrinhXe(
	Id_Xe int not null,
	Id_DiaDiemDon int not null
	primary key( Id_Xe, Id_DiaDiemDon)
)
go
--tao bang DiaDiemDon--
create table DiaDiemDonXe(
	Id_DiaDiemDon int primary key identity(1,1) not null,
	DiaChi nvarchar(200)
)
go
-- tao Foreign key--
alter table HocVien
add constraint FK_HocVien_ID_DiaDiemDon foreign key (Id_DiaDiemDon) references DiaDiemDonXe (Id_DiaDiemDon)
go

alter table ThongTinXeBus
add constraint FK_ThongTinXeBus_ID foreign key (Id_TaiXe) references TaiXe(Id_TaiXe)
go

alter table LoTrinhXe
add constraint FK_LoTrinhXe_DiaDiemDon foreign key (Id_DiaDiemDon) references DiaDiemDonXe (Id_DiaDiemDon)
go

alter table LoTrinhXe
add constraint FK_LoTrinhXe_Xe foreign key (Id_Xe) references ThongTinXeBus (Id_Xe)
go
-- Nhap 5 ban ghi--
insert into DiaDiemDonXe(DiaChi)
values
('123 Tran Dai Nghia'),
('135 Tran Dai Nghia'),
('353 Doi Can'),
('123 Doi Can'),
('123 Tran Nhan Tong')
go

insert into TaiXe(TenTaiXe,SDT_TaiXe,GioiTich_TX,DiaChi_TX)
values
('Tran Van A','012345678','Nam','123 O dau do'),
('Tran Van B','012345678','Nu','123 O dau do'),
('Tran Van C','012345678','Nam','123 O dau do'),
('Tran Van D','012345678','Nu','123 O dau do'),
('Tran Van E','012345678','Nam','123 O dau do')
go

insert into ThongTinXeBus(BienSoXe,LoaiXe,SoGheNgoi,Id_TaiXe)
values
('29D-22222','ToyoTa',16,1),
('29D-33333','Suzuki',17,4),
('29D-44444','Honda',18,2),
('29D-55555','Mazda',20,3),
('29D-11111','Mec',19,5)
go


insert into HocVien(TenHocVien,Diachi_HV,HoTenBo,HoTenMe,SDT_Bo,SDT_Me,NgaySinh_HV,GioiTinh_HV,Id_DiaDiemDon)
values
('Nguyen Van A','123A o dau day','Nguyen Van Bo A','Tran Van Me A','090123456','090654321','2000-1-1','Nam',1),
('Nguyen Van B','123B o dau day','Nguyen Van Bo B','Tran Van Me B','090123456','090654321','2000-2-2','Nu',2),
('Nguyen Van C','123C o dau day','Nguyen Van Bo C','Tran Van Me C','090123456','090654321','2000-3-3','Nam',4),
('Nguyen Van D','123D o dau day','Nguyen Van Bo D','Tran Van Me D','090123456','090654321','2000-4-4','Nu',3),
('Nguyen Van E','123E o dau day','Nguyen Van Bo E','Tran Van Me E','090123456','090654321','2000-5-5','Nam',5)
go

insert into LoTrinhXe(Id_Xe,Id_DiaDiemDon)
values
(1,5),
(2,4),
(3,1),
(4,2),
(5,3)
go

select * from DiaDiemDonXe
select * from TaiXe
select * from ThongTinXeBus
select * from HocVien
select * from LoTrinhXe
go

-- Tạo Proc xem thông tin lộ trình đi của xe bus : tài xế, biển số xe, địa chỉ đón--
create proc Proc_vw_Thongtinlotrinhdixebus
as
begin
	select TaiXe.TenTaiXe'Tài Xế',ThongTinXeBus.BienSoXe'Biển Số Xe',DiaDiemDonXe.DiaChi'Địa Chỉ'
	from TaiXe,ThongTinXeBus,DiaDiemDonXe,LoTrinhXe
	where TaiXe.Id_TaiXe = ThongTinXeBus.Id_TaiXe
		and ThongTinXeBus.Id_Xe = LoTrinhXe.Id_Xe
		and LoTrinhXe.Id_DiaDiemDon = DiaDiemDonXe.Id_DiaDiemDon
end
go

exec Proc_vw_Thongtinlotrinhdixebus

--Tạo Proc xem thông tin sinh viên theo biển số xe--
alter proc Proc_vw_ThongTinSinhVien_TheoBienSoXe
		@BienSoXe nvarchar(10)
as
begin
	select distinct HocVien.TenHocVien,HocVien.Diachi_HV,HocVien.GioiTinh_HV,ThongTinXeBus.BienSoXe'Biển Số Xe'
	from HocVien,ThongTinXeBus,LoTrinhXe,DiaDiemDonXe
	where HocVien.Id_DiaDiemDon = DiaDiemDonXe.Id_DiaDiemDon
		and DiaDiemDonXe.Id_DiaDiemDon = LoTrinhXe.Id_DiaDiemDon
		and LoTrinhXe.Id_Xe = ThongTinXeBus.Id_Xe
		and ThongTinXeBus.BienSoXe = @BienSoXe
end
go

exec Proc_vw_ThongTinSinhVien_TheoBienSoXe '29D-22222'
go
--Tao View xem thông tin sinh viên gồm : Tên SV, giới tính, địa chỉ đón--

select distinct  HocVien.TenHocVien,HocVien.Diachi_HV,HocVien.GioiTinh_HV,DiaDiemDonXe.DiaChi
	from HocVien,DiaDiemDonXe
	where HocVien.Id_DiaDiemDon = DiaDiemDonXe.Id_DiaDiemDon
go

