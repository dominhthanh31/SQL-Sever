-- Quan ly danh muc san pham
create table Category(
	id int primary key identity(1,1),
	name_ nvarchar(50)
)
go

-- Quan ly menu do uong
create table Product(
	id int primary key identity(1,1),
	title nvarchar(200),
	thumnail nvarchar(500),
	desscription text,
	price float,
	id_cat int references Category(id)
)
go

-- Quan ly nhan vien
create table Staff(
	id int primary key identity(1,1),
	fullname nvarchar(50),
	birthday date,
	address_ nvarchar(100),
	email nvarchar(100)
)
go

-- Quan ly khach hang
create table Customer(
	id int primary key identity(1,1),
	fullname nvarchar(50),
	phone_number nvarchar(20),
	address_ nvarchar(100),
	email nvarchar(100),	
)
go

-- Quan ly don hang
create table Order_(
	id int primary key identity(1,1),
	staff_id int references Staff(id),
	customer_id int references Customer(id),
	total_price float,
	order_date date,
	note nvarchar(100)
)
go

create table OrderDetail(
	id int primary key identity(1,1),
	order_id int,
	product_id int,
	number int,
	price float,
	total_price float
)
go

alter table OrderDetail
add constraint fk_OrderDetail_order_id foreign key (order_id) references Order_(id)

alter table OrderDetail
add constraint fk_OrderDetail_product_id foreign key (product_id) references Product(id)

-- Du lieu
insert into Category(name_)
values
('Cafe'),
('Nuoc ep'),
('Sinh to'),
('Do uong da xay'),
('Cocktail')

insert into Product(title, thumnail, desscription, price, id_cat)
values
('Cappuccino', 'Thumbnail_1', 'Noi dung 1', 60000, 1),
('Pink dream', 'Thumbnail_2', 'Noi dung 2', 80000, 3),
('Chocolate Ice Blended', 'Thumbnail_3', 'Noi dung 3', 85000, 4),
('Nuoc ep dua hau', 'Thumbnail_4', 'Noi dung 4', 70000, 2),
('Magarita', 'Thumbnail_5', 'Noi dung 5', 140000, 5)

insert into Staff(fullname, birthday, address_, email)
values
('A', '2000-01-01', 'Ha Noi', 'a@gmail.com'),
('B', '2000-02-02', 'Ha Noi', 'b@gmail.com'),
('C', '2000-03-03', 'Ha Noi', 'c@gmail.com'),
('D', '2000-04-04', 'Ha Noi', 'd@gmail.com'),
('E', '2000-05-05', 'Ha Noi', 'e@gmail.com')

insert into Customer(fullname, phone_number, address_, email)
values
('a', '0111111111', 'Ha Noi', 'a123@gmail.com'),
('b', '0222222222', 'Ha Noi', 'b123@gmail.com'),
('c', '0333333333', 'Ha Noi', 'c123@gmail.com'),
('d', '0444444444', 'Ha Noi', 'd123@gmail.com'),
('e', '0555555555', 'Ha Noi', 'e123@gmail.com')

insert into Order_(staff_id, customer_id, total_price, order_date, note)
values
