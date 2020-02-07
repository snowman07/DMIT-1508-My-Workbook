/* ***************
* File: SchoolTranscript.sql
Author: Arr Belrey Domingo
*
* CREATE DATABASE SchoolTranscript   --->highlight this first >>click execute >>refresh
*********************** */

USE SchoolTranscript
GO

/*----Drop Tables----
 --- use this drop table code in order to run the script repeatedly.
 If this code is not present, there's an error on second run of the script.
 Remember that script will run only once.
 --- dropping of tables should be in reverse order*/


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'StudentCourses')
	DROP TABLE StudentCourses

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Courses')
	DROP TABLE Courses

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
	DROP TABLE Students


/*Create Tables*/
CREATE TABLE Students
(
	-- Comma-separated list of:
	-- Column-level and table-level definitions
	StudentID		int				
		CONSTRAINT PK_Students_StudentID 
			PRIMARY KEY				
		IDENTITY(20200001, 1)		NOT NULL,
		
	GivenName		varchar(50)		NOT NULL,

---	 % is a wildcard for zero or more characters (letter, digit, or other character)
---	_ is a wildcard for a single character (letter, digit, or other character)
---	[] are used to represent a range or set of characters that are allowed
	Surname			varchar(50)		
		CONSTRAINT CK_Students_Surname
--			CHECK (Surname LIKE '_%')	--- LIKE allows us to do a "pattern-match"
			CHECK (Surname LIKE '[a-z][a-z]')	-- two letter plus any other chars
--								\  1/ \ 1   /
		--	Positive match for 'Fred'
		--	Positive match for 'Wu'
		-- Negative match for 'F'
		-- Negative match for '2udor'
									NOT NULL,
	DateOfBirth		datetime		NOT NULL,
	Enrolled		bit				
		CONSTRAINT DF_Students_Enrolled
			DEFAULT (1)				NOT NULL --- default value if there's no value supplied
)

CREATE TABLE Courses
(
	Number			varchar(10)		
		CONSTRAINT PK_Courses_Number
			PRIMARY KEY				NOT NULL,
	[Name]			varchar(50)		NOT NULL,
	Credits			decimal(3,1)	
		CONSTRAINT CK_Courses_Credits
			CHECK (Credits > 0 AND Credits <= 12) --- This is a check constraints	
			---		\		/		\			/
			---		 boolean		   boolean
			---		  \						 /
			---				 boolean
									NOT NULL,
	[Hours]			tinyint			
		CONSTRAINT CK_Courses_Hours
---			CHECK ([Hours] >= 15 AND [Hours] <= 180)
			CHECK ([Hours] BETWEEN 15 AND 180) ---BETWEEN operator is inclusive
									NOT NULL,
	Active			bit				
		CONSTRAINT DF_Courses_Active
			DEFAULT (1)				NOT NULL,	--- this is a default constraint
	Cost			money			
		CONSTRAINT CK_Courses_Cost
			CHECK (Cost >= 0)		NOT NULL
)

CREATE TABLE StudentCourses
(
	StudentID		int				
		CONSTRAINT FK_StudentCourses_StudentID_Students_StudentID
			FOREIGN KEY REFERENCES Students(StudentID)
									NOT NULL,
	CourseNumber	varchar(10)		
		CONSTRAINT FK_StudentCourses_CourseNumber_Courses_Number
			FOREIGN KEY REFERENCES Courses(Number)
									NOT NULL,
	[Year]			tinyint			NOT NULL,
	Term			char(3)			NOT NULL,
	FinalMark		tinyint			NULL,
	[Status]		char(1)			
		CONSTRAINT CK_StudentCourses_Status
			CHECK ( [Status] = 'E' OR
					[Status] = 'C' OR
					[Status] = 'W')
		--	CHECK ([Status] IN ('E', 'C', 'W'))
		CONSTRAINT DF_StudetnCourses_Status
			DEFAULT ('E')
									NOT NULL,

	-- Table-level definition for Composite Primary Keys
	CONSTRAINT PK_StudentCourses_StudentID_CourseNumber
		PRIMARY KEY (StudentID, CourseNumber),
	-- Table-level constraint involving more than one column
	CONSTRAINT CK_StudentCourses_FinalMark_Status
		CHECK (([Status] = 'C' AND FinalMark IS NOT NULL)
				OR
				([Status] IN ('E', 'W') AND FinalMark IS NULL))
)


/*-----INDEXES-----*/
-- For all foreign keys
CREATE NONCLUSTERED INDEX IX_StudentCourses_StudentID
	ON StudentCourses (StudentID)

CREATE NONCLUSTERED INDEX IX_StudentCourses_CourseNumber
	ON StudentCourses (CourseNumber)


-- For other columns where searching/sorting might be important
CREATE NONCLUSTERED INDEX IX_Student_Surname
	ON Students (Surname)
GO --- one batch


/*-----ALTER TABLE STATEMENTS-----*/
-- 1) Add a PostalCode for the Student Table
ALTER TABLE Students
	ADD PostalCode char(6) NULL
	-- Adding this as a nullable column, because students already exists,
	-- and we don'thave postal code for those students.
GO	-- I have to break the above code as a separate batch from the following 
	-- second batch

-- 2) Make sure the PostalCode follows the correct pattern A#A#A#
ALTER TABLE Students
	ADD CONSTRAINT CK_Students_PostalCode
		CHECK (PostalCode LIKE '[A-Z][0-9][A-Z][0-9][A-Z][0-9]')
		-- Match for T4R1H2:	  T    4    R    1    H    2
GO	-- third batch