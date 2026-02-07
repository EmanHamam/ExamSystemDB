CREATE PROCEDURE SP_GetExamQuestionsOptions
    @Exam_Id INT
AS
BEGIN
    SET NOCOUNT ON;
    -- MCQ 
    SELECT
        q.Question_Id,
        q.Ques_Description,
        o.Option_text,
        ROW_NUMBER() OVER (
            PARTITION BY q.Question_Id
            ORDER BY o.Option_Id
        ) AS Option_No
    FROM Exam_Question eq
    JOIN Question q 
        ON eq.Question_Id = q.Question_Id
    LEFT JOIN MCQ_Question mq 
        ON q.Question_Id = mq.QuestionMCQ_Id
    LEFT JOIN MCQ_Option o 
        ON mq.QuestionMCQ_Id = o.Question_Id
    WHERE eq.Exam_Id = @Exam_Id
      AND o.Option_text IS NOT NULL

    UNION ALL

    -- T option
    SELECT 
        q.Question_Id,
        q.Ques_Description,
        'True' AS Option_text,
        1 AS Option_No
    FROM Exam_Question eq
    JOIN Question q 
        ON eq.Question_Id = q.Question_Id
    JOIN TrueFalse_Question tf 
        ON q.Question_Id = tf.QuestionTF_Id
    WHERE eq.Exam_Id = @Exam_Id

    UNION ALL

    -- F option
    SELECT 
        q.Question_Id,
        q.Ques_Description,
        'False' AS Option_text,
        2 AS Option_No
    FROM Exam_Question eq
    JOIN Question q 
        ON eq.Question_Id = q.Question_Id
    JOIN TrueFalse_Question tf 
        ON q.Question_Id = tf.QuestionTF_Id
    WHERE eq.Exam_Id = @Exam_Id

    ORDER BY Question_Id, Option_No;
END;
GO