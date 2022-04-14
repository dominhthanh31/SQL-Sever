-- 1. Database Creation
create database QuanLyNhanKhau
use QuanLyNhanKhau

-- 2. Table Creation
create table QuanHuyen(
	MaQH int identity(1,1) not null,
	TenQH nvarchar(100)
)
go

create table DuongPho(
	DuongID int not null,
	MaQH int not null,
	TenDuong nvarchar(max) not null,
	NgayDuyetTen datetime null
)
go

create table NhaTrenPho(
	NhaID int not null,
	DuongId int not null,
	ChuHo nvarchar(50) null,
	DienTich money null,
)
go

-- 3. Idex and Table Alternation
create clustered index Cl_NhaTrenPho_NhaID on NhaTrenPho(NhaID)

create Unique nonclustered index UI_QuanHuyen_TenQH on QuanHuyen(TenQH)

alter table NhaTrenPho
add SoNhanKhau int

-- 4. Constraint
alter table QuanHuyen
add constraint PK_QuanHuyen primary key(MaQH)
alter table DuongPho
add constraint PK_DuongPho primary key(DuongID)
alter table NhaTrenPho
add constraint PK_NhaTrenPho primary key(NhaID)

alter table NhaTrenPho
add constraint FK_NhaTrenPho_DuongPho foreign key(DuongID) references DuongPho(DuongID)
alter table DuongPho
add constraint FK_DuongPho_QuanHuyen foreign key(MaQH) references QuanHuyen(MaQH)

-- 5. Inserting Data
insert into QuanHuyen(TenQH)
values
('Ba Dinh'),
('Hoang Mai')

insert into DuongPho(DuongID, MaQH, TenDuong, NgayDuyetTen)
values
(1, 1, 'Doi Can', '1946-10-19'),
(2, 1, 'Van Phuc', '1998-12-30'),
(3, 2, 'Giai Toa', '1975-09-21')

insert into NhaTrenPho(NhaID, DuongId, ChuHo, DienTich, SoNhanKhau)
values
(1, 1, 'Ha Khanh Toan', 100, 4),
(2, 1, 'Le Hong Hai', 20, 12),
(3, 2, 'Tran Khanh', 40, 1)

-- 6. Query Operations
update DuongPho set TenDuong = 'Giai Phong' 
where TenDuong = 'Giai Toa'

-- 7. View
create view vw_all_NhaTrenPho
as
select QuanHuyen.TenQH, DuongPho.TenDuong, DuongPho.NgayDuyetTen, NhaTrenPho.ChuHo, NhaTrenPho.DienTich, NhaTrenPho.SoNhanKhau 
from QuanHuyen, DuongPho, NhaTrenPho
where QuanHuyen.MaQH = DuongPho.MaQH and
		DuongPho.DuongID = NhaTrenPho.DuongId

select * from vw_all_NhaTrenPho

-- 8. Views
create view vw_AVG_NhaTrenPho
as 
select DuongPho.TenDuong, avg(NhaTrenPho.DienTich) 'DienTichTrungBinh', avg(NhaTrenPho.SoNhanKhau) 'SoNhanKhauTrungBinh'
from DuongPho, NhaTrenPho
where DuongPho.DuongID = NhaTrenPho.DuongId
group by DuongPho.TenDuong

select * from vw_AVG_NhaTrenPho
order by 'DienTichTrungBinh', 'SoNhanKhauTrungBinh' asc

-- 9. Procedure
create proc sp_NgayQuyetTen_DuongPho 
		@NgayDuyet datetime
as 
begin
	select DuongPho.NgayDuyetTen, DuongPho.TenDuong, QuanHuyen.TenQH
	from DuongPho, QuanHuyen
	where DuongPho.MaQH = QuanHuyen.MaQH
		and DuongPho.NgayDuyetTen = @NgayDuyet
end

declare @NgayDuyet datetime
select @NgayDuyet = convert (datetime, '30/12/1998', 103)
exec sp_NgayQuyetTen_DuongPho @NgayDuyet

-- 10. Trigger
create trigger FOR_UPDATE_NhaTrenPho on NhaTrenPho
for update
as 
begin
	if(select count(SoNhanKhau) from inserted where SoNhanKhau <= 0) >0
	begin
		print N'So nhan khau yeu cau > 0'
		rollback transaction
	end
end

-- 11. Trigger
create trigger InsteadOf_Delete_DuongPho on DuongPho
for delete
as 
begin
	delete from NhaTrenPho where DuongId in (select DuongId from deleted)
	delete from DuongPho where DuongID in (select DuongID from deleted) 
end