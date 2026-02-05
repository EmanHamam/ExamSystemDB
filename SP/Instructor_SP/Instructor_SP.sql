-----------------------------Instructor-------------------------
alter proc InsertInstructor 
(@Id int,@FName varchar(15),@LName varchar(15),@Email varchar(30),@Hire_Date date)
with encryption
as
Insert into Instructor
values(@Id,@FName,@LName,@Email,@Hire_Date)

InsertInstructor 1,'Mahmoud','Ahmed','mahmoudahmd23@gmail.com','10-20-2021'
go

alter proc SelectInstructor @Id int
with encryption
as
select * from Instructor
where Instructor_Id =  @Id 

SelectInstructor 1
go

