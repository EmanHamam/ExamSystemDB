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


CREATE PROC INSTRUCTOR_DELETION
    @Instructor_ID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1 
            FROM Instructor 
            WHERE Instructor_Id = @Instructor_ID
        )
            RAISERROR ('Instructor not found.', 16, 1);

       
        DELETE FROM Instructor
        WHERE Instructor_Id = @Instructor_ID;

        PRINT 'Instructor deleted successfully';

    END TRY

    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);

        SELECT @ErrorMessage = ERROR_MESSAGE();

        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO


CREATE PROC INSTRUCTOR_UPDATE
    @Id INT,
    @FName VARCHAR(15) = NULL,
    @LName VARCHAR(15) = NULL,
    @Email VARCHAR(30) = NULL,
    @Hire_Date DATE = NULL
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        
        IF NOT EXISTS (
            SELECT 1 
            FROM Instructor 
            WHERE Instructor_Id = @Id
        )
            RAISERROR ('Instructor not found.', 16, 1);

        -- ensure at least one value provided
        IF @FName IS NULL 
           AND @LName IS NULL 
           AND @Email IS NULL 
           AND @Hire_Date IS NULL
            RAISERROR ('No new values provided for update.', 16, 1);

      
        UPDATE Instructor
        SET
            FName = ISNULL(@FName, FName),
            LName = ISNULL(@LName, LName),
            Email = ISNULL(@Email, Email),
            Hire_Date = ISNULL(@Hire_Date, Hire_Date)
        WHERE Instructor_Id = @Id;

        PRINT 'Instructor updated successfully';

    END TRY

    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO

