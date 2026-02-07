USE [db38834]
GO

/****** Object:  StoredProcedure [dbo].[SP_StudentExamResult]    Script Date: 2/7/2026 7:12:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SP_StudentExamResult]
    @Exam_Id INT,
    @Student_Id INT
AS
BEGIN
    SET NOCOUNT ON;

    --  check if student took the exam
    IF NOT EXISTS (
        SELECT 1
        FROM Student_Exam
        WHERE Student_Id = @Student_Id
          AND Exam_Id = @Exam_Id
    )
    BEGIN
        -- Student did NOT take this exam → return nothing
        RETURN;
    END

    --  Student took the exam → return results
    SELECT
        q.Question_Id,
        q.Ques_Description AS Question,

        -- Correct Answer
        CASE 
            WHEN tf.QuestionTF_Id IS NOT NULL THEN
                CASE tf.Correct_Answer
                    WHEN 1 THEN 'True'
                    WHEN 0 THEN 'False'
                END
            ELSE ca.Option_text
        END AS Correct_Answer,

        -- Student Answer
        CASE
            WHEN tf.QuestionTF_Id IS NOT NULL THEN
                CASE sqe.Student_Answer
                    WHEN 1 THEN 'True'
                    WHEN 0 THEN 'False'
                END
            ELSE sa.Option_text
        END AS Student_Answer,

        CASE
            WHEN tf.QuestionTF_Id IS NOT NULL
                 AND sqe.Student_Answer = tf.Correct_Answer
                THEN 'Right'

            WHEN tf.QuestionTF_Id IS NULL
                 AND sqe.Student_Answer = ca.Option_Id
                THEN 'Right'

            ELSE 'Wrong'
        END AS Indicator,

        se.Total_Grade

    FROM Exam_Question eq
    JOIN Question q
        ON eq.Question_Id = q.Question_Id

    JOIN Student_Question_Exam sqe  
        ON sqe.Question_Id = q.Question_Id
       AND sqe.Exam_Id = @Exam_Id
       AND sqe.Student_Id = @Student_Id

    LEFT JOIN TrueFalse_Question tf
        ON q.Question_Id = tf.QuestionTF_Id

    LEFT JOIN MCQ_Question mq
        ON q.Question_Id = mq.QuestionMCQ_Id

    LEFT JOIN MCQ_Option ca
        ON mq.QuestionMCQ_Id = ca.Question_Id
       AND ca.Is_Correct = 1

    LEFT JOIN MCQ_Option sa
        ON sa.Option_Id = sqe.Student_Answer

    LEFT JOIN Student_Exam se
        ON se.Student_Id = @Student_Id
       AND se.Exam_Id = @Exam_Id

    WHERE eq.Exam_Id = @Exam_Id
    ORDER BY q.Question_Id;
END;
GO


