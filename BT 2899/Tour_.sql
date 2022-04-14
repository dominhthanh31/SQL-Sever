-- Tao CSDL
create database BT2899
go

-- Kich hoat CSDL
use BT2899
go

-- Tao tables
create table customer (
	id int not null identity(1,1),
	fullname nvarchar(50),
	birthday date,
	phone nvarchar(20),
	email nvarchar(150),
	point int default 0
)
go

create table places (
	id int not null identity(1,1),
	place_name nvarchar(100),
	address nvarchar(200)
)
go

create table tour (
	id int not null identity(1,1),
	place_id int,
	start_date datetime,
	end_date datetime,
	price float
)
go

create table booking (
	tour_id int not null,
	customer_id int not null,
	book_date datetime
)
go

-- primary key
alter table customer
add constraint pk_customer primary key (id)
go

alter table places
add constraint pk_places primary key (id)
go

alter table tour
add constraint pk_tour primary key (id)
go

alter table booking
add constraint pk_booking primary key (tour_id, customer_id)
go

-- foreign key
alter table tour
add constraint fk_tour_places foreign key (place_id) references places (id)
go

alter table booking
add constraint fk_booking_tour foreign key (tour_id) references tour (id)
go

alter table booking
add constraint fk_booking_customer foreign key (customer_id) references customer (id)
go

-- insert data
insert into places (place_name, address)
values
('A', 'Dia Chi A'),
('B', 'Dia Chi B'),
('C', 'Dia Chi C'),
('D', 'Dia Chi D'),
('E', 'Dia Chi E')
go

insert into tour (place_id, start_date, end_date, price)
values
(1, '2022-03-28', '2022-04-02', 5000000),
(1, '2022-04-20', '2022-04-22', 3000000),
(2, '2022-03-29', '2022-04-01', 2000000),
(2, '2022-04-03', '2022-04-05', 2000000),
(3, '2022-04-06', '2022-04-08', 3000000)
go

insert into customer (fullname, phone, email, birthday)
values
('Tran Van A', '123123', 'a@gmail.com', '1999-02-16'),
('Tran Van B', '345345', 'b@gmail.com', '1998-02-16'),
('Tran Van C', '645654', 'c@gmail.com', '1989-02-16'),
('Tran Van D', '546456', 'd@gmail.com', '1988-02-16'),
('Tran Van E', '567567', 'e@gmail.com', '1969-02-16'),
('Tran Van F', '768678', 'f@gmail.com', '2000-02-16')
go

insert into booking (tour_id, customer_id, book_date)
values
(1, 1, '2022-03-23'),
(1, 2, '2022-03-24'),
(1, 3, '2022-03-25'),
(2, 2, '2022-03-22'),
(2, 3, '2022-03-21'),
(3, 4, '2022-03-26')
go

-- proc
create proc proc_find_customer_by_tour
	@tourId int
as
begin
	-- customer name (customer), phone (customer), place_name (places), start_date (tour), end_date (tour), price (tour)
	select customer.fullname, customer.phone, places.place_name, tour.start_date, tour.end_date
	from customer, places, tour, booking
	where customer.id = booking.customer_id
		and booking.tour_id = tour.id
		and tour.place_id = places.id
		and tour.id = @tourId
end

exec proc_find_customer_by_tour 1
exec proc_find_customer_by_tour 2
exec proc_find_customer_by_tour 3

-- Thong ke doanh thu cho tung tour
---- tour, booking
create view view_statistic_money_by_tour
as
select tour.id, places.place_name, tour.start_date, tour.end_date, sum(tour.price) 'Doanh Thu'
from tour, booking, places
where tour.id = booking.tour_id
	and tour.place_id = places.id
group by tour.id, places.place_name, tour.start_date, tour.end_date

select * from tour
select * from booking

select tour.id, tour.start_date, tour.end_date, tour.price
from tour, booking
where tour.id = booking.tour_id

select tour.id, tour.start_date, tour.end_date, sum(tour.price) 'Doanh Thu'
from tour, booking
where tour.id = booking.tour_id
group by tour.id, tour.start_date, tour.end_date


select * from view_statistic_money_by_tour

-- trigger: insert | update | delete + table -> Thiet lap trigger -> block code
delete from customer where id = 6
-- hard delete -> xoa cung -> thuc te -> han che su dung
-- soft delete -> table > deleted: tinyint > 0 | 1 > 0: Chua bi xoa & 1: Du lieu da bi
-- update customer set deleted = 1 where id = ?

create trigger trigger_for_delete_customer on customer
for delete
as
begin
	print N'Ban khong duoc xoa du lieu trong bang customer'
	rollback transaction
end

-- Trigger
select * from tour

update tour set price = 10000000 where id = 5

create trigger trigger_no_update_price on tour
for update
as
begin
	if update (price)
	begin
		print N'Khong duoc phep thay doi gia tour'
		rollback transaction
	end
end

update tour set price = 8000000 where id = 5