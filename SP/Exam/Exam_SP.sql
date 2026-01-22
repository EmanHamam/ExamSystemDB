--Exam SP
--Insert
CREATE PROC EXAM_INSERTION 
    @Exam_Id INT,
    @Exam_Name varchar(50),
    @Exam_Date DATE, 
    @Exam_Duration INT
WITH ENCRYPTION
AS
BEGIN
BEGIN TRY
    INSERT INTO EXAM (Exam_Id,Exam_Name,EXDate, Duration)
    VALUES (@Exam_Id,@Exam_Name,@Exam_Date,@Exam_Duration)
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
-- TEST INSERTION
EXEC EXAM_INSERTION
    @Exam_Id =101,
    @Exam_Name ='OOPExam',
    @Exam_Date ='2025-02-01', 
    @Exam_Duration =2;

-- TEST SELECTION
EXEC EXAM_SELECTION @EXAM_ID = 101

-- TEST UPDATE 
EXEC EXAM_UPDATE @EXAM_id = 101 ,@Exam_Name='C++'

EXEC EXAM_SELECTION @EXAM_ID = 101

--TEST DELETE
EXEC EXAM_DELETION @EXAM_ID = 101


--select * from Exam