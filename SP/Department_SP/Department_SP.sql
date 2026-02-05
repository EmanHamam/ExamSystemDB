-------------------------------Department------------------------------
Alter proc InsertDepartment ( @Id int,@Name varchar(20) )
With encryption
as
insert into Department(Id,Dept_Name)
values(@Id,@Name)

InsertDepartment 1 , 'SD'
go

alter proc SelectDepartment @Id int
With encryption
as
select * from Department where Id = @Id

SelectDepartment 1
go

alter proc UpdateDepartment @id int , @inst_id int
With encryption
as
update Department
set Instructor_Id = @inst_id
where Id = @id

UpdateDepartment 1,1

go

alter proc DeleteDepartment @id int
With encryption
as
delete from Department where Id = @id
go