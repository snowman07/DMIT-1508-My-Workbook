USE SchoolTranscript
GO

INSERT INTO Students(GivenName, Surname, DateOfBirth, Enrolled)
VALUES	('Dan', 'Gilleland', '19720514 10:34:00 PM', 1),
		('Jim', 'Smith', '19970506 08:15:00 AM', 1)

INSERT INTO Students(GivenName, Surname, DateOfBirth)
VALUES	('Don', 'Welch', '19420804 10:34:00 PM')

SELECT * FROM Students