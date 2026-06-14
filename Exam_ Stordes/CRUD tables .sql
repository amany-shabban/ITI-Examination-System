-- Insert Student SP

ALTER PROCEDURE Insert_Student
  @F_Name VARCHAR(30),
  @L_Name VARCHAR(30),
  @DateOfBirth DATE,
  @Phone VARCHAR(15),
  @Gender CHAR(1),
  @City VARCHAR(30),
  @Email VARCHAR(50),
  @Password VARCHAR(20),
  @Dep_ID VARCHAR(50)
AS
BEGIN
  INSERT INTO dbo.Student
  (F_Name, L_Name, DateOfBirth, Phone, Gender, City, Email, Password, Dep_ID)
  VALUES (@F_Name, @L_Name, @DateOfBirth, @Phone, @Gender, @City, @Email, @Password, @Dep_ID);
END;
    
EXEC Insert_Student @F_Name ="Ali", @L_Name = "Hassan", @DateOfBirth = "2000-12-1",@Password = "kfjkdshjs" , @Dep_ID= "T001", @Phone = "1234567", @Gender="Male",@City="Minya", @Email="Student10001@gmail.com"

SELECT * FROM Student 
WHERE F_Name = 'Ali'

--##############################################################################

----- sp Select studentby id 

CREATE PROCEDURE Get_Student_ByID
  @St_ID INT
AS
BEGIN
  SELECT * 
  FROM dbo.Student
  WHERE St_ID = @St_ID;
END;

EXEC Get_Student_ByID @St_ID = 1

--##############################################################################

--sp get all student
CREATE PROCEDURE Get_All_Students
AS
BEGIN
  SELECT * FROM dbo.Student;
END;

EXEC Get_All_Students

--##############################################################################

---sp update student
CREATE PROCEDURE Update_Student
  @St_ID INT,
  @F_Name VARCHAR(30),
  @L_Name VARCHAR(30),
  @DateOfBirth DATE,
  @Phone VARCHAR(15),
  @Gender CHAR(1),
  @City VARCHAR(30),
  @Email VARCHAR(50),
  @Password VARCHAR(20),
  @Dep_ID INT
AS
BEGIN
  UPDATE dbo.Student
  SET 
      F_Name = @F_Name,
      L_Name = @L_Name,
      DateOfBirth = @DateOfBirth,
      Phone = @Phone,
      Gender = @Gender,
      City = @City,
      Email = @Email,
      Password = @Password,
      Dep_ID = @Dep_ID
  WHERE St_ID = @St_ID;
END;



---sp delete student 
CREATE PROCEDURE Delete_Student
  @St_ID INT
AS
BEGIN
  DELETE FROM dbo.Student
  WHERE St_ID = @St_ID;
END;


-----------------------------
---sp insert department 
CREATE PROCEDURE Insert_Department
  @Dep_Name VARCHAR(100),
  @Duration INT
AS
BEGIN
  INSERT INTO dbo.Department (Dep_Name, Duration)
  VALUES (@Dep_Name, @Duration);
END;



--sp update department
CREATE PROCEDURE Update_Department
  @Dep_ID INT,
  @Dep_Name VARCHAR(100),
  @Duration INT
AS
BEGIN
  UPDATE dbo.Department
  SET Dep_Name = @Dep_Name,
      Duration = @Duration
  WHERE Dep_ID = @Dep_ID;
END;




--sp select department 
CREATE PROCEDURE Get_Departments
AS
BEGIN
  SELECT Dep_ID, Dep_Name, Duration
  FROM dbo.Department;
END;




--sp delete department 
CREATE PROCEDURE Delete_Department
  @Dep_ID INT
AS
BEGIN
  DELETE FROM dbo.Department
  WHERE Dep_ID = @Dep_ID;
END;
--------------------------------------------
--sp insert course 
CREATE PROCEDURE Insert_Course
  @Crs_Name VARCHAR(100),
  @Hours INT
AS
BEGIN
  INSERT INTO dbo.Course (Crs_Name, Hours)
  VALUES (@Crs_Name, @Hours);
END;



---sp update course
CREATE PROCEDURE Update_Course
  @Crs_ID INT,
  @Crs_Name VARCHAR(100),
  @Hours INT
AS
BEGIN
  UPDATE dbo.Course
  SET Crs_Name = @Crs_Name,
      Hours = @Hours
  WHERE Crs_ID = @Crs_ID;
END;



----sp select course 
CREATE PROCEDURE Get_Courses
AS
BEGIN
  SELECT Crs_ID, Crs_Name, Hours
  FROM dbo.Course;
END;



--sp delete course 
CREATE PROCEDURE Delete_Course
  @Crs_ID INT
AS
BEGIN
  DELETE FROM dbo.Course
  WHERE Crs_ID = @Crs_ID;
END;

-----------------------------------------------------------------

-- sp insert instructor

CREATE PROCEDURE Insert_Instructor
  @F_Name VARCHAR(50),
  @L_Name VARCHAR(50),
  @Phone VARCHAR(15),
  @Gender CHAR(1),
  @City VARCHAR(50),
  @Salary DECIMAL(10,2)
AS
BEGIN
  INSERT INTO dbo.Instructor (F_Name, L_Name, Phone, Gender, City, Salary)
  VALUES (@F_Name, @L_Name, @Phone, @Gender, @City, @Salary);
END;
GO


-- sp SELECT instructor
CREATE PROCEDURE Get_Instructors
AS
BEGIN
  SELECT Ins_ID, F_Name, L_Name, Phone, Gender, City, Salary
  FROM dbo.Instructor;
END;
GO






-- sp UPDATE instructor
CREATE PROCEDURE Update_Instructor
  @Ins_ID INT,
  @F_Name VARCHAR(50),
  @L_Name VARCHAR(50),
  @Phone VARCHAR(15),
  @Gender CHAR(1),
  @City VARCHAR(50),
  @Salary DECIMAL(10,2)
AS
BEGIN
  UPDATE dbo.Instructor
  SET F_Name = @F_Name,
      L_Name = @L_Name,
      Phone = @Phone,
      Gender = @Gender,
      City = @City,
      Salary = @Salary
  WHERE Ins_ID = @Ins_ID;
END;
GO




-- sp DELETE instructor
CREATE PROCEDURE Delete_Instructor
  @Ins_ID INT
AS
BEGIN
  DELETE FROM dbo.Instructor
  WHERE Ins_ID = @Ins_ID;
END;
GO
--------------------------------------------------------
--sp generate exam 
CREATE PROCEDURE Insert_Exam
  @Exam_Name NVARCHAR(100),
  @Exam_Duration INT,
  @Exam_Day DATE,
  @Crs_ID INT
AS
BEGIN
  INSERT INTO dbo.Exam (Exam_Name, Exam_Duration, Exam_Day, Crs_ID)
  VALUES (@Exam_Name, @Exam_Duration, @Exam_Day, @Crs_ID);
END;
GO


-----sp update exam 
CREATE PROCEDURE Update_Exam
  @Exam_ID INT,
  @Exam_Name NVARCHAR(100),
  @Exam_Duration INT,
  @Exam_Day DATE,
  @Crs_ID INT
AS
BEGIN
  UPDATE dbo.Exam
  SET Exam_Name = @Exam_Name,
      Exam_Duration = @Exam_Duration,
      Exam_Day = @Exam_Day,
      Crs_ID = @Crs_ID
  WHERE Exam_ID = @Exam_ID;
END;
GO



--sp delete exam 
CREATE PROCEDURE Delete_Exam
  @Exam_ID INT
AS
BEGIN
  DELETE FROM dbo.Exam
  WHERE Exam_ID = @Exam_ID;
END;
GO

--sp get all exams 
CREATE PROCEDURE Get_All_Exams
AS
BEGIN
  SELECT Exam_ID, Exam_Name, Exam_Duration, Exam_Day, Crs_ID
  FROM dbo.Exam;
END;
GO


-------------------------------

--sp insert question 
CREATE PROCEDURE Insert_Question
  @Question NVARCHAR(255),
  @Hours INT,
  @Crs_ID INT,
  @Model_Answer_ID INT,
  @T_ID INT
AS
BEGIN
  INSERT INTO dbo.Questions (Question, Hours, Crs_ID, Model_Answer_ID, T_ID)
  VALUES (@Question, @Hours, @Crs_ID, @Model_Answer_ID, @T_ID);
END;
GO



--sp update question 
CREATE PROCEDURE Update_Question
  @Q_ID INT,
  @Question NVARCHAR(255),
  @Hours INT,
  @Crs_ID INT,
  @Model_Answer_ID INT,
  @T_ID INT
AS
BEGIN
  UPDATE dbo.Questions
  SET Question = @Question,
      Hours = @Hours,
      Crs_ID = @Crs_ID,
      Model_Answer_ID = @Model_Answer_ID,
      T_ID = @T_ID
  WHERE Q_ID = @Q_ID;
END;
GO



-----sp delete question 
CREATE PROCEDURE Delete_Question
  @Q_ID INT
AS
BEGIN
  DELETE FROM dbo.Questions
  WHERE Q_ID = @Q_ID;
END;
GO



--sp get all questions 
CREATE PROCEDURE Get_All_Questions
AS
BEGIN
  SELECT Q_ID, Question, Hours, Crs_ID, Model_Answer_ID, T_ID
  FROM dbo.Questions;
END;
GO


---------------------------------------------
  ---sp insert choise
  CREATE PROCEDURE Insert_Choice
  @Choice_Value NVARCHAR(255)
AS
BEGIN
  INSERT INTO Choices (Choice_Value)
  VALUES (@Choice_Value);
END;
GO




----sp update choise 
CREATE PROCEDURE Update_Choice
  @Choice_ID INT,
  @Choice_Value NVARCHAR(255)
AS
BEGIN
  UPDATE Choices
  SET Choice_Value = @Choice_Value
  WHERE Choice_ID = @Choice_ID;
END;
GO



----sp delete choise 
CREATE PROCEDURE Delete_Choice
  @Choice_ID INT
AS
BEGIN
  DELETE FROM Choices
  WHERE Choice_ID = @Choice_ID;
END;
GO


---sp select choise 
CREATE PROCEDURE GetAll_Choices
AS
BEGIN
  SELECT * FROM Choices;
END;
GO
-----------------------------------------------



--------------------
---sp select type 
CREATE PROCEDURE sp_SelectTypes
AS
BEGIN
    SELECT [T_ID], [Type]
    FROM [dbo].[Types];
END

----------------------------------------------

--sp insert model answer 
CREATE PROCEDURE sp_InsertModelAnswer
    @Model_Answer NVARCHAR(500)
AS
BEGIN
    INSERT INTO [dbo].[Model_Answer] ([Model_Answer])
    VALUES (@Model_Answer);
END



-- sp update model answer
CREATE PROCEDURE sp_UpdateModelAnswer
    @Model_Answer_ID INT,
    @Model_Answer NVARCHAR(500)
AS
BEGIN
    UPDATE [dbo].[Model_Answer]
    SET [Model_Answer] = @Model_Answer
    WHERE [Model_Answer_ID] = @Model_Answer_ID;
END



----sp select model answer by ID


CREATE PROCEDURE sp_SelectModelAnswerByID
    @Model_Answer_ID INT
AS
BEGIN
    SELECT [Model_Answer_ID], [Model_Answer]
    FROM [dbo].[Model_Answer]
    WHERE [Model_Answer_ID] = @Model_Answer_ID;
END



--------sp select all model answers 

CREATE PROCEDURE sp_SelectAllModelAnswers
AS
BEGIN
    SELECT [Model_Answer_ID], [Model_Answer]
    FROM [dbo].[Model_Answer];
END



---sp delete model answer 

CREATE PROCEDURE sp_DeleteModelAnswer
    @Model_Answer_ID INT
AS
BEGIN
    DELETE FROM [dbo].[Model_Answer]
    WHERE [Model_Answer_ID] = @Model_Answer_ID;
END

---------------------------------------------
---sp insert company
CREATE PROCEDURE sp_InsertCompany
    @Company_Name NVARCHAR(200)
AS
BEGIN
    INSERT INTO [dbo].[Company] ([Company_Name])
    VALUES (@Company_Name);
END


 ---- select all companies 
CREATE PROCEDURE sp_SelectAllCompanies
AS
BEGIN
    SELECT [Company_ID], [Company_Name]
    FROM [dbo].[Company];
END


---- select sp select company by id 
CREATE PROCEDURE sp_SelectCompanyByID
    @Company_ID INT
AS
BEGIN
    SELECT [Company_ID], [Company_Name]
    FROM [dbo].[Company]
    WHERE [Company_ID] = @Company_ID;
END




----sp update company 
CREATE PROCEDURE sp_UpdateCompany
    @Company_ID INT,
    @Company_Name NVARCHAR(200)
AS
BEGIN
    UPDATE [dbo].[Company]
    SET [Company_Name] = @Company_Name
    WHERE [Company_ID] = @Company_ID;
END



---sp delete company 

CREATE PROCEDURE sp_DeleteCompany
    @Company_ID INT
AS
BEGIN
    DELETE FROM [dbo].[Company]
    WHERE [Company_ID] = @Company_ID;
END

---------------------------------------------------------------------------
----sp insert certificate 
CREATE PROCEDURE InsertCertificate
    @Certificate_Course NVARCHAR(100),
    @Certificate_Source NVARCHAR(100)
AS
BEGIN
    INSERT INTO Certificate (Certificate_Course, Certificate_Source)
    VALUES (@Certificate_Course, @Certificate_Source);

    PRINT 'Certificate inserted successfully.';
END;

---sp delete certificate 
CREATE PROCEDURE DeleteCertificate
    @Certificate_ID INT
AS
BEGIN
    DELETE FROM Certificate
    WHERE Certificate_ID = @Certificate_ID;

    PRINT 'Certificate deleted successfully.';
END;






 





















