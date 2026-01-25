CREATE PROCEDURE Exam.InsertTrueFalseQuestion
    @Question_ID INT,
    @Correct_Answer BIT
with encryption
AS
BEGIN
    INSERT INTO TrueFalse_Question 
    VALUES (@Question_ID, @Correct_Answer);
END


Alter PROCEDURE Exam.UpdateTrueFalseAnswer
    @Question_ID INT,
    @Correct_Answer BIT
WITH ENCRYPTION
AS
BEGIN
    IF EXISTS (SELECT 1 FROM TrueFalse_Question WHERE QuestionTF_Id = @Question_ID)
    BEGIN
        UPDATE TrueFalse_Question
        SET Correct_Answer = @Correct_Answer
        WHERE QuestionTF_Id = @Question_ID;
    END
    ELSE
    BEGIN
        PRINT 'True/False question with this ID does not exist.';
    END
END



Alter PROCEDURE Exam.DeleteTrueFalseQuestion
    @Question_ID INT
WITH ENCRYPTION
AS
BEGIN
    IF EXISTS (SELECT 1 FROM TrueFalse_Question WHERE QuestionTF_Id = @Question_ID)
    BEGIN
        DELETE FROM TrueFalse_Question
        WHERE QuestionTF_Id = @Question_ID;
    END
    ELSE
    BEGIN
        PRINT 'True/False question with this ID does not exist.';
    END
END


create PROCEDURE Exam.TFQuestionsWithCorrectAnswer
With Encryption 
as
Begin
select Q.Ques_Description, TFQ.Correct_Answer from Question Q
join TrueFalse_Question TFQ 
on Q.Question_Id=TFQ.QuestionTF_Id
End


CREATE PROCEDURE Exam.TFQuestionWithCorrectAnswer
    @Question_Id INT
WITH ENCRYPTION
AS
BEGIN
    SELECT 
        Q.Ques_Description, 
        TFQ.Correct_Answer
    FROM Question Q
    JOIN TrueFalse_Question TFQ 
        ON Q.Question_Id = TFQ.QuestionTF_Id
    WHERE Q.Question_Id = @Question_Id;
END

