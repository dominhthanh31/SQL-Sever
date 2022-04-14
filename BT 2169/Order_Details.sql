create table Order_Details (
	Old_No nvarchar(5),
	Item_No nvarchar(5),
	Qty int
)
go

insert into Order_Details(Old_No, Item_No, Qty)
values
('101', 'HW3', '50')
go

insert into Order_Details(Old_No, Item_No, Qty)
values
('101', 'SW1', '150')
go

insert into Order_Details(Old_No, Item_No, Qty)
values
('102', 'HW2', '10')
go

insert into Order_Details(Old_No, Item_No, Qty)
values
('103', 'HW3', '50')
go

insert into Order_Details(Old_No, Item_No, Qty)
values
('104', 'HW2', '25')
go

insert into Order_Details(Old_No, Item_No, Qty)
values
('104', 'HW3', '100')
go

insert into Order_Details(Old_No, Item_No, Qty)
values
('105', 'SW1', '100')
go