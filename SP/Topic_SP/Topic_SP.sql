------------------------------Topic---------------------------
ALTER proc InsertTopic @Id int , @topic_name varchar(50), @course_Id int
with encryption
as
insert into Topic 
values (@Id , @topic_name , @course_Id)

InsertTopic 1,'Web Development',1
go

alter proc SelectTopic @Id int
with encryption
as
select * from Topic where  Id=@Id

SelectTopic 1
go

