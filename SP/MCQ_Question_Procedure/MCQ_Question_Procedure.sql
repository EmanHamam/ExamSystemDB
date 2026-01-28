CREATE PROCEDURE InsertMCQQuestion
    @Question_ID INT
WITH ENCRYPTION
AS
BEGIN
    INSERT INTO MCQ_Question (QuestionMCQ_Id)
    VALUES (@Question_ID);
END


Alter PROCEDURE DeleteMCQQuestion
    @Question_ID INT
WITH ENCRYPTION
AS
BEGIN
    IF EXISTS (SELECT 1 FROM MCQ_Question WHERE QuestionMCQ_Id = @Question_ID)
    BEGIN
        DELETE FROM MCQ_Option
        WHERE Question_ID = @Question_ID;

        DELETE FROM MCQ_Question
        WHERE QuestionMCQ_Id = @Question_ID;
    END
    ELSE
    BEGIN
        PRINT 'MCQ question with this ID does not exist.';
    END
END


Create procedure MCQSWithTheCorrectAnswer
with Encryption
as 
Begin
		select Q.Ques_Description, McqO.Option_text from Question Q
		join MCQ_Question McqQ 
		on Q.Question_Id=McqQ.QuestionMCQ_Id
		join MCQ_Option McqO 
		on McqO.Question_Id=McqQ.QuestionMCQ_Id
		where McqO.Is_Correct=1 
End

MCQSWithTheCorrectAnswer


Create procedure MCQWithTheItsCorrectAnswer
			@Question_ID INT
with Encryption
as 
Begin
		select Q.Ques_Description, McqO.Option_text from Question Q
		join MCQ_Question McqQ 
		on Q.Question_Id=McqQ.QuestionMCQ_Id
		join MCQ_Option McqO 
		on McqO.Question_Id=McqQ.QuestionMCQ_Id
		where McqO.Is_Correct=1 and Q.Question_Id= @Question_ID
End

MCQWithTheItsCorrectAnswer 6



