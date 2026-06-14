select * from Student_Course
where Crs_ID = 'C051'



----#####################################################-------------------

-- this table tack  all Student Answer in Exam

CREATE TYPE StudentAnswers AS TABLE
(
    Q_ID INT,
    Choice_ID INT
);

-- Stored tack exam_id , Student_Id and All Srudent Answer then Insert into Student_Exam table

CREATE PROCEDURE InsertStudent_ExamAnswers
    @St_ID INT,
    @Exam_ID INT,
    @Answers StudentAnswers READONLY
AS
BEGIN

    INSERT INTO Student_Exam (St_ID, Exam_ID, Q_ID, Choice_ID, Exam_Day)
    SELECT @St_ID, @Exam_ID, Q_ID, Choice_ID, GETDATE()
    FROM @Answers;
END;

--------------------------------------
DECLARE @MyAnswers StudentAnswers;

INSERT INTO @MyAnswers (Q_ID, Choice_ID)
VALUES (751, 7511), (752, 7522), (753, 7522), (756, 7563),(758,7584),(759,7591), (760,7601),(762,7621),(763, 7632), (765,7652);

EXEC InsertStudent_ExamAnswers
    @St_ID = 9,
    @Exam_ID = 53,
    @Answers = @MyAnswers;

    ----------------------------------
select* from  Student_Exam
where St_ID=9