Create Proc StudentsInfoAccordingToDepartment
with encryption
as 
begin
	select S.Id,concat(S.FName ,' ', S.LName) Name ,
	S.Email,S.Enrollment_Date, T.Track_Name, Dept_Name from Student S
	join Track T
	ON T.Id=S.Track_Id
	join Department D
	on D.Id= T.Dept_id
end

StudentsInfoAccordingToDepartment