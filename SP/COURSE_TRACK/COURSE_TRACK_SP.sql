
CREATE PROC COURSE_TRACK_INSERT
    @Course_ID INT,
    @Track_ID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
	
        IF NOT EXISTS (SELECT 1 FROM Course WHERE Id = @Course_ID)
            RAISERROR('Course not found.', 16, 1);

        IF NOT EXISTS (SELECT 1 FROM Track WHERE Id = @Track_ID)
            RAISERROR('Track not found.', 16, 1);

        IF EXISTS (
            SELECT 1 
            FROM Course_Track
            WHERE Course_Id = @Course_ID 
              AND Track_Id = @Track_ID
        )
            RAISERROR('Relation already exists.', 16, 1);

        INSERT INTO Course_Track(Course_Id, Track_Id)
        VALUES(@Course_ID, @Track_ID);

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO


CREATE PROC COURSE_TRACK_DELETE
    @Course_ID INT,
    @Track_ID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1 
            FROM Course_Track
            WHERE Course_Id = @Course_ID 
              AND Track_Id = @Track_ID
        )
            RAISERROR('Relation not found.', 16, 1);

        DELETE FROM Course_Track
        WHERE Course_Id = @Course_ID
          AND Track_Id = @Track_ID;

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO



CREATE PROC COURSE_TRACK_UPDATE
    @Course_ID INT,
    @Old_Track_ID INT,
    @New_Track_ID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM Course WHERE Id = @Course_ID)
            RAISERROR('Course not found.', 16, 1);

        IF NOT EXISTS (SELECT 1 FROM Track WHERE Id = @New_Track_ID)
            RAISERROR('New track not found.', 16, 1);

        IF NOT EXISTS (
            SELECT 1 
            FROM Course_Track
            WHERE Course_Id = @Course_ID 
              AND Track_Id = @Old_Track_ID
        )
            RAISERROR('Old relation not found.', 16, 1);

        IF EXISTS (
            SELECT 1 
            FROM Course_Track
            WHERE Course_Id = @Course_ID 
              AND Track_Id = @New_Track_ID
        )
            RAISERROR('New relation already exists.', 16, 1);

        UPDATE Course_Track
        SET Track_Id = @New_Track_ID
        WHERE Course_Id = @Course_ID
          AND Track_Id = @Old_Track_ID;

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO


CREATE PROC COURSE_TRACK_SELECT
    @Course_ID INT = NULL,
    @Track_ID INT = NULL
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        IF @Course_ID IS NOT NULL
            IF NOT EXISTS (SELECT 1 FROM Course WHERE Id = @Course_ID)
                RAISERROR('Course not found.', 16, 1);

        IF @Track_ID IS NOT NULL
            IF NOT EXISTS (SELECT 1 FROM Track WHERE Id = @Track_ID)
                RAISERROR('Track not found.', 16, 1);

        SELECT Course_Id, Track_Id
        FROM Course_Track
        WHERE (@Course_ID IS NULL OR Course_Id = @Course_ID)
          AND (@Track_ID IS NULL OR Track_Id = @Track_ID);

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO
