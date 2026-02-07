CREATE PROCEDURE SP_GetTopicsByCourse
    @Course_Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        t.Id AS Topic_Id,
        t.Topic_Name
    FROM Topic t
    WHERE t.Course_Id = @Course_Id
    ORDER BY t.Topic_Name;
END;
GO