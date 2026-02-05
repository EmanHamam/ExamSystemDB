
CREATE PROC QUESTION_INSERT
    @Question_ID INT,
    @Description VARCHAR(500),
    @Grade INT,
    @Course_ID INT = NULL
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        IF EXISTS (
            SELECT 1 FROM Question 
            WHERE Question_Id = @Question_ID
        )
            RAISERROR('Question already exists.', 16, 1);

        IF @Course_ID IS NOT NULL
            IF NOT EXISTS (SELECT 1 FROM Course WHERE Id = @Course_ID)
                RAISERROR('Course not found.', 16, 1);

        INSERT INTO Question
        VALUES (@Question_ID, @Description, @Grade, @Course_ID);

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO



CREATE PROC QUESTION_UPDATE
    @Question_ID INT,
    @Description VARCHAR(500) = NULL,
    @Grade INT = NULL,
    @Course_ID INT = NULL
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1 FROM Question 
            WHERE Question_Id = @Question_ID
        )
            RAISERROR('Question not found.', 16, 1);

        IF @Description IS NULL 
           AND @Grade IS NULL 
           AND @Course_ID IS NULL
            RAISERROR('No values provided for update.', 16, 1);

        IF @Course_ID IS NOT NULL
            IF NOT EXISTS (SELECT 1 FROM Course WHERE Id = @Course_ID)
                RAISERROR('Course not found.', 16, 1);

        UPDATE Question
        SET
            Ques_Description = ISNULL(@Description, Ques_Description),
            Grade = ISNULL(@Grade, Grade),
            Course_Id = ISNULL(@Course_ID, Course_Id)
        WHERE Question_Id = @Question_ID;

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO

CREATE PROC QUESTION_DELETE
    @Question_ID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        IF NOT EXISTS (
            SELECT 1 FROM Question 
            WHERE Question_Id = @Question_ID
        )
            RAISERROR('Question not found.', 16, 1);

        DELETE FROM Question
        WHERE Question_Id = @Question_ID;

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO


CREATE PROC QUESTION_SELECT
    @Question_ID INT = NULL,
    @Course_ID INT = NULL
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY

        IF @Question_ID IS NOT NULL
            IF NOT EXISTS (SELECT 1 FROM Question WHERE Question_Id = @Question_ID)
                RAISERROR('Question not found.', 16, 1);

        IF @Course_ID IS NOT NULL
            IF NOT EXISTS (SELECT 1 FROM Course WHERE Id = @Course_ID)
                RAISERROR('Course not found.', 16, 1);

        SELECT Question_Id,
               Ques_Description,
               Grade,
               Course_Id
        FROM Question
        WHERE (@Question_ID IS NULL OR Question_Id = @Question_ID)
          AND (@Course_ID IS NULL OR Course_Id = @Course_ID);

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO
