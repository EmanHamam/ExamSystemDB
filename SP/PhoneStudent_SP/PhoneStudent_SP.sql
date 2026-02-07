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


CREATE PROC STUDENT_PHONE_UPDATE
    @Student_ID INT,
    @Old_Phone VARCHAR(15),
    @New_Phone VARCHAR(15)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

       
        IF NOT EXISTS (
            SELECT 1 FROM Student 
            WHERE Id = @Student_ID
        )
            RAISERROR('Student not found.', 16, 1);

       
        IF NOT EXISTS (
            SELECT 1 
            FROM Student_Phone
            WHERE Student_Id = @Student_ID
              AND Phone = @Old_Phone
        )
            RAISERROR('Old phone not found.', 16, 1);

       
        IF @New_Phone IS NULL
            RAISERROR('No new phone provided.', 16, 1);

       
        IF EXISTS (
            SELECT 1 
            FROM Student_Phone
            WHERE Student_Id = @Student_ID
              AND Phone = @New_Phone
        )
            RAISERROR('New phone already exists.', 16, 1);

        UPDATE Student_Phone
        SET Phone = @New_Phone
        WHERE Student_Id = @Student_ID
          AND Phone = @Old_Phone;

        PRINT 'Phone updated successfully';

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO

CREATE PROC STUDENT_PHONE_DELETE
    @Student_ID INT,
    @Phone VARCHAR(15)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        
        IF NOT EXISTS (
            SELECT 1 FROM Student 
            WHERE Id = @Student_ID
        )
            RAISERROR('Student not found.', 16, 1);

       
        IF NOT EXISTS (
            SELECT 1 
            FROM Student_Phone
            WHERE Student_Id = @Student_ID
              AND Phone = @Phone
        )
            RAISERROR('Phone not found for this student.', 16, 1);

        DELETE FROM Student_Phone
        WHERE Student_Id = @Student_ID
          AND Phone = @Phone;

        PRINT 'Phone deleted successfully';

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO
