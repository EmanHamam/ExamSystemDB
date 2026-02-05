----------------------------Course------------------------------
ALTER proc InsertCourse @Id int,@Course_name varchar(50)
With encryption
as
insert into Course
values(@Id ,@Course_name)

InsertCourse 1,'CST'
go

ALTER proc SelectCourse @Id int
With encryption
as
select * from Course where Id = @Id

SelectCourse 1
go
