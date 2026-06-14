#  ITI Examination System | SQL Server · SSRS · Power BI

## Project Overview
A fully automated examination management system built for ITI —
covering database design, exam generation, auto-correction, reporting, and interactive dashboards.
The system manages the complete academic lifecycle of students, instructors, courses, and departments.

---

## Tools & Technologies

| Layer | Tools |
|---|---|
| **Database** | SQL Server · SSMS |
| **ERD Design** | Lucidchart |
| **Reporting** | SSRS |
| **Visualization** | Power BI |
| **Data Modeling** | Star Schema |

---

## What Was Built

### 1. Database Design
- Designed a fully normalized database with **19 tables** covering: Students, Instructors, 
Courses, Departments, Questions, Choices, Grades, Certificates, and Scholarships
- Data was AI-generated to simulate real ITI academic records (10,001 students · 164 courses · 41 departments · 2,460 questions · 172 companies)
- Data loaded into SQL Server via **BULK INSERT** from CSV files

### 2. Stored Procedures (45 Procedures)
- **Exam Generation:** Auto-generates exams by pulling random MCQ and T/F questions from the Questions and Choices tables per course
- **Auto-Correction:** Automatically corrects student answers by comparing them to model answers and records each student's grade per course
- **Student Count Report:** A stored procedure that returns the number of students enrolled in each course
- **Results Display:** Returns a full results report per student — listing all courses and their corresponding grades

### 3. SSRS Reports
- Parameterized report: enter a **Student ID** → displays all courses and grades for that student
- Report showing **number of students per course** with their grades
- Additional reports for instructor workload and department summaries

### 📊 4. Power BI — Data Model & Dashboards
- Built a **Star Schema** data model with fact and dimension tables and bridge tables for many-to-many relationships
- Developed **20 interactive dashboards** covering:
  - Student Performance & Grade Analysis
  - Department & Course Overview
  - Instructor Dashboard
  - Exam & Question Statistics
  - Certificate Tracking
  - Company Placement & Job Role Analysis

---

## 📁 Repository Structure
```
├── SQL/
│   ├── Database_Creation.sql
│   ├── CRUD_Procedures.sql
│   └── Main_Procedures.sql      # Exam Generation · Auto-Correction · Reports
├── PowerBI/
│   └── ITI_Examination.pbix
├── SSRS/
│   └── Reports/
├── Screenshots/
└── README.md
```

---

## My Contribution
- I populated the database with a generated database using AI tools, taking into account the relationships between tables and the primary and foreign keys.
- I Created Stored Procedures to automate the creation and grading of exam in collaboration with a colleague.
- Power BI Star Schema modeling and contribute to creating 20 dashboards
- SSRS parameterized reports

---

## Team Members
**Amany Shaaban Hassan** · Fatma Ahmed · Reem Khaled · Mahmoud Hussein · Islam Mohamed · Osman

[LinkedIn](https://linkedin.com/in/amany-shaaban) 
