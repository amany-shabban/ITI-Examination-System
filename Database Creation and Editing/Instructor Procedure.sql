CREATE PROCEDURE GetInstructorCoursesStats
    @Ins_ID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        C.Crs_ID,
        C.Crs_Name,
        COUNT(DISTINCT SC.St_ID) AS Students_Count
    FROM Course_Instructor CI
    INNER JOIN Course C ON CI.Crs_ID = C.Crs_ID
    LEFT JOIN Student_Course SC ON C.Crs_ID = SC.Crs_ID
    WHERE CI.Ins_ID = @Ins_ID
    GROUP BY C.Crs_ID, C.Crs_Name;
END;

EXEC GetInstructorCoursesStats @Ins_ID = 6; 

SELECT * FROM dbo.Course_Instructor
ORDER BY Ins_ID;