

USE ITI_G_P;

-- Insert random 1 to 3 Certificate for each Student

--DELETE FROM dbo.Student_Certificate;

--DBCC CHECKIDENT ('Student_Certificate', RESEED, 0); 

INSERT INTO Student_Certificate (St_ID, Certificate_ID)
SELECT 
    S.St_ID,
    C.Certificate_ID
FROM Student S
CROSS APPLY (
    SELECT TOP (ABS(CHECKSUM(CHECKSUM(NEWID()) ^ S.St_ID)) % 3 + 1)  -- generate randem number of Certificate 1to 3 certificate
        Certificate_ID
    FROM Certificate
    ORDER BY NEWID()
) AS C
WHERE NOT EXISTS (
    SELECT 1 
    FROM Student_Certificate SC
    WHERE SC.St_ID = S.St_ID AND SC.Certificate_ID = C.Certificate_ID
);


SELECT TOP 20 * 
FROM Student_Certificate
ORDER BY St_ID;

------------------------------------------

INSERT INTO Company (Company_Name)
VALUES ('Freelance');

---------------------------------------------------------
DELETE FROM dbo.Student_Company;

---   GET the Company_ID of the "Freelance" company
DECLARE @FreelanceCompanyID INT = (
    SELECT Company_ID 
    FROM Company 
    WHERE Company_Name = 'Freelance'
);

----------------------------------------------------------------------------------------------
---- Randomly select 8,000 Unique students to work in companies
--  These students will be assigned to random companies (not Freelance)
--  with position = 'Junior Developer'
IF OBJECT_ID('tempdb..#StudentInCompanies') IS NOT NULL DROP TABLE #StudentInCompanies;

SELECT TOP 8000 St_ID
INTO #StudentInCompanies
FROM Student
ORDER BY NEWID();   -- random 8000 students

------------------------------------------------------------
--  STEP 4: Assign those 8,000 students to random (non-Freelance) companies
------------------------------------------------------------
INSERT INTO Student_Company (St_ID, Company_ID, Position)
SELECT 
    S.St_ID,
    C.Company_ID,
    'Junior Developer'
FROM #StudentInCompanies S
CROSS APPLY (
    SELECT TOP 1 Company_ID
    FROM Company
    WHERE Company_Name <> 'Freelance'
    ORDER BY NEWID()
) AS C;

------------------------------------------------------------
--  STEP 5: Assign the remaining 2,000 students to Freelance company
------------------------------------------------------------
IF OBJECT_ID('tempdb..#Freelancers') IS NOT NULL DROP TABLE #Freelancers;

-- select students NOT already in Student_Company (not just in #temp)
SELECT St_ID
INTO #Freelancers
FROM Student
WHERE St_ID NOT IN (SELECT St_ID FROM Student_Company);

-- now insert them as Freelancers
INSERT INTO Student_Company (St_ID, Company_ID, Position)
SELECT 
    F.St_ID,
    @FreelanceCompanyID,
    'Freelancer'
FROM #Freelancers F;

------------------------------------------------------------


------------------------------------------------------------
--  Check distribution (optional)
------------------------------------------------------------
SELECT COUNT(*) AS NumberOfStudents
FROM Student_Company

SELECT Position, COUNT(*) AS NumberOfStudents
FROM Student_Company
GROUP BY Position;

--------------------------------------------------------------------------
-----------------------------------------------
DELETE FROM dbo.Student_Course;


INSERT INTO Student_Course (St_ID, Crs_ID)
SELECT s.St_ID, cd.Crs_ID
FROM Student s
JOIN Course_Department cd
    ON s.Dep_ID = cd.Dep_ID
WHERE NOT EXISTS (
    SELECT 1 
    FROM Student_Course sc
    WHERE sc.St_ID = s.St_ID 
      AND sc.Crs_ID = cd.Crs_ID
);
------------------------------------------------------------------------
------------------------------------------------------------------------------

--: Clear any existing data in Course_Instructor
DELETE FROM Course_Instructor;

-- Distribute courses among instructors:
-- Each instructor teaches at least one course.
-- Remaining courses are randomly assigned so some instructors teach two.

;WITH InstructorList AS (
    SELECT Ins_ID, ROW_NUMBER() OVER (ORDER BY Ins_ID) AS RowNum
    FROM Instructor
),
CourseList AS (
    SELECT Crs_ID, ROW_NUMBER() OVER (ORDER BY Crs_ID) AS RowNum
    FROM Course
)
INSERT INTO Course_Instructor (Crs_ID, Ins_ID)
SELECT c.Crs_ID, i.Ins_ID
FROM InstructorList i
JOIN CourseList c
    ON c.RowNum = i.RowNum;

INSERT INTO Course_Instructor (Crs_ID, Ins_ID)
SELECT c.Crs_ID, i.Ins_ID
FROM Course c
JOIN Instructor i ON ABS(CHECKSUM(NEWID())) % 120 + 1 = i.Ins_ID
WHERE c.Crs_ID NOT IN (
    SELECT Crs_ID FROM Course_Instructor
);

--------------------------------------------------------------------------------------------