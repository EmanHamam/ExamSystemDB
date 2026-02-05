------------------------------Student---------------------
Alter proc InsertStudent
(@Id int,@FName varchar(15),@LName varchar(15),@Email varchar(30),@Enroll_Date date)
with Encryption
as
Insert into Student (Id,FName,LName,Email,Enrollment_Date)
values(@Id,@FName,@LName,@Email,@Enroll_Date)

InsertStudent 1,'Ali','Ahmed','aliahmd23@gmail.com','10-10-2020'

go

alter proc SelectStudent @Id int
with Encryption
as
select * from Student
where Id =  @Id 

SelectStudent 1
go

alter proc UpdateStudent  @id int ,@track_id int
with Encryption
as
update Student
set Track_Id=@track_id
where Id = @id

UpdateStudent 1,1

go

alter proc DeleteStudent  @id int
with Encryption
as
Delete from Student where Id = @id 

DeleteStudent 1
go