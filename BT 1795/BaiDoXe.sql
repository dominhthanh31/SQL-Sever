create table BaiDoXe (
	Ten_bai nvarchar(50),
	Ma_Bai_Do_Xe int primary key identity(1,1),
	Dia_Chi nvarchar(200)
)
go

create table ThongTinGui (
	Id int primary key identity(1,1),
	Ten_Xe nvarchar(50),
	Bien_So_Xe nvarchar(20),
	Ma_Bai_Do_Xe int,
	Id_Chu_So_Huu int 
)
go

create table BangChuSoHuu (
	Id_Chu_So_Huu int primary key identity(1,1),
	Ten nvarchar(50),
	So_CMTND nvarchar(20),
	Dia_Chi nvarchar(200)
)
go

insert into BaiDoXe(Ten_bai,Dia_Chi)
values
('Bai A','Ha Noi'),
('Bai B','Nam Dinh'),
('Bai C','Hai Phong'),
('Bai D','Son La'),
('Bai E','Ha Tay')

insert into ThongTinGui(Ten_Xe,Bien_So_Xe,Ma_Bai_Do_Xe,Id_Chu_So_Huu)
values
('vios','29C-1133',1,1),
('toyota','29A-2133',2,2),
('honda','29C-1642',5,3),
('mitsubishi','29C-3263',1,4),
('audi','29C-5543',4,5)

insert into BangChuSoHuu(Ten,So_CMTND,Dia_Chi)
values
('Nguyen Van A','1123344321','Ha Noi'),
('Le Thi B','324344321','Ha Noi'),
('Nguyen Van C','25434321','Cao Bang'),
('Nguyen Van D','577244321','Lang Son'),
('Le Thi E','981244321','Quang Ninh')

drop table BaiDoXe

drop table ThongTinGui

drop table BangChuSoHuu

--alter table BaiDoXe add constraint pk_BaiDoXe primary key(Ma_Bai_Do_Xe)

alter table ThongTinGui add constraint fk_ThongTinGui_Ma_Bai_Do_Xe foreign key(Ma_Bai_Do_Xe) references BaiDoXe(Ma_Bai_Do_Xe)

alter table ThongTinGui add constraint fk_ThongTinGui_Id_Chu_So_Huu foreign key(Id_Chu_So_Huu) references BangChuSoHuu(Id_Chu_So_Huu)