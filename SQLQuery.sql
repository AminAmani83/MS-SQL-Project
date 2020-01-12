create database library;
GO

use library;

create table student
(
	studentId int NOT NULL Primary Key, -- not identity, using the ID on their student cards
	firstName nvarchar(50),
	lastName nvarchar(50),
	birthday date,
	gender char(1),  -- M or F
	class nvarchar(50)
);

create table author
(
	authorId int Not Null Primary Key Identity,
	firstName nvarchar(50),
	lastName nvarchar(50)
);

create table [type]
(
	typeId int Not Null Primary Key Identity,
	[name] nvarchar(50) Unique Not Null
);

create table book
(
	bookId int Not Null Primary Key Identity,
	title nvarchar(50) Not Null,
	[pageCount] int,
	price Numeric(10,2),
	authorId int,
	typeId int,
	Constraint FK_book_author Foreign Key (authorId) References author(authorId),
	Constraint FK_book_type Foreign Key (typeId) References [type](typeId)
);

create table borrow
(
	borrowId int Not Null Primary Key Identity,
	studentId int Not Null,
	bookId int Not Null,
	takenDate date Not Null,
	broughtDate date Null,
	Constraint FK_borrow_student Foreign Key (studentId) References student(studentId),
	Constraint FK_borrow_book Foreign Key (bookId) References book(bookId)
);
GO

-- Stored Procedures --

Create PROCEDURE SP_insertStudent
	@studentId int,
	@firstName nvarchar(50),
	@lastName nvarchar(50),
	@birthdate date = Null,
	@gender char(1),
	@class nvarchar(50)
AS
BEGIN TRAN
BEGIN TRY
	Insert Into student
	Values
	(@studentId, @firstName, @lastName, @birthdate, @gender, @class);
	Commit;
	Select 0;
END TRY
BEGIN CATCH
	Rollback;
	Select 1;
END CATCH;
GO

-- test --
/*
EXEC 	SP_insertStudent
		@studentId = 300,
		@firstName = N'Ami3',
		@lastName = N'Amani3',
		@birthdate = '1991-01-01',
		@gender = N'F',
		@class = N'IPD23';
GO
select * from student;
GO
*/



Create PROCEDURE SP_insertBook
	-- Book Info
	@bookTitle nvarchar(50),
	@bookPageCount int = null,
	@bookPrice Numeric(10,2) = null,
	-- Author Info
	@authorFirstName nvarchar(50) = 'unknown',
	@authorLastName nvarchar(50) = 'unknown',
	-- Type Info
	@typeName nvarchar(50) = 'unknown'
AS
	BEGIN TRAN
	BEGIN TRY
		-- 1. Insert Type Or Fetch TypeId

		Declare @typeId int;

		Select /* find typeId if it already exists */
			@typeId = typeId
		From
			[type]
		Where [name] = @typeName;

		IF @typeId IS NULL /* insert type if it did not exist */
		Begin
			Insert Into
				[type]
			Values
				(@typeName);

			Set @typeId = @@IDENTITY; /* Fetch the recently created id */
		End;
		--select @typeId As typeId;

		-- 2. Insert Author Or Fetch AuthorId

		Declare @authorId int;

		Select /* find authorId if it already exists */
			@authorId = authorId
		From
			author
		Where firstName = @authorFirstName
			AND lastName = @authorLastName;

		IF @authorId IS NULL /* insert author if it did not exist */
		Begin
			Insert Into
				author
			Values
				(@authorFirstName, @authorLastName);

			Set @authorId = @@IDENTITY; /* Fetch the recently created id */
		End;
		--select @authorId as AuthorId; 

		-- 3. Insert Book

		Insert Into
			book
		Values
			(@bookTitle, @bookPageCount, @bookPrice, @authorId, @typeId);
		
		Commit;
		Select 0; -- SUCCESS
	END TRY
	BEGIN CATCH
		Rollback;
		Select 1; -- ERROR
	END CATCH
GO


-- test
/*
EXEC	SP_insertBook
		@bookTitle = N'The Rise V3',
		@bookPageCount = 300,
		@bookPrice = NULL,
		@authorFirstName = N'Sara',
		@authorLastName = N'Amani',
		@typeName = N'Sci';
select * from book;
select * from [type];
select * from author;
GO
*/

Create PROCEDURE SP_borrow
	@studentId int,
	@bookId int
AS
	BEGIN TRAN
	BEGIN TRY
		-- 1. Find number of borrowed books by this student
		Declare @studentBorrowedCount int; -- must be < 3
		SET @studentBorrowedCount = (
			Select
				Count(1)
			From
				borrow
			Where studentId = @studentId
				AND broughtDate IS NULL
		);

		-- 2. Find book availability
		Declare @bookAvailability bit; -- 0 = Available
		SET @bookAvailability = (
			Select
				Count(1)
			From
				borrow
			Where bookId = @bookId
				AND broughtDate IS NULL
		);

		-- 3. Check Conditions and Borrow if Allowed
		IF (@studentBorrowedCount < 3 AND @bookAvailability = 0)
		BEGIN -- Proceed With Borrowing
			Insert Into
				borrow
			Values
				(@studentId, @bookId, GETDATE(), Null);
			Select 0; -- SUCCESS
		END;
		ELSE IF (@studentBorrowedCount >= 3)
		BEGIN
			Select 'MaxBooksLimitReached';
		END;
		ELSE
		BEGIN
			Select 'BookNotAvailable';
		END;

		Commit;
	END TRY
	BEGIN CATCH
		Rollback;
		Select 1; -- ERROR
	END CATCH
GO

-- test
/*
EXEC	SP_borrow
		@studentId = 200,
		@bookId = 5;
select * from book
select * from student
select * from borrow
GO
*/

Create PROCEDURE SP_return
	@studentId int,
	@bookId int
AS
	BEGIN TRAN
	BEGIN TRY
		UPDATE borrow
		SET broughtDate = GETDATE()
		Where studentId = @studentId
			AND bookId = @bookId
			AND broughtDate IS NULL;
		Commit;
		Select 0; -- SUCCESS
	END TRY
	BEGIN CATCH
		Rollback;
		Select 1; -- ERROR
	END CATCH
GO

-- test
/*
EXEC	SP_return
		@studentId = 200,
		@bookId = 5;
select * from book
select * from student
select * from borrow
GO
*/


Create PROCEDURE SP_getAllStudents
AS
	BEGIN TRY
		Select
			studentId, (firstName+' '+lastName) AS name
		From
			student;
	END TRY
	BEGIN CATCH
		Select 1; -- ERROR
	END CATCH
GO

-- test
/*
EXEC SP_getAllStudents;
GO
*/

Create View V_allBooks AS
	Select
		b.bookId AS BookId,
		(b.title+' - '+t.[name]+' ('+a.firstName+' '+a.lastName+')') AS BookInfo
	From
		book AS b
		JOIN
		author AS a ON a.authorId = b.authorId
		JOIN
		[type] AS t ON t.typeId = b.typeId;
GO

-- test
-- Select * from V_allBooks;

Create PROCEDURE SP_getAllBooks
AS
	BEGIN TRY
		Select
			BookId,
			BookInfo
		From
			V_allBooks; -- using View
	END TRY
	BEGIN CATCH
		Select 1; -- ERROR
	END CATCH
GO

-- test
/*
EXEC SP_getAllBooks;
GO
*/

Create PROCEDURE SP_getStudentBooks
	@studentId int
AS
	BEGIN TRY
		Select
			BookId,
			BookInfo
		From
			V_allBooks -- using View
		Where BookId IN (
			Select
				bookId
			From
				borrow
			Where studentId = @studentId
				AND broughtDate IS NULL
			);
	END TRY
	BEGIN CATCH
		Select 1; -- ERROR
	END CATCH
GO

-- test
/*
EXEC SP_getStudentBooks
@studentId = 100;
select * from borrow;
*/


-- This is not implemented in the webApp:
Create PROCEDURE SP_getAvailableBooks
AS
	BEGIN TRY
		Select
			BookId,
			BookInfo
		From
			V_allBooks -- using View
		Where BookId NOT IN (
			Select
				bookId
			From
				borrow
			Where broughtDate IS NULL
		);
	END TRY
	BEGIN CATCH
		Select 1; -- ERROR
	END CATCH
GO

-- test
/*
EXEC SP_getAvailableBooks;
GO
*/

-- This is not implemented in the webApp:
Create PROCEDURE SP_getOverdueBooks -- Borrowed Over 14 Days Ago
AS
	BEGIN TRY
		Select
			v.*,
			s.*
		From
			borrow AS b
			JOIN
			student AS s ON s.studentId = b.studentId
			JOIN
			V_allBooks AS v ON v.bookId = b.bookId
		Where b.broughtDate IS NULL
			AND b.takenDate < dateadd( day, -14, getdate() );
	END TRY
	BEGIN CATCH
		Select 1; -- ERROR
	END CATCH
GO

-- test
/*
EXEC SP_getOverdueBooks;
GO
*/