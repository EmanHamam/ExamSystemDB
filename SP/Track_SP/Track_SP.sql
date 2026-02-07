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

CREATE PROC TRACK_UPDATE
    @Track_ID INT,
    @Track_Name VARCHAR(30) = NULL,
    @Intake_Year INT = NULL,
    @Dept_ID INT = NULL
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        
        IF NOT EXISTS (
            SELECT 1 
            FROM Track 
            WHERE Id = @Track_ID
        )
            RAISERROR ('Track not found.', 16, 1);

       
        IF @Track_Name IS NULL 
           AND @Intake_Year IS NULL 
           AND @Dept_ID IS NULL
            RAISERROR ('No new values provided for update.', 16, 1);

        
        UPDATE Track
        SET
            Track_Name = ISNULL(@Track_Name, Track_Name),
            Intake_Year = ISNULL(@Intake_Year, Intake_Year),
            Dept_id = ISNULL(@Dept_ID, Dept_id)
        WHERE Id = @Track_ID;

        PRINT 'Track updated successfully';

    END TRY

    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO


CREATE PROC TRACK_DELETION
    @Track_ID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        
        IF NOT EXISTS (
            SELECT 1 
            FROM Track
            WHERE Id = @Track_ID
        )
            RAISERROR ('Track not found.', 16, 1);

       
        DELETE FROM Track
        WHERE Id = @Track_ID;

        PRINT 'Track deleted successfully';

    END TRY

    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO


