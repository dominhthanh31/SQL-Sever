-- tao bang 
create table Room(
	id int primary key identity(1,1),
	name nvarchar(20),
	max int
)

create table Animal(
	id int primary key identity(1,1),
	name nvarchar(50),
	age int,
	buy_at datetime,
	room_id int references Room(id),
)

create table FoodType(
	id int primary key,
	name nvarchar(50),
	price float,
	amount float
)

create table FoodAnimal(
	food_id int references FoodType(id),
	animal_id int references Animal(id),
	primary key( food_id, animal_id)
)

-- them 5 ban ghi moi Bang--
insert into Room(name,max)
values
('Chuong 1', 20),
('Chuong 2', 10),
('Chuong 3',15),
('Chuong 4',25),
('Chuong 5',30)

select * from Room

insert into Animal(name,age,buy_at,room_id)
values
('Voi',11,'2021-4-5',1),
('Su Tu',12,'2021-4-5',3),
('Khi',13,'2021-4-5',5),
('Ngua Van',14,'2021-4-5',4),
('Huou Cao Co',15,'2021-4-5',2)

select * from Animal

insert into FoodType(id,name,price,amount)
values
(1,'Co 4 la',10000,11),
(2,'Thit Heo',50000,12),
(3,'Co 5 la',40000,13),
(4,'Co luck luck',20000,14),
(5,'Co Cao Co',30000,15)

insert into FoodAnimal(food_id,animal_id)
values
(1,5),
(2,2),
(3,4),
(4,1),
(5,3)

select *  from Room
select *  from Animal
select *  from FoodType
select *  from FoodAnimal

--4. xem thong tin gom cac Truong : ten chuong, ten dong vat, tuoi, ngay mua ve

select Room.name 'Ten Chuong' , Animal.name'Ten Dong Vat',Animal.age'Tuoi',Animal.buy_at'Ngay Mua Ve'
from Room,Animal
where Room.id = Animal.room_id


