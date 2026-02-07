CREATE OR ALTER PROCEDURE SP_StudentExamSummary
    @Student_Id INT,
    @Exam_Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        -- Student full name
        s.FName + ' ' + s.LName AS Student_Full_Name,

        -- Track name
        t.Track_Name,

        -- Exam name
        e.Exam_Name,

        -- Total grade
        se.Total_Grade

    FROM Student s
    LEFT JOIN Track t
        ON s.Track_Id = t.Id

    LEFT JOIN Student_Exam se
        ON se.Student_Id = s.Id
       AND se.Exam_Id = @Exam_Id

    LEFT JOIN Exam e
        ON e.Exam_Id = @Exam_Id

    WHERE s.Id = @Student_Id;
END;
GO