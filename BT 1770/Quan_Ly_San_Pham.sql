create table product (
	id int primary key identity(1,1),
	title nvarchar(250),
	thumbnail nvarchar(500),
	content text
)
go

create table category (
	id int primary key identity(1,1),
	name nvarchar(50) not null
)
go

alter table product
add price float
go

alter table product
add num int default 0
go

alter table product
add created_at datetime
go

alter table product
add updated_at datetime
go

alter table product
add id_cat int references category(id)
go

insert into category(name)
values
('Danh Muc 1'),
('Danh Muc 2'),
('Danh Muc 3')
go

select * from category

insert into product(title, thumbnail, content, price, num, created_at, updated_at, id_cat)
values
('San Pham 1', 'thumb01', 'Noi dung 1', 0, 100, '2022-01-05 10:00:00', '2022-01-05 10:00:00', 1),
('San Pham 2', 'thumb02', 'Noi dung 2', 11, 10, '2019-01-05 10:00:00', '2019-01-05 11:00:00', 1),
('San Pham 3', 'thumb03', 'Noi dung 3', 0, 1000, '2020-01-05 10:00:00', '2020-01-05 11:00:00', 2),
('San Pham 4', 'thumb04', 'Noi dung 4', 100, 20, '2022-01-05 10:00:00', '2022-01-05 10:00:00', 2),
('San Pham 5', 'thumb05', 'Noi dung 5', 122, 50, '2010-01-05 10:00:00', '2022-01-05 10:00:00', 3)
go

select * from category
select * from product

update product set price = 5000
where price = 0 or price is null
go

update product set price = price * 0.9
where created_at < '2020-06-06'
go

delete from product
where created_at < '2016-12-31'
go
