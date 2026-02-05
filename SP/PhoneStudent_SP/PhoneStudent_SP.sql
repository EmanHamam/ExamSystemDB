alter proc Insert_PhoneStudent @id int, @phone varchar(15)
with encryption
as
insert into Student_Phone
values (@id,@phone)

Insert_PhoneStudent 1,'011308045645'
go

alter proc Select_PhoneStudent @id int
with encryption
as
select * from Student_Phone where Student_Id = @id

Select_PhoneStudent 1
go
