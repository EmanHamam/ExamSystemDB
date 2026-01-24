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

--Run them in the same Batch
-- TEST INSERTION
declare @ExamId int 
EXEC EXAM_INSERTION
    @Exam_Name ='OOPExam',
    @Exam_Date ='2025-02-01', 
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
        INSERT INTO Exam_Question (Exam_Id, Question_Id)
        SELECT TOP (@TF_NUM)
            @Exam_ID,
            q.Question_Id
        FROM Question q
        JOIN TrueFalse_Question tf
            ON q.Question_Id = tf.QuestionTF_Id
        WHERE q.Course_Id = @Crs_ID
        ORDER BY NEWID();

        INSERT INTO Exam_Question (Exam_Id, Question_Id)
        SELECT TOP (@MCQ_NUM)
            @Exam_ID,
            q.Question_Id
        FROM Question q
        JOIN MCQ_Question mq
            ON q.Question_Id = mq.QuestionMCQ_Id
        WHERE q.Course_Id = @Crs_ID
        ORDER BY NEWID();
   END
END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END

