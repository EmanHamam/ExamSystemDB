CREATE PROC INSTRUCTOR_TRACK_INSERT
    @Instructor_ID INT,
    @Track_ID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE Instructor_Id = @Instructor_ID)
            RAISERROR('Instructor not found.', 16, 1);

        IF NOT EXISTS (SELECT 1 FROM Track WHERE Id = @Track_ID)
            RAISERROR('Track not found.', 16, 1);

        IF EXISTS (
            SELECT 1 
            FROM Instructor_Track
            WHERE Instructor_Id = @Instructor_ID 
              AND Track_Id = @Track_ID
        )
            RAISERROR('Relation already exists.', 16, 1);

        INSERT INTO Instructor_Track(Instructor_Id, Track_Id)
        VALUES(@Instructor_ID, @Track_ID);

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO


CREATE PROC INSTRUCTOR_TRACK_SELECT
    @Instructor_ID INT = NULL,
    @Track_ID INT = NULL
AS
BEGIN
    BEGIN TRY

        IF @Instructor_ID IS NOT NULL
            IF NOT EXISTS (SELECT 1 FROM Instructor WHERE Instructor_Id = @Instructor_ID)
                RAISERROR('Instructor not found.', 16, 1);

        IF @Track_ID IS NOT NULL
            IF NOT EXISTS (SELECT 1 FROM Track WHERE Id = @Track_ID)
                RAISERROR('Track not found.', 16, 1);

        SELECT Instructor_Id, Track_Id
        FROM Instructor_Track
        WHERE (@Instructor_ID IS NULL OR Instructor_Id = @Instructor_ID)
          AND (@Track_ID IS NULL OR Track_Id = @Track_ID);

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO


CREATE PROC INSTRUCTOR_TRACK_DELETE
    @Instructor_ID INT,
    @Track_ID INT
AS
BEGIN
    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1 
            FROM Instructor_Track
            WHERE Instructor_Id = @Instructor_ID 
              AND Track_Id = @Track_ID
        )
            RAISERROR('Relation not found.', 16, 1);

        DELETE FROM Instructor_Track
        WHERE Instructor_Id = @Instructor_ID
          AND Track_Id = @Track_ID;

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO


CREATE PROC INSTRUCTOR_TRACK_UPDATE
    @Instructor_ID INT,
    @Old_Track_ID INT,
    @New_Track_ID INT
AS
BEGIN
    BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE Instructor_Id = @Instructor_ID)
            RAISERROR('Instructor not found.', 16, 1);

        IF NOT EXISTS (SELECT 1 FROM Track WHERE Id = @New_Track_ID)
            RAISERROR('New track not found.', 16, 1);

        IF NOT EXISTS (
            SELECT 1 
            FROM Instructor_Track
            WHERE Instructor_Id = @Instructor_ID 
              AND Track_Id = @Old_Track_ID
        )
            RAISERROR('Old relation not found.', 16, 1);

        IF EXISTS (
            SELECT 1 
            FROM Instructor_Track
            WHERE Instructor_Id = @Instructor_ID 
              AND Track_Id = @New_Track_ID
        )
            RAISERROR('New relation already exists.', 16, 1);

        UPDATE Instructor_Track
        SET Track_Id = @New_Track_ID
        WHERE Instructor_Id = @Instructor_ID
          AND Track_Id = @Old_Track_ID;

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO
