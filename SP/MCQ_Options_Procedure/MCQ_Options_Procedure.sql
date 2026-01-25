CREATE PROCEDURE Exam.InsertMCQOption
    @Question_ID INT,
    @Option_Text NVARCHAR(255),
    @Is_Correct BIT
with Encryption

AS
BEGIN
    INSERT INTO MCQ_Option (Question_ID, Option_Text, Is_Correct)
    VALUES (@Question_ID, @Option_Text, @Is_Correct);
END



Alter PROCEDURE Exam.UpdateMCQOption
    @Option_ID INT,
    @Option_Text NVARCHAR(255),
    @Is_Correct BIT
WITH ENCRYPTION
AS
BEGIN
    IF EXISTS (SELECT 1 FROM MCQ_Option WHERE Option_ID = @Option_ID)
    BEGIN
        UPDATE MCQ_Option
        SET Option_Text = @Option_Text,
            Is_Correct = @Is_Correct
        WHERE Option_ID = @Option_ID;
    END
    ELSE
    BEGIN
        PRINT 'Option with this ID does not exist.';
    END
END




Alter PROCEDURE Exam.DeleteMCQOption
    @Option_ID INT
WITH ENCRYPTION
AS
BEGIN
    IF EXISTS (SELECT 1 FROM MCQ_Option WHERE Option_ID = @Option_ID)
    BEGIN
        DELETE FROM MCQ_Option
        WHERE Option_ID = @Option_ID;
    END
    ELSE
    BEGIN
        PRINT 'Option with this ID does not exist.';
    END
END




create procedure Exam.MCQ_WithAllItsOptions
with Encryption
as Begin
	select  q.Ques_Description,McqO.Option_text,McqO.Is_Correct from MCQ_Option McqO
	JOIN Question Q
	on Q.Question_Id=McqO.Question_Id
End

Exam.MCQ_WithAllItsOptions
	

Create procedure Exam.QuestionWithItsOptions
		@Question_Id Int
with encryption
as
Begin
select  q.Ques_Description,McqO.Option_text,McqO.Is_Correct from MCQ_Option McqO
	JOIN Question Q
	on Q.Question_Id=McqO.Question_Id
	where McqO.Question_Id= @Question_Id

End

Exam.QuestionWithItsOptions 3
