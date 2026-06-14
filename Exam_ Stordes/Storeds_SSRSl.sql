---Report 1 student info by deptID
alter PROCEDURE GetStudentsByDepartment
    @Dep_ID VARCHAR(50)
AS
BEGIN
    SELECT S.St_ID, S.F_Name, S.L_Name, S.City, S.DateOfBirth, D.Dep_Name
    FROM dbo.Student S
    JOIN dbo.Department D ON S.Dep_ID = D.Dep_ID
    WHERE S.Dep_ID = @Dep_ID;
END

EXEC GetStudentsByDepartment @Dep_ID = "T001"

------------------------------------------------------------
---report 2 get student grade by stID
CREATE PROCEDURE GetStudentGrades
    @St_ID INT
AS
BEGIN
    SELECT C.Crs_Name, SUM(SE.Question_Grade) AS Total_Grade
    FROM Student_Exam SE
    JOIN Exam E ON SE.Exam_ID = E.Exam_ID
    JOIN Course C ON E.Crs_ID = C.Crs_ID
    WHERE SE.St_ID = @St_ID
    GROUP BY C.Crs_Name;
END

EXEC GetStudentGrades @St_ID=74


--------------------------------------------------------
------report 3 get courses &number of students by insID
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


----------------------------------------------------
---report 4 get topics in cources 

alter PROCEDURE GetCourseTopics
    @Crs_ID VARCHAR(50)
AS
BEGIN
    SELECT t.Topic ,t.Crs_ID
    FROM dbo.Topics t
    WHERE T.Crs_ID = @Crs_ID;
END


EXEC GetCourseTopics @Crs_ID = "C001"



-------------------------------------------
---report 5 Takes exam number and returns the questions in it and choices
CREATE OR ALTER PROCEDURE GetExamQuestionsWithChoices
    @Exam_ID INT
AS
BEGIN
    SELECT 
        Q.Q_ID,
        Q.Question,
        C.Choice_ID,
        C.Choice_Value
    FROM Exam_Questions EQ
    INNER JOIN Questions Q 
        ON EQ.Q_ID = Q.Q_ID
    INNER JOIN Questions_Choices QC 
        ON Q.Q_ID = QC.Q_ID
    INNER JOIN Choices C 
        ON QC.Choice_ID = C.Choice_ID
    WHERE EQ.Exam_ID = @Exam_ID
    ORDER BY Q.Q_ID, C.Choice_ID;
END;



EXEC GetExamQuestionsWithChoices @Exam_ID = 1001;



-----------------------------------------------

---report 6 Takes exam number and student ID, returns questions and student answers

CREATE PROCEDURE GetExamQuestionsWithStudentAnswers
    @Exam_ID INT,
    @St_ID INT
AS
BEGIN
    SELECT 
        Q.Q_ID,
        Q.Question,
        C.Choice_ID AS Student_Choice_ID,
        C.Choice_Value AS Student_Answer
    FROM Exam_Questions EQ
    INNER JOIN Questions Q 
        ON EQ.Q_ID = Q.Q_ID
    LEFT JOIN Student_Exam SE 
        ON SE.Q_ID = Q.Q_ID 
        AND SE.Exam_ID = @Exam_ID 
        AND SE.St_ID = @St_ID
    LEFT JOIN Choices C 
        ON SE.Choice_ID = C.Choice_ID
    WHERE EQ.Exam_ID = @Exam_ID
    ORDER BY Q.Q_ID;
END;


-------------------------------------
EXEC GetExamQuestionsWithStudentAnswers @Exam_ID = 1001, @St_ID = 74;