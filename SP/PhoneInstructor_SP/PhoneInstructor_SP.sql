
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


CREATE PROC INSTRUCTOR_PHONE_DELETE
    @Instructor_ID INT,
    @Phone VARCHAR(15)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

      
        IF NOT EXISTS (
            SELECT 1 FROM Instructor 
            WHERE Instructor_Id = @Instructor_ID
        )
            RAISERROR('Instructor not found.', 16, 1);

       
        IF NOT EXISTS (
            SELECT 1 
            FROM Instructor_Phone
            WHERE Instructor_Id = @Instructor_ID 
              AND Phone = @Phone
        )
            RAISERROR('Phone not found for this instructor.', 16, 1);

       
        DELETE FROM Instructor_Phone
        WHERE Instructor_Id = @Instructor_ID
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

CREATE PROC INSTRUCTOR_PHONE_UPDATE
    @Instructor_ID INT,
    @Old_Phone VARCHAR(15),
    @New_Phone VARCHAR(15)
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        
        IF NOT EXISTS (
            SELECT 1 FROM Instructor 
            WHERE Instructor_Id = @Instructor_ID
        )
            RAISERROR('Instructor not found.', 16, 1);

        
        IF NOT EXISTS (
            SELECT 1 
            FROM Instructor_Phone
            WHERE Instructor_Id = @Instructor_ID
              AND Phone = @Old_Phone
        )
            RAISERROR('Old phone not found.', 16, 1);

        
        IF EXISTS (
            SELECT 1 
            FROM Instructor_Phone
            WHERE Instructor_Id = @Instructor_ID
              AND Phone = @New_Phone
        )
            RAISERROR('New phone already exists.', 16, 1);

       
        IF @New_Phone IS NULL
            RAISERROR('No new phone provided.', 16, 1);

       
        UPDATE Instructor_Phone
        SET Phone = @New_Phone
        WHERE Instructor_Id = @Instructor_ID
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

