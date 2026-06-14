CREATE PROCEDURE Exam_Correction
    @St_ID INT,       -- Student ID
    @Exam_ID INT      -- Exam ID
AS
BEGIN
    SET NOCOUNT ON;

    --  Update Question_Grade for each question
    -- If the student's choice matches the model answer → grade = 1, otherwise 0
    UPDATE SE
    SET SE.Question_Grade = 
        CASE 
            WHEN SE.Choice_ID = Q.Model_Answer_ID THEN 1
            ELSE 0
        END
    FROM Student_Exam SE
    INNER JOIN Questions Q ON SE.Q_ID = Q.Q_ID
    WHERE SE.St_ID = @St_ID
      AND SE.Exam_ID = @Exam_ID;

    --  Calculate the total grade for this exam
    DECLARE @TotalGrade INT;

    SELECT @TotalGrade = SUM(SE.Question_Grade)
    FROM Student_Exam SE
    WHERE SE.St_ID = @St_ID
      AND SE.Exam_ID = @Exam_ID;

    --  Return the total grade
    SELECT 
        @St_ID AS Student_ID,
        @Exam_ID AS Exam_ID,
        @TotalGrade AS Total_Grade;
END;

-------------------------------------
EXEC Exam_Correction 
    @St_ID = 9, 
    @Exam_ID = 53;
