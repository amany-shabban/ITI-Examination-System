CREATE DATABASE ITI_G_P

USE ITI_G_P

-----------------------------------------------------------------------
-- DEPARTMENT TABLE

CREATE TABLE Department (
    Dep_ID INT PRIMARY KEY IDENTITY(1,1),
    Dep_Name VARCHAR(40) NOT NULL,
    Duration INT  CHECK (Duration > 0)
)

------------------------------------------------------------------------
-- INSTRUCTOR TABLE

CREATE TABLE Instructor (
    Ins_ID INT PRIMARY KEY IDENTITY(1,1),
    F_Name VARCHAR(30) NOT NULL,
    L_Name VARCHAR(30) NOT NULL,
    Phone VARCHAR(15) NOT NULL UNIQUE,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    City VARCHAR(30),
    Salary DECIMAL(8,2) CHECK (Salary >= 0)
)

-----------------------------------------------------------------------
-- STUDENT TABLE

CREATE TABLE Student (
    St_ID INT PRIMARY KEY IDENTITY(1,1),
    F_Name VARCHAR(30) NOT NULL,
    L_Name VARCHAR(30) NOT NULL,
    DateOfBirth DATE,
    Phone VARCHAR(15) UNIQUE,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    City VARCHAR(30),
    Email VARCHAR(50) UNIQUE,
    Password VARCHAR(20) NOT NULL,
    Dep_ID INT NOT NULL,
    CONSTRAINT FK_Student_Department FOREIGN KEY (Dep_ID) 
        REFERENCES Department(Dep_ID) ON DELETE CASCADE ON UPDATE CASCADE
)

-----------------------------------------------------------------------
-- COURSE TABLE

CREATE TABLE Course (
    Crs_ID INT PRIMARY KEY IDENTITY(1,1),
    Crs_Name VARCHAR(50) NOT NULL,
    Hours INT CHECK (Hours > 0)
)

-----------------------------------------------------------------------
-- COURSE_DEPARTMENT TABLE

CREATE TABLE Course_Department (
    Crs_ID INT,
    Dep_ID INT,
    PRIMARY KEY (Crs_ID, Dep_ID),
    CONSTRAINT FK_CourseDept_Course FOREIGN KEY (Crs_ID) 
        REFERENCES Course(Crs_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_CourseDept_Department FOREIGN KEY (Dep_ID) 
        REFERENCES Department(Dep_ID) ON DELETE CASCADE ON UPDATE CASCADE
)

-----------------------------------------------------------------------
-- COURSE_INSTRUCTOR TABLE

CREATE TABLE Course_Instructor (
    Crs_ID INT,
    Ins_ID INT,
    PRIMARY KEY (Crs_ID, Ins_ID),
    CONSTRAINT FK_CourseIns_Course FOREIGN KEY (Crs_ID) 
        REFERENCES Course(Crs_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_CourseIns_Instructor FOREIGN KEY (Ins_ID) 
        REFERENCES Instructor(Ins_ID) ON DELETE CASCADE ON UPDATE CASCADE
)

----------------------------------------------------------------------- 
-- STUDENT_COURSE TABLE

CREATE TABLE Student_Course (
    St_ID INT,
    Crs_ID INT,
    PRIMARY KEY (St_ID, Crs_ID),
    CONSTRAINT FK_StudentCourse_Student FOREIGN KEY (St_ID) 
        REFERENCES Student(St_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_StudentCourse_Course FOREIGN KEY (Crs_ID) 
        REFERENCES Course(Crs_ID) ON DELETE CASCADE ON UPDATE CASCADE
)

-----------------------------------------------------------------------
-- TYPES TABLE

CREATE TABLE Types (
    T_ID INT PRIMARY KEY IDENTITY(1,1),
    Type VARCHAR(30)
)

-----------------------------------------------------------------------
-- TOPICS TABLE

CREATE TABLE Topics (
    Topic_ID INT PRIMARY KEY IDENTITY(1,1),
    Topic VARCHAR(100) NOT NULL,
    Crs_ID INT NOT NULL,
    CONSTRAINT FK_CourseTopics_Course FOREIGN KEY (Crs_ID) 
        REFERENCES Course(Crs_ID) ON DELETE CASCADE ON UPDATE CASCADE
)

-----------------------------------------------------------------------
-- EXAM TABLE

CREATE TABLE Exam (
    Exam_ID INT PRIMARY KEY IDENTITY(1,1),
    Exam_Name VARCHAR(50),
    Exam_Duration INT CHECK (Exam_Duration > 0),
    Exam_Day DATE,
    Crs_ID INT NOT NULL,
    CONSTRAINT FK_Exam_Course FOREIGN KEY (Crs_ID) 
        REFERENCES Course(Crs_ID) ON DELETE CASCADE ON UPDATE CASCADE,
)

-----------------------------------------------------------------------
-- CHOICES TABLE

CREATE TABLE Choices (
    Choice_ID INT PRIMARY KEY IDENTITY(1,1),
    Choice_Value VARCHAR(255)
)

-----------------------------------------------------------------------
-- MODEL_ANSWER TABLE

CREATE TABLE Model_Answer (
    Model_Answer_ID INT PRIMARY KEY IDENTITY(1,1),
    Model_Answer VARCHAR(255)
)

-----------------------------------------------------------------------
-- QUESTIONS TABLE

CREATE TABLE Questions (
    Q_ID INT PRIMARY KEY IDENTITY(1,1),
    Question VARCHAR(255),                             
    Hours INT,                          
    Crs_ID INT NOT NULL,                 
    Model_Answer_ID INT UNIQUE,          
    T_ID INT NOT NULL,                    
    CONSTRAINT FK_Questions_Course FOREIGN KEY (Crs_ID)
        REFERENCES Course(Crs_ID) ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT FK_Questions_ModelAnswer FOREIGN KEY (Model_Answer_ID)
        REFERENCES Model_Answer (Model_Answer_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Questions_Types FOREIGN KEY (T_ID)
        REFERENCES Types(T_ID) ON DELETE CASCADE ON UPDATE CASCADE
)

-----------------------------------------------------------------------
-- EXAM_QUESTIONS TABLE 

CREATE TABLE Exam_Questions (
    Exam_ID INT,
    Q_ID INT
    PRIMARY KEY (Exam_ID, Q_ID),
    CONSTRAINT FK_ExamQuestions_Exam FOREIGN KEY (Exam_ID) 
        REFERENCES Exam(Exam_ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_ExamQuestions_Question FOREIGN KEY (Q_ID) 
        REFERENCES Questions(Q_ID) ON DELETE NO ACTION ON UPDATE NO ACTION
)

-----------------------------------------------------------------------
-- QUESTIONS_CHOICES TABLE

CREATE TABLE Questions_Choices (
    Q_ID INT,
    Choice_ID INT,
    PRIMARY KEY (Q_ID, Choice_ID),
    CONSTRAINT FK_QuestionsChoices_Question FOREIGN KEY (Q_ID) 
        REFERENCES Questions(Q_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_QuestionsChoices_Choice FOREIGN KEY (Choice_ID) 
        REFERENCES Choices(Choice_ID) ON DELETE CASCADE ON UPDATE CASCADE
)

-----------------------------------------------------------------------
-- STUDENT_EXAM TABLE 

CREATE TABLE Student_Exam (
    St_ID INT,
    Exam_ID INT,
    Q_ID INT,
    St_Ans VARCHAR(255),
    Model_Answer_ID INT NOT NULL,
    Question_Grade DECIMAL(5,2) DEFAULT 0 CHECK (Question_Grade >= 0),
    Exam_Day DATE,
    PRIMARY KEY (St_ID, Exam_ID, Q_ID),
    CONSTRAINT FK_StudentExam_Student FOREIGN KEY (St_ID) 
        REFERENCES Student(St_ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_StudentExam_Exam FOREIGN KEY (Exam_ID) 
        REFERENCES Exam(Exam_ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_StudentExam_Question FOREIGN KEY (Q_ID) 
        REFERENCES Questions(Q_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_StudentExam_ModelAnswer FOREIGN KEY (Model_Answer_ID) 
        REFERENCES Model_Answer(Model_Answer_ID) ON DELETE NO ACTION ON UPDATE NO ACTION
)

-----------------------------------------------------------------------
-- COMPANY TABLE

CREATE TABLE Company (
    Company_ID INT PRIMARY KEY IDENTITY(1,1),
    Company_Name VARCHAR(50)
)

----------------------------------------------------------------------
-- STUDENT_COMPANY TABLE

CREATE TABLE Student_Company (
    St_ID INT,
    Company_ID INT,
    Position VARCHAR(30),
    PRIMARY KEY (St_ID, Company_ID),
    CONSTRAINT FK_StudentCompany_Student FOREIGN KEY (St_ID) 
        REFERENCES Student(St_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_StudentCompany_Company FOREIGN KEY (Company_ID) 
        REFERENCES Company(Company_ID) ON DELETE CASCADE ON UPDATE CASCADE
)

-----------------------------------------------------------------------
-- CERTIFICATE TABLE

CREATE TABLE Certificate (
    Certificate_ID INT PRIMARY KEY IDENTITY(1,1),
    Certificate_Course VARCHAR(50),
    Certificate_Source VARCHAR(50)
)

-----------------------------------------------------------------------
-- STUDENT_CERTIFICATE TABLE

CREATE TABLE Student_Certificate (
    St_ID INT,
    Certificate_ID INT,
    PRIMARY KEY (St_ID, Certificate_ID),
    CONSTRAINT FK_StudentCertificate_Student FOREIGN KEY (St_ID) 
        REFERENCES Student(St_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_StudentCertificate_Certificate FOREIGN KEY (Certificate_ID) 
        REFERENCES Certificate(Certificate_ID) ON DELETE CASCADE ON UPDATE CASCADE
)
