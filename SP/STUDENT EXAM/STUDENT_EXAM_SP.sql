-- INSERTION
CREATE PROC STUDENT_EXAM_INSERTION 
    @Student_ID INT, 
    @Exam_ID INT,
    @TotalGrade INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @Exam_ID)
            RAISERROR ('Exam not found.', 16, 1);
        IF NOT EXISTS (SELECT 1 FROM Student WHERE Id = @Student_ID)
             RAISERROR ('Student not found.', 16, 1);

        INSERT INTO Student_Exam (Student_ID, Exam_ID, Total_Grade)
        VALUES (@Student_ID, @Exam_ID, @TotalGrade);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT 
            @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 1 , 16);
    END CATCH
END;



-- SELECTION
CREATE PROC STUDENT_EXAM_SELECTION 
    @Student_ID INT = NULL, 
    @Exam_ID INT = NULL
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        IF @Student_ID IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Student WHERE Id = @Student_ID)
             RAISERROR ('Student not found.', 16, 1);
        END

        IF @Exam_ID IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @Exam_ID)
                RAISERROR ('Exam not found.', 16, 1);
        END

        SELECT Student_ID, Exam_ID, Total_Grade
        FROM Student_Exam
        WHERE 
            (@Student_ID IS NULL OR Student_ID = @Student_ID)
            AND (@Exam_ID IS NULL OR Exam_ID = @Exam_ID);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT 
            @ErrorMessage = ERROR_MESSAGE();

        RAISERROR (@ErrorMessage, 1 , 16);
    END CATCH
END;


-- UPDATE 
CREATE PROC STUDENT_EXAM_UPDATE 
    @Student_ID INT, 
    @Exam_ID INT, 
    @Total_Grade INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @Exam_ID)
            RAISERROR ('Exam not found.', 16, 1);
        IF NOT EXISTS (SELECT 1 FROM Student WHERE Id = @Student_ID)
            RAISERROR ('Student not found.', 16, 1);

        IF NOT EXISTS (
            SELECT 1 
            FROM Student_Exam 
            WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID
        )
        BEGIN
            RAISERROR('No matching record found in Student_Exam for the given Student_ID and Exam_ID.', 16, 1);
            RETURN;
        END

        UPDATE Student_Exam
        SET Total_Grade = @Total_Grade
        WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT 
            @ErrorMessage = ERROR_MESSAGE();

        RAISERROR (@ErrorMessage, 1 , 16);
    END CATCH
END;
GO

-- DELETION
CREATE PROC STUDENT_EXAM_DELETION 
    @Student_ID INT, 
    @Exam_ID INT
AS
BEGIN
BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @Exam_ID)
            RAISERROR ('Exam not found.', 16, 1);
        IF NOT EXISTS (SELECT 1 FROM Student WHERE Id = @Student_ID)
            RAISERROR ('Student not found.', 16, 1);

        IF EXISTS (
            SELECT 1 
            FROM Student_Exam 
            WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID
        )
		BEGIN 
                DELETE FROM Student_Exam
                WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID;
		END
		ELSE
		  RAISERROR('NOT FOUND TO DELETE',16,1);
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT 
            @ErrorMessage = ERROR_MESSAGE();

        RAISERROR (@ErrorMessage, 1 , 16);
END CATCH
END;


-- TEST
-- INSERTION

EXEC STUDENT_EXAM_INSERTION @Student_ID = 1, @Exam_ID = 2

-- SELECTION
EXEC STUDENT_EXAM_SELECTION @STUDENT_ID = 1, @Exam_ID = 2

-- DELETION
EXEC STUDENT_EXAM_DELETION @STUDENT_ID = 1, @Exam_ID = 2

-- UPDATE
EXEC STUDENT_EXAM_UPDATE @STUDENT_ID = 1, @Exam_ID = 2, @Total_Grade = 40