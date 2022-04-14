-- Data
create database CityKid
use CityKid

-- Table
create table Zone_ (
	id int primary key identity(1,1),
	tenZone nvarchar(50)
)
go

create table DungCu (
	id int primary key identity(1,1),
	tendungcu nvarchar(50),
	zone_id int, 
	price float,
	type_ int,
	percent_ float
)
go

create table CuaHang (
	id int primary key identity(1,1),
	tenquay nvarchar(50),
	zone_id int,
	company_name nvarchar(100)
)
go

create table DoUong (
	id int primary key identity(1,1),
	tennuocuong nvarchar(50),
	gia money,
	cuahang_id int
)
go

create table ticket (
	id int primary key identity(1,1),
	giave money,
	ngaymua date,
	dungcu_id int
)
go

create table services_ (
	id int primary key identity(1,1),
	donguong_id int,
	ngaymua date
)
go

alter table DungCu
add constraint FK_DungCu_ZoneId foreign key (zone_id) references Zone_ (id)
alter table CuaHang
add constraint FK_CuaHang_ZoneId foreign key (zone_id) references Zone_ (id)
alter table DoUong
add constraint FK_DoUong_ZoneId foreign key (cuahang_id) references CuaHang (id)
alter table ticket
add constraint FK_ticket_dungcu_id foreign key (dungcu_id) references DungCu (id)
alter table services_
add constraint FK_services_donguong_id foreign key (donguong_id) references DoUong (id)

-- Insert 
insert into Zone_ (tenZone)
values
('A1'),
('A2')

insert into CuaHang (tenquay, zone_id, company_name)
values
('B1', 1, 'C1'),
('B2', 2, 'C2'),
('B3', 1, 'C3'),
('B4', 2, 'C4'),
('B5', 2, 'C5')

insert into DungCu(tendungcu, zone_id, price, type_, percent_)
values
('D1', 1, 30, 0, 30),
('D2', 1, 20, 1, 30),
('D3', 2, 40, 0, 10),
('D4', 1, 30, 1, 20),
('D5', 2, 20, 1, 40)

insert into DoUong(tennuocuong, gia, cuahang_id)
values
('E1', 300, '4'),
('E2', 500, '1'),
('E3', 100, '2'),
('E4', 200, '5'),
('E5', 400, '3')

insert into ticket (giave, ngaymua, dungcu_id)
values
(5000, '2000-01-01', 2),
(7000, '2000-01-01', 1),
(9000, '2000-01-01', 5),
(8000, '2000-01-01', 4),
(6000, '2000-01-01', 3)

insert into services_ (donguong_id, ngaymua)
values
(5, '2020-02-02'),
(3, '2020-02-02'),
(4, '2020-02-02'),
(2, '2020-02-02'),
(1, '2020-02-02')

select * from Zone_
select * from CuaHang
select * from DungCu
select * from DoUong
select * from ticket
select * from services_

select Zone_.tenZone, DungCu.tendungcu, DungCu.price, DungCu.type_, DungCu.percent_ 
from Zone_ left join DungCu on Zone_.id = DungCu.zone_id
group by Zone_.tenZone, DungCu.tendungcu, DungCu.price, DungCu.type_, DungCu.percent_

create trigger no_update on ticket
for update
as begin 
	if update (giave)
	begin	
		print N'Khong duoc thay doi gia ve'
		rollback transaction
	end
end

update ticket set giave = 1000 where id = 3