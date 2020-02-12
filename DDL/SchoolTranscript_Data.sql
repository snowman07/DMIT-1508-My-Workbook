USE SchoolTranscript
GO

INSERT INTO Students(GivenName, Surname, DateOfBirth)
VALUES	('Dan', 'Gilleland', '19720514 10:34:00 PM'),
		('Jim', 'Smith', '19970506 08:15:00 AM'),
		('Charles', 'Smith', '19970506 08:15:00 AM'),
		('Penny', 'Smith', '19970506 08:15:00 AM'),
		('Arthur', 'Smith', '19970506 08:15:00 AM')

INSERT INTO Students(GivenName, Surname, DateOfBirth)
VALUES	('Don', 'Welch', '19420804 10:34:00 PM')

--INSERT INTO Courses(Number, [Name], Credits, [Hours], Cost)
--VALUES	('DMIT-1508', 'Database Fundamentals', 3.0, 60, 750),
--		('CPSC-1012', 'Pprogramming Fundamentals', 3.0, 60, 750),
--		('DMIT-1720', 'OOP Fundamentals', 4.5, 90, 850),
--		('DMIT-2210', 'Agile Development', 4.5, 90, 850),
--		('DMIT-1718', 'Software Testing', 4.5, 90, 850)

-- Show all of the columns from the Students table 
SELECT * FROM Students	--Using the * to identify all columns is "Quick 'n' Dirty"
-- In our SELECT statements for this course, we will avoid the use of *
--I will take marks off if you use it where you shouldn't

--You should specify which columns you want to retrieve data from
SELECT			Number, [Name], Credits, [Hours]
FROM			Courses
WHERE			[Name] LIKE '%fun%'
ORDER BY		[Name]


--Write a query to get the first/last names of all students
-- whose last name starts with a "H"
SELECT	GivenName, Surname 
FROM		Students
WHERE		Surname LIKE 'S%'
