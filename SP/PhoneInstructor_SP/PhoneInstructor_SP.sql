
alter proc Insert_PhoneInstructor @id int, @phone varchar(15)
with encryption
as
insert into Instructor_Phone
values (@id,@phone)

Insert_PhoneInstructor 1,'010808045645'
go

alter proc Select_PhoneInstructor @id int
with encryption
as
select * from Instructor_Phone where Instructor_Id = @id

Select_PhoneInstructor 1
go