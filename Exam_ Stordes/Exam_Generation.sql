ALTER PROCEDURE Generate_Exam
    @Crs_ID varchar(50),
    @NumTF INT,
    @NumMCQ INT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️- Determine Range of Questions for each  Question Type
    IF @NumTF > 5 SET @NumTF = 5;
    IF @NumMCQ > 15 SET @NumMCQ = 15;

    DECLARE @Exam_ID INT,
            @Exam_Name VARCHAR(100),
            @CourseName VARCHAR(100),
            @Exam_Duration INT = 60; 

    -- 2️ Get course name 
    SELECT @CourseName = Crs_Name 
    FROM Course 
    WHERE Crs_ID = @Crs_ID;

    -- 3️ Generate Exam name with course name
    SET @Exam_Name = CONCAT(@CourseName, '_Exam');

    -- 4️ insert previous data in  Exam table
    INSERT INTO Exam (Exam_Name, Exam_Duration, Exam_Day, Crs_ID)
    VALUES (@Exam_Name, @Exam_Duration, GETDATE(), @Crs_ID);

    -- 5️⃣ Generate Exam Noumber
    SET @Exam_ID = SCOPE_IDENTITY();

    -- 6️ select number of  Multiple Choice Questions (T_ID = 1)
    INSERT INTO Exam_Questions (Exam_ID, Q_ID)
    SELECT TOP (@NumMCQ) @Exam_ID, Q_ID
    FROM Questions
    WHERE Crs_ID = @Crs_ID AND T_ID = 1
    ORDER BY NEWID();

    -- 7️ select number of True/False Questions (T_ID = 2)
    INSERT INTO Exam_Questions (Exam_ID, Q_ID)
    SELECT TOP (@NumTF) @Exam_ID, Q_ID
    FROM Questions
    WHERE Crs_ID = @Crs_ID AND T_ID = 2
    ORDER BY NEWID();

    -- Display check massage
    PRINT CONCAT('Exam "', @Exam_Name, '" created successfully with ID ', @Exam_ID);
END;
GO


----------------------------------------

----------------------------------------

EXEC Generate_Exam 
    @Crs_ID = "C017", 
    @NumTF = 3, 
    @NumMCQ = 7;

    ----------------------------------------
SELECT *FROM dbo.Exam
WHERE Exam_ID = 1001

SELECT *FROM dbo.Exam_Questions
WHERE Exam_ID = 1001

----------------------------------------
EXEC Generate_Exam 
    @Crs_ID = "C001", 
    @NumTF = 4, 
    @NumMCQ = 8;


SELECT *FROM dbo.Exam
WHERE Exam_ID = 1002

SELECT *FROM dbo.Exam_Questions
WHERE Exam_ID = 1002


----------------------------------------
EXEC Generate_Exam 
    @Crs_ID = "C051", 
    @NumTF = 3, 
    @NumMCQ = 7;


SELECT *FROM dbo.Exam_Questions
WHERE Exam_ID = 53

--------------------------------------------
select ch.* from Choices  ch, Questions_Choices qc
where ch.Choice_ID = qc.Choice_ID and qc.Q_ID = 753