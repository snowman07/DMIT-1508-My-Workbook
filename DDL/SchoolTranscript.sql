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
	Surname			varchar(50)		NOT NULL,
	DateOfBirth		datetime		NOT NULL,
	Enrolled		bit				
		CONSTRAINT DF_Students_Enrolled
			DEFAULT (1)				NOT NULL
)

CREATE TABLE Courses
(
	Number			varchar(10)		
		CONSTRAINT PK_Courses_Number
			PRIMARY KEY				NOT NULL,
	[Name]			varchar(50)		NOT NULL,
	Credits			decimal(3,1)	NOT NULL,
	[Hours]			tinyint			NOT NULL,
	Active			bit				
		CONSTRAINT DF_Courses_Active
			DEFAULT (1)				NOT NULL,
	Cost			money			NOT NULL
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
	[Status]		char(1)			NOT NULL
	-- Table-level definition for Composite Primary Keys
	CONSTRAINT PK_StudentCourses_StudentID_CourseNumber
		PRIMARY KEY (StudentID, CourseNumber)
)
