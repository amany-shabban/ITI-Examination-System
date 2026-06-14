
-- Exams Generated 1, 1002, 1003, 1004,1005
-- Courses C001, C017, C004, C005, C006
-- Correct rate   0.4, 0.5 , 0.6 0.6

EXEC Generate_Exam 
    @Crs_ID = "C050", 
    @NumTF = 5, 
    @NumMCQ = 15;

SELECT * FROM dbo.Exam 



 ------------############################################################----------------------------
 
 -- Change Exam NO  & Correction Rate

EXEC GenerateRandomAnswers @Exam_ID = 52,                           
                            @CorrectRate = 0.9;

--DELETE FROM dbo.Student_Exam
--WHERE Exam_ID = 14

/*SELECT Exam_ID FROM dbo.Student_Exam 
Group BY Exam_ID
ORDER BY Exam_ID*/


 ------------############################################################----------------------------

EXEC Correct_Exam @Exam_ID = 52;

SELECT Exam_ID, COUNT(DISTINCT St_ID) AS total_Student FROM dbo.Student_Exam
GROUP BY Exam_ID
ORDER BY Exam_ID 

 ----------------------------------------------

DECLARE @Exam_ID INT = 40;

SELECT 
    S.St_ID,
    S.F_Name + ' ' + S.L_Name AS Student_Name,
    SE.Exam_ID,
    SUM(SE.Question_Grade) AS Total_Grade
FROM Student_Exam SE
INNER JOIN Student S ON S.St_ID = SE.St_ID
WHERE SE.Exam_ID = @Exam_ID
GROUP BY S.St_ID, S.F_Name, S.L_Name, SE.Exam_ID
ORDER BY Total_Grade DESC; 