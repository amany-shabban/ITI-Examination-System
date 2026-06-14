-- Step 1: Drop the foreign key if it exists (to Model_Answer)
IF EXISTS (
    SELECT 1 FROM sys.foreign_keys 
    WHERE name = 'FK_StudentExam_ModelAnswer'
)
ALTER TABLE Student_Exam
DROP CONSTRAINT FK_StudentExam_ModelAnswer;

-- Step 2: Drop the wrong column (Model_Answer_ID)
IF EXISTS (
    SELECT 1 
    FROM sys.columns 
    WHERE Name = 'Model_Answer_ID' 
    AND Object_ID = Object_ID('Student_Exam')
)
ALTER TABLE Student_Exam
DROP COLUMN Model_Answer_ID;

-- Step 3: Add the correct column (Choice_ID)
ALTER TABLE Student_Exam
ADD Choice_ID INT NULL;

-- Step 4: Create the correct foreign key to Choices table
ALTER TABLE Student_Exam
ADD CONSTRAINT FK_StudentExam_Choices
FOREIGN KEY (Choice_ID) REFERENCES Choices(Choice_ID);

-------------------------------
ALTER TABLE Student_Exam
DROP COLUMN St_Ans;

-------------------------------------------------------------------

--- Create relationship  between Questions And Choices Table
ALTER TABLE Questions
ADD CONSTRAINT FK_Questions_ModelAnswer
FOREIGN KEY (Model_Answer_ID) REFERENCES Choices(Choice_ID);
