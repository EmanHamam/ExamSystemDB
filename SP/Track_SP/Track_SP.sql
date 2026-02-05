------------------------------Track-----------------------------
Alter proc InsertTrack @Id int,@Track_name varchar(30),@Intake_year int,@dept_Id int
with encryption
as
insert into Track 
values(@Id ,@Track_name ,@Intake_year,@dept_Id )

InsertTrack 1,'PD',2026,1
go

alter proc SelectTrack @Id int
with encryption
as
select * from Track where Id = @Id

SelectTrack 1
go
