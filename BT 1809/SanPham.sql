-- 1. Data
create database ProductManagementSystern
use ProductManagementSystern

-- 2.Table
create table tblUser (
	UserID int not null,
	UserName nvarchar(50)
)
go

create table tblOrder (
	OrderID int not null,
	UserID int not null,
	OrderDate datetime
)
go

create table tblProduct (
	ProductID int not null,
	ProductName nvarchar(50),
	Quantily int,
	Price money,
	Description_ ntext
)
go

create table tblOrderDetail (
	OrderID int not null,
	ProductID int not null,
	Quantily int,
	Price money
)
go

-- 3. Index
create clustered index CI_tblUser_UserID on tblUser(UserID)

alter table tblUser 
add BirthDate datetime

alter table tblOrder
add constraint DF_tblOrder_OrderDate default getdate() for OrderDate

alter table tblUser
add constraint PK_tblUser primary key (UserID)
alter table tblOrder
add constraint PK_tblOrder primary key (OrderID)
alter table tblProduct
add constraint PK_tblProduct primary key (ProductID)
alter table tblOrderDetail
add constraint PK_tblOrderDetail primary key (OrderID, ProductID)

alter table tblOrder
add constraint FK_tblOrder_tblUser foreign key (UserID) references tblUser(UserID)
alter table tblOrderDetail
add constraint FK_tblOrderDetail_tblOrder foreign key (OrderID) references tblOrder(OrderID)
alter table tblOrderDetail
add constraint FK_tblOrderDetail_tblProduct foreign key (ProductID) references tblProduct(ProductID)

alter table tblOrder
add constraint CK_tblOrder_OrderDate check (OrderDate between '2000-01-01' and getdate())

alter table tblUser
add constraint UN_tblUser_UserName unique (UserName)

-- 5. Insert
insert into tblUser(UserID, UserName, BirthDate)
values
(1 ,'stevejobs', '1996-08-28'),
(2 ,'billgates', '1998-06-18'),
(3 ,'larry', '1997-05-25'),
(4 ,'mark', '1984-03-27'),
(5 ,'dell', '1955-08-15'),
(6 ,'eric', '1955-07-28')

insert into tblOrder (OrderID, UserID, OrderDate)
values
(1, 2, '2002-12-01'),
(2, 3, '2000-03-02'),
(3, 2, '2004-08-03'),
(4, 1, '2001-05-12'),
(5, 4, '2002-10-04'),
(6, 6, '2002-03-08'),
(7, 5, '2002-05-02')

insert into tblProduct (ProductID, ProductName, Quantily, Price, Description_)
values
(1, 'Asus Zen', 2, 10, 'See what others can’t see.'),
(2, 'BPhone', 10, 20, 'The first flat-design smartphone in the world.'),
(3, 'iPhone', 13, 300, 'The only thing that’s changed is everything.'),
(4, 'XPeria', 7, 80, 'The world’s first 4K smartphone.'),
(5, 'Galaxy Note', 12, 120, 'Created to reflect your desire.')

insert into tblOrderDetail (OrderID, ProductID, Quantily, Price)
values
(1, 1, 10, 10),
(1, 2, 4, 20),
(2, 3, 5, 50),
(3, 3, 6, 80),
(4, 2, 21, 120),
(5, 2, 122, 300)

-- 6. Query
update tblProduct set Price = Price * 0.9 where ProductID = 3

select tblUser.UserID, tblUser.UserName, tblOrder.OrderID, tblOrder.OrderDate, tblOrderDetail.Quantily, tblOrderDetail.Price, tblProduct.ProductName
from tblUser, tblOrder, tblOrderDetail, tblProduct
where tblUser.UserID = tblOrder.UserID
	and tblOrder.OrderID = tblOrderDetail.OrderID
	and tblOrderDetail.ProductID = tblProduct.ProductID

select tblUser.UserID, tblUser.UserName, tblOrder.OrderID, tblOrder.OrderDate, tblProduct.Quantily, tblOrderDetail.Price, tblProduct.ProductName
from tblOrder left join tblUser on tblUser.UserID = tblOrder.UserID
		left join tblOrderDetail on tblOrder.OrderID = tblOrderDetail.OrderID
		left join tblProduct on tblOrderDetail.ProductID = tblProduct.ProductID

-- 7. View
create view view_Top2Product
as 
select top(2) tblProduct.ProductID, tblProduct.ProductName, tblProduct.Price, sum(tblOrderDetail.Quantily) 'TotalQuantily'
from tblOrderDetail left join tblProduct on tblOrderDetail.ProductID = tblProduct.ProductID
group by tblProduct.ProductID, tblProduct.ProductName, tblProduct.Price
order by TotalQuantily desc

-- 8. Proc
create proc sp_TimSanPham 
				@GiaMua money,
				@count int output
as 
begin
	select * from tblProduct
	where Price <= @GiaMua
	select @count = count(*) from tblProduct
	where Price <= @GiaMua
end

declare @count int
exec sp_TimSanPham 30, @count = @count output
print N'Tim thay ' + convert(nvarchar(10), @count) + ' san pham'

-- 9. Trigger
create trigger TG_tblProduct_Update on tblProduct
for update 
as
begin 
	if (select Price from inserted) < 10
	begin 
		print N'chiu chiu'
		rollback transaction
	end
end

-- 11
create trigger TG_tblUser_Update on tblUser
for UPDATE
as
begin
	if update(userName)
	begin
		print N'You don’t update the column UserName!'
		rollback transaction
	end
end
