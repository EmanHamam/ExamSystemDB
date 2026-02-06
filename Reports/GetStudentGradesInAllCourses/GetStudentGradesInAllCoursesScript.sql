
CREATE PROCEDURE GetTotalExamGrade
    @Exam_ID INT,
    @TotalExamGrade INT OUTPUT
AS
BEGIN
    SELECT 
        @TotalExamGrade = SUM(Q.Grade)
    FROM Exam_Question EQ
    INNER JOIN Question Q
        ON EQ.Question_ID = Q.Question_ID
    WHERE EQ.Exam_ID = @Exam_ID;
END;

----------------------------------

ALTER PROC GetStudentGradesInAllCourses
    @Student_ID INT
WITH ENCRYPTION
AS
BEGIN
    BEGIN TRY
        DECLARE @EXAMID INT;
        DECLARE @Total INT;

        SELECT TOP 1 
            @EXAMID = SE.Exam_Id
        FROM Student_Exam SE
        WHERE SE.Student_Id = @Student_ID;

        IF @EXAMID IS NULL
        BEGIN
            THROW 50001, 'No exam found for the given student ID.', 1;
        END

        EXEC GetTotalExamGrade 
            @Exam_ID = @EXAMID,
            @TotalExamGrade = @Total OUTPUT;

        IF @Total IS NULL OR @Total = 0
        BEGIN
            THROW 50002, 'Total exam grade is invalid or zero.', 1;
        END

        SELECT 
            C.Course_Name,
            @Total AS [Total Exam Grade],
            SE.Total_Grade AS [Total Student Grade],
            CAST(
                SE.Total_Grade * 100.0 / @Total 
                AS DECIMAL(5,2)
            ) AS Percentage
        FROM Exam E
        INNER JOIN Student_Exam SE 
            ON E.Exam_Id = SE.Exam_Id
        INNER JOIN Course C 
            ON C.Id = E.Course_Id
        WHERE SE.Student_Id = @Student_ID;

    END TRY
    BEGIN CATCH
        DECLARE 
            @ErrorMessage NVARCHAR(4000),
            @ErrorSeverity INT,
            @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (
            'GetStudentGradesInAllCourses failed: %s',
            @ErrorSeverity,
            @ErrorState,
            @ErrorMessage
        );
    END CATCH
END;


GetStudentGradesInAllCourses 1














