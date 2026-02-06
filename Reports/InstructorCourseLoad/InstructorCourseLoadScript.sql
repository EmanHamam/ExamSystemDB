CREATE PROC AllTeachedCoursesByInstructor
    @Instructor_Id INT
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS ( SELECT 1 FROM Instructor WHERE Instructor_Id = @Instructor_Id)
        BEGIN
            RAISERROR('Instructor does not exist.', 16, 1);
            RETURN;
        END
        SELECT 
            C.Course_Name,
            COUNT(DISTINCT S.Id) AS Total_Number_Of_Students
        FROM INSTRUCTOR_COURSE IC
        INNER JOIN Instructor I
            ON I.Instructor_Id = IC.INSTRUCTOR_ID
        INNER JOIN Course C
            ON C.Id = IC.COURSE_ID
        INNER JOIN Course_Track CT
            ON CT.Course_Id = IC.COURSE_ID
        INNER JOIN Student S
            ON S.Track_Id = CT.Track_Id
        WHERE I.Instructor_Id = @Instructor_Id
        GROUP BY C.Course_Name;
    END TRY
    BEGIN CATCH
        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage,
            ERROR_LINE() AS ErrorLine;
    END CATCH
END

AllTeachedCoursesByInstructor 1
