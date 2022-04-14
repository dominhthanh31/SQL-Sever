-- Tao database
create database QuanLyCafe

-- Active database
use QuanLyCafe

-- Tao tables
create table category (
	id int primary key identity(1,1),
	name nvarchar(50) not null
)

create table product(
	id int primary key identity(1,1),
	title nvarchar(150),
	price money,
	thumbnail nvarchar(500),
	updated_at datetime,
	created_ad datetime,
	content text,
	id_cat int,
	constraint fk_id_cat foreign key (id_cat) references category(id)
)
create table staff(
	id int primary key identity(1,1),
	fullname nvarchar(100),
	birthday datetime,
	address nvarchar(200)
)
create table customer(
	id int primary key identity(1,1),
	fullname nvarchar(150),
	phone_number nvarchar(30),
	address nvarchar(200)
)
create table orders(
	id int primary key identity(1,1),
	staff_id int,
	constraint fk_staff_id foreign key (staff_id) references staff(id),
	customer_id int,
	constraint fk_customer_id foreign key (customer_id) references customer(id),
	total_price int,
	order_date datetime
)
create table order_detail(
	id int primary key identity(1,1),
	order_id int,
	product_id int,
	constraint fk_order_id foreign key (order_id) references orders(id),
	constraint fk_product_id foreign key (product_id) references product(id),
	amount int,
	price money,
	total_price int
)

-- Nhap du lieu cho tat ca cac tables
insert into category(name)
values
('tea'),
('coffee'),
('bia'),
('juice'),
('coca')

insert into product(title,price,thumbnail,updated_at,created_ad,content,id_cat)
values
('tra sua tran chau',10,'photo01.jpg','2020-10-10','2020-10-20','abcxyz',2),
('coffe da',20,'photo02.jpg','2020-10-10','2020-10-20','abcxyz',1),
('bia ha noi',30,'photo03.jpg','2020-10-10','2020-10-20','abcxyz',2),
('nuoc cam',40,'photo04.jpg','2020-10-10','2020-10-20','abcxyz',3),
('coca cola',50,'photo05.jpg','2020-10-10','2020-10-20','abcxyz',1)

insert into staff(fullname,birthday,address)
values
('Leo Messi','2020-05-05','Argentina'),
('C.Ronaldo','2020-05-05','Portugal'),
('T.V.Lam','2020-05-05','VietNam'),
('A.Grizman','2020-05-05','France'),
('H.Xavi','2020-05-10','Spain')

insert into customer(fullname,phone_number,address)
values
('Tran Van A','1234444','Hanoi'),
('Tran Van B','133243','Hanam'),
('Tran Van C','3223242','ThaiBinh'),
('Tran Van D','3414141','NamDinh'),
('Tran Van E','31213123','HaiPhong')

select * from staff

insert into orders(staff_id,customer_id,total_price,order_date)
values
(2,2,50,'2020-12-11'),
(2,1,60,'2020-12-11'),
(5,4,70,'2020-12-11'),
(3,2,55,'2020-12-11'),
(4,3,60,'2020-12-11')

select * from orders

insert into order_detail(order_id,product_id,amount,price,total_price)
values
(2,2,2,20,40),
(2,1,1,10,10),
(4,2,3,20,60),
(3,2,3,20,60),
(3,1,1,10,10)

-- Liet ke san pham theo 1 danh muc: id, title, price, thumbnail, updated_at, category_name
select * from category
select * from product

select product.id, product.title, product.price, product.thumbnail, product.updated_at, category.name as category_name
from product left join category on product.id_cat = category.id
where category.id = 2

create proc proc_view_product
	@idCat int
as
begin
	select product.id, product.title, product.price, product.thumbnail, product.updated_at, category.name as category_name
	from product left join category on product.id_cat = category.id
	where category.id = @idCat
end

exec proc_view_product 1
exec proc_view_product 2

-- Hien thi thong tin danh muc san pham trong don hang
select * from category
select * from product
select * from orders
select * from order_detail

select product.title, order_detail.amount, order_detail.price, order_detail.total_price
from product left join order_detail on product.id = order_detail.product_id
where order_detail.order_id = 2

create proc proc_view_order_detail
	@orderId int
as
begin
	select product.title, order_detail.amount, order_detail.price, order_detail.total_price
	from product left join order_detail on product.id = order_detail.product_id
	where order_detail.order_id = @orderId
end

exec proc_view_order_detail 2
exec proc_view_order_detail 1

-- xem thong tin chi tiet ve KH: nhan vien ban hang, khach hang, tong tien, ngay mua
select staff.fullname 'Ten Nhan Vien', customer.fullname 'Ten KH', orders.total_price, orders.order_date
from orders left join staff on orders.staff_id = staff.id
	left join customer on orders.customer_id = customer.id
where orders.customer_id = 2

create proc proc_view_order_by_customer
	@customerId int
as
begin
	select staff.fullname 'Ten Nhan Vien', customer.fullname 'Ten KH', orders.total_price, orders.order_date
	from orders left join staff on orders.staff_id = staff.id
		left join customer on orders.customer_id = customer.id
	where orders.customer_id = @customerId
end

exec proc_view_order_by_customer 2

-- Thong ke doanh thu
select sum(total_price) as 'Tong Doanh Thu'
from orders
where order_date >= '2020-12-10'
	and order_date <= '2020-12-30'

create proc proce_view_money
	@startDate date,
	@endDate date
as
begin
	select sum(total_price) as 'Tong Doanh Thu'
	from orders
	where order_date >= @startDate
		and order_date <= @endDate
end

exec proce_view_money '2020-12-10', '2020-12-30'