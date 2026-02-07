--Exam SP
--Insert
alter PROC EXAM_INSERTION 
    @Exam_Name varchar(50),
    @Exam_Date DATE, 
    @Exam_Duration INT,
    @New_Exam_ID INT OUTPUT
WITH ENCRYPTION
AS
BEGIN
BEGIN TRY
    INSERT INTO EXAM (Exam_Name,EXDate, Duration)
    VALUES (@Exam_Name,@Exam_Date,@Exam_Duration)
    SET @New_Exam_ID = SCOPE_IDENTITY();
END TRY
BEGIN CATCH
DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT  @ErrorMessage = ERROR_MESSAGE()
        RAISERROR (@ErrorMessage,1,16);
END CATCH
END


----------------------------------------------------------------------------------------------------------------------
--Select
CREATE PROC EXAM_SELECTION 
    @Exam_id INT = NULL
WITH ENCRYPTION 
AS
BEGIN
    BEGIN TRY
        IF @Exam_id IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @Exam_id)
              RAISERROR ('Exam not found.', 16, 1);

            SELECT * FROM Exam WHERE Exam_Id = @Exam_id;
        END
        ELSE
        BEGIN
            SELECT * FROM Exam;
        END
END TRY
BEGIN CATCH
 DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT  @ErrorMessage = ERROR_MESSAGE()
        RAISERROR (@ErrorMessage,1,16);
END CATCH
END

----------------------------------------------------------------------------------------------------------------------
--Update
CREATE PROC EXAM_UPDATE 
    @Exam_id INT,
    @Exam_Name varchar(50)=NULL,
    @Exam_Date DATE=NULL, 
    @Exam_Duration INT=NULL
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @Exam_id)
          RAISERROR ('Exam not found.', 16, 1);

        UPDATE EXAM
        SET
            -- Exam_Id= COALESCE(@Exam_id, Exam_Id),
             Exam_Name = COALESCE(@Exam_Name, Exam_Name),
             EXDate = COALESCE(@Exam_Date, EXDate),
             Duration = COALESCE(@Exam_Duration, Duration)

        WHERE Exam_Id = @Exam_id;
    END TRY
    BEGIN CATCH
       DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT  @ErrorMessage = ERROR_MESSAGE()
        RAISERROR (@ErrorMessage,1,16);
    END CATCH
END

----------------------------------------------------------------------------------------------------------------------
-- DELETE 
CREATE PROC EXAM_DELETION @EXAM_ID INT 
WITH ENCRYPTION
AS
BEGIN
BEGIN TRY
    IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @Exam_ID)
      RAISERROR ('Exam not found.', 16, 1);

    DELETE FROM EXAM WHERE Exam_Id = @Exam_ID
END TRY
BEGIN CATCH
 DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT  @ErrorMessage = ERROR_MESSAGE()
        RAISERROR (@ErrorMessage,1,16);
END CATCH
END
----------------------------------------------------------------------------------------------------------------------
--Run them in the same Batch
-- TEST INSERTION
declare @ExamId int 
EXEC EXAM_INSERTION
    @Exam_Name ='OOPExam',
    @Exam_Date ='2026-02-01', 
    @Exam_Duration =2,
    @New_Exam_ID = @ExamId OUTPUT;

--SELECT @ExamId AS ExamId;

-- TEST SELECTION
EXEC EXAM_SELECTION @EXAM_ID = @ExamId

-- TEST UPDATE 
EXEC EXAM_UPDATE @EXAM_id = @ExamId ,@Exam_Name='C++'

EXEC EXAM_SELECTION @EXAM_ID = @ExamId

--TEST DELETE
EXEC EXAM_DELETION @EXAM_ID = @ExamId

--select * from Exam
----------------------------------------------------------------------------------------------------------------------
--Exam Generation
CREATE PROC EXAM_GENERATION @CRS_NAME VARCHAR(50),@TF_NUM INT,@MCQ_NUM INT,@DTE DATE,@Duration INT
WITH ENCRYPTION
AS
BEGIN
BEGIN TRY

   DECLARE @Crs_ID INT;  
   IF EXISTS (SELECT * FROM Course WHERE @CRS_NAME = Course_Name)
   BEGIN
      SELECT @Crs_ID = Id FROM Course WHERE Course_Name = @CRS_NAME;
	  DECLARE @Exam_ID INT;  
      EXEC EXAM_INSERTION @CRS_NAME, @DTE, @Duration,@New_Exam_ID = @Exam_ID OUTPUT;
      --return examid
	  SELECT @Exam_ID 
      DECLARE @SelectedQuestions TABLE (Question_Id INT); --temp

        -- TF Questions
        INSERT INTO @SelectedQuestions(Question_Id)
        EXEC GET_RANDOM_TF_QUESTIONS
            @COURSE_ID = @Crs_ID,
            @TF_NUM = @TF_NUM;

        -- MCQ Questions
        INSERT INTO @SelectedQuestions (Question_Id)
        EXEC GET_RANDOM_MCQ_QUESTIONS
            @COURSE_ID = @Crs_ID,
            @MCQ_NUM = @MCQ_NUM;
        --SELECT * FROM @SelectedQuestions;
        IF EXISTS (SELECT 1 FROM @SelectedQuestions)
        BEGIN
            INSERT INTO Exam_Question (Exam_Id, Question_Id)
            SELECT @Exam_ID, Question_Id
            FROM @SelectedQuestions;
        END
        ELSE
        BEGIN
            RAISERROR('No questions were selected for this exam.',16,1);
        END

   END
END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
-------------------------------------------------------------------------------------------------------------
CREATE PROC GET_RANDOM_TF_QUESTIONS
    @COURSE_ID INT,
    @TF_NUM INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        SELECT TOP (@TF_NUM)
            Question_Id
        FROM Question q
        JOIN TrueFalse_Question tf
            ON q.Question_Id = tf.QuestionTF_Id
        WHERE q.Course_Id = @COURSE_ID
        ORDER BY NEWID();
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
-------------------------------------------------
CREATE PROC GET_RANDOM_MCQ_QUESTIONS
    @COURSE_ID INT,
    @MCQ_NUM INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        SELECT TOP (@MCQ_NUM)
            Question_Id
        FROM Question q
        JOIN MCQ_Question mq
            ON q.Question_Id = mq.QuestionMCQ_Id
        WHERE q.Course_Id = @COURSE_ID
        ORDER BY NEWID();
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
-------------------------------------------------------------------------------------------------------------
--StudentAnswers is the SP(STUDENT_QUESTION_EXAM_INSERTION)
-------------------------------------------------------------------------------------------------------------
--EXAM CORRECTION
GO
ALter PROC EXAM_CORRECTION
    @E_ID INT,
    @S_NAME VARCHAR(150)
WITH ENCRYPTION
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
       
        IF NOT EXISTS (SELECT 1 FROM Exam WHERE Exam_Id = @E_ID)
            RAISERROR ('Exam not found.', 16, 1);

        
        DECLARE @S_ID INT;

        SELECT @S_ID = Id
        FROM Student
        WHERE CONCAT(FName, ' ', LName) = @S_NAME;

        IF @S_ID IS NULL
            RAISERROR ('Student not found.', 16, 1);

       
        IF OBJECT_ID('tempdb..#StudentAnswers') IS NOT NULL
            DROP TABLE #StudentAnswers;

       
        CREATE TABLE #StudentAnswers
        (Student_ID INT,Exam_ID INT,Question_ID INT,Student_Answer VARCHAR(200),Student_Grade INT);

       
        INSERT INTO #StudentAnswers
        EXEC STUDENT_QUESTION_EXAM_SELECTION @S_ID = @S_ID,@E_ID = @E_ID,@Q_ID = NULL;

       
        DECLARE @TotalStudentGrade INT;

        SELECT @TotalStudentGrade = ISNULL(SUM(Student_Grade), 0)
        FROM #StudentAnswers;

       
        EXEC STUDENT_EXAM_UPDATE
            @Student_ID = @S_ID,
            @Exam_ID = @E_ID,
            @Total_Grade = @TotalStudentGrade;

       
        DECLARE @TotalExamGrade INT;

        SELECT @TotalExamGrade = ISNULL(SUM(Q.Grade), 0)
        FROM Question Q
        JOIN #StudentAnswers SA
            ON Q.Question_Id = SA.Question_ID;

       
        DECLARE @Percentage DECIMAL(5,2);

        SET @Percentage =
            CASE 
                WHEN @TotalExamGrade = 0 THEN 0
                ELSE (@TotalStudentGrade * 100.0 / @TotalExamGrade)
            END;

       
        SELECT @Percentage AS Percentage;

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO




-- TEST
EXEC EXAM_GENERATION @CRS_NAME ='Frontend Development',@TF_NUM= 5,@MCQ_NUM= 7,@DTE= '2/5/2026',@Duration= 2
-- [dbo].[STUDENT_EXAM_INSERTION] @Student_ID=2,@Exam_ID=19,@TotalGrade=0
EXEC EXAM_CORRECTION @E_ID = 19,@S_NAME = 'Yara Mostafa';

