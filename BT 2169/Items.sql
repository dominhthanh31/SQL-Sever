create table Items (
	Item_No nvarchar(5),
	Descriptions nvarchar(50),
	Price int
)
go

insert into Items(Item_No, Descriptions, Price)
values
('HW1', 'Power Supply', '4000')
go

insert into Items(Item_No, Descriptions, Price)
values
('HW2', 'Keyboard', '2000')
go

insert into Items(Item_No, Descriptions, Price)
values
('HW3', 'Mouse', '800')
go

insert into Items(Item_No, Descriptions, Price)
values
('SW1', 'Office Suite', '15000')
go

insert into Items(Item_No, Descriptions, Price)
values
('SW2', 'Payroll Software', '8000')
go
