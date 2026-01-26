-- INSERTION 
CREATE PROC STUDENT_QUESTION_EXAM_INSERTION 
    @S_ID INT,
    @E_ID INT,
    @Q_ID INT,
    @ANS INT = NULL
WITH ENCRYPTION
AS 
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @E_ID)
            RAISERROR ('Exam not found.', 16, 1);
        IF NOT EXISTS (SELECT 1 FROM Student WHERE Id = @S_ID)
             RAISERROR ('Student not found.', 16, 1);
        IF NOT EXISTS (SELECT 1 FROM Question WHERE Question_Id = @Q_ID)
             RAISERROR ('Question not found.', 16, 1);
        DECLARE @Score INT = 0;
        IF @ANS IS NOT NULL
        BEGIN
            DECLARE @QuestionGrade INT;
            SELECT @QuestionGrade = Grade 
            FROM Question
            WHERE Question_Id = @Q_ID;

            IF EXISTS (SELECT 1 FROM TrueFalse_Question WHERE QuestionTF_Id = @Q_ID)
            BEGIN
                DECLARE @CorrectTF INT;

                SELECT @CorrectTF = Correct_Answer
                FROM TrueFalse_Question
                WHERE QuestionTF_Id = @Q_ID;

                IF (@ANS = @CorrectTF)
                    SET @Score = @QuestionGrade;
            END

            ELSE IF EXISTS (SELECT 1 FROM MCQ_Question WHERE QuestionMCQ_Id = @Q_ID)
            BEGIN
                IF EXISTS (SELECT 1 FROM MCQ_Option WHERE Option_ID = @ANS AND Question_ID = @Q_ID AND Is_Correct = 1)
                BEGIN
                    SET @Score = @QuestionGrade;
                END
            END
        END
    INSERT INTO Student_Question_Exam(Student_Id,Exam_Id,Question_Id,Student_Answer,Student_Grade)
            VALUES(@S_ID,@E_ID,@Q_ID,@ANS,@Score);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END

-- SELECTION
CREATE PROC STUDENT_QUESTION_EXAM_SELECTION
    @S_ID INT = NULL,
    @E_ID INT = NULL,
    @Q_ID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF @S_ID IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Question WHERE Question_Id = @Q_ID)
             RAISERROR ('Student not found.', 16, 1);
        END

        IF @E_ID IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @E_ID)
                RAISERROR ('Exam not found.', 16, 1);
        END

        IF @Q_ID IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Question WHERE Question_Id = @Q_ID)
                RAISERROR ('Question not found.', 16, 1);
        END

        SELECT Student_ID, Exam_ID, Question_ID, Student_Answer, Student_Grade
        FROM 
            STUDENT_QUESTION_EXAM
        WHERE 
            (@S_ID IS NULL OR Student_ID = @S_ID)
            AND (@E_ID IS NULL OR Exam_ID = @E_ID)
            AND (@Q_ID IS NULL OR Question_ID = @Q_ID);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END

-- UPDATE
CREATE PROC STUDENT_QUESTION_EXAM_UPDATE
    @S_ID INT,
    @E_ID INT,
    @Q_ID INT,
    @ANS INT = NULL 
AS
BEGIN
BEGIN TRY 
    IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @E_ID)
        RAISERROR ('Exam not found.', 16, 1);
    IF NOT EXISTS (SELECT 1 FROM Student WHERE Id = @S_ID)
        RAISERROR ('Student not found.', 16, 1);
    IF NOT EXISTS (SELECT 1 FROM Question WHERE Question_Id = @Q_ID)
        RAISERROR ('Student not found.', 16, 1);
    IF @ANS IS NOT NULL
        BEGIN
        UPDATE STUDENT_QUESTION_EXAM
        SET  Student_Answer= @ANS
        WHERE Student_ID = @S_ID AND Exam_ID = @E_ID AND Question_ID = @Q_ID;
    END
        ELSE
        BEGIN
            RAISERROR('No new answer provided. No update to answer.',16,1);
        END

END TRY
BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
END CATCH
END;


-- DELETE 
CREATE PROC STUDENT_QUESTION_EXAM_DELETION
    @S_ID INT,
    @E_ID INT,
    @Q_ID INT
AS
BEGIN
BEGIN TRY
    IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @E_ID)
        RAISERROR ('Exam not found.', 16, 1);
    IF NOT EXISTS (SELECT 1 FROM Student WHERE Id = @S_ID)
        RAISERROR ('Student not found.', 16, 1);
    IF NOT EXISTS (SELECT 1 FROM Question WHERE Question_Id = @Q_ID)
        RAISERROR ('Student not found.', 16, 1);
    IF EXISTS (SELECT 1 
               FROM STUDENT_QUESTION_EXAM
               WHERE Student_ID = @S_ID AND Exam_ID = @E_ID AND Question_ID = @Q_ID)
    BEGIN
        DELETE FROM STUDENT_QUESTION_EXAM
        WHERE Student_ID = @S_ID AND Exam_ID = @E_ID AND Question_ID = @Q_ID;

    END
    ELSE
    BEGIN
        RAISERROR('Record not found. Deletion failed.',16,1);
    END
END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
