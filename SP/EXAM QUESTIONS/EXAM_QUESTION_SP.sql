-- insertion
CREATE PROC EXAM_QUESTIONS_INSERTION 
    @EXAM_ID INT, 
    @QUESTION_ID INT
WITH ENCRYPTION
AS
BEGIN
BEGIN TRY

    IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @Exam_ID)
      RAISERROR ('Exam not found.', 16, 1);
    IF NOT EXISTS (SELECT 1 FROM Question WHERE Question_Id = @QUESTION_ID)
      RAISERROR ('Question not found.', 16, 1);

    INSERT INTO Exam_Question (Exam_Id, Question_Id)
    VALUES(@EXAM_ID, @QUESTION_ID);
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    SELECT @ErrorMessage = ERROR_MESSAGE();
    RAISERROR (@ErrorMessage, 1, 16);
END CATCH
END;

-- selection 
CREATE PROC Exam_QUESTION_SELECTION 
    @Exam_id INT
WITH ENCRYPTION 
AS
BEGIN
BEGIN TRY
    IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @Exam_ID)
       RAISERROR ('Exam not found.', 16, 1);
	SELECT * FROM Exam_Question WHERE Exam_Question.Exam_ID = @Exam_id
END TRY
BEGIN CATCH
 DECLARE @ErrorMessage NVARCHAR(4000);
    SELECT @ErrorMessage = ERROR_MESSAGE();
    RAISERROR (@ErrorMessage, 1, 16);
END CATCH
END

-- DELETION
CREATE PROC EXAM_QUESTION_DELETION 
    @Exam_ID INT, 
    @QUESTION_ID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @Exam_ID)
            RAISERROR ('Exam not found.', 16, 1);
        IF NOT EXISTS (SELECT 1 FROM Question WHERE Question_Id = @QUESTION_ID)
            RAISERROR ('Question not found.', 16, 1);

        IF EXISTS (SELECT 1 FROM Exam_Question WHERE Exam_Id = @Exam_ID AND Question_ID = @QUESTION_ID)
        BEGIN
            DELETE FROM Exam_Question 
            WHERE Exam_Id = @Exam_ID AND Question_ID = @QUESTION_ID;
        END
        ELSE
        BEGIN
            RAISERROR ('Invalid Exam_ID or Question_ID association.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT 
            @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage,1,16);
    END CATCH
END
