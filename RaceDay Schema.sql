/* =========================================================
   RaceDay System — Database Creation & Population Script
   Target: Microsoft SQL Server (SSMS)
   Run on a clean instance. Safe to re-run (drops DB first).
   ========================================================= */

IF DB_ID('RaceDayDB') IS NOT NULL
BEGIN
    ALTER DATABASE RaceDayDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RaceDayDB;
END
GO

CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO

/* -----------------------------
   Table: Role
   ----------------------------- */
CREATE TABLE Role (
    RoleID   INT IDENTITY(1,1) PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL UNIQUE
);
GO

/* -----------------------------
   Table: User
   ----------------------------- */
CREATE TABLE [User] (
    UserID       INT IDENTITY(1,1) PRIMARY KEY,
    FullName     VARCHAR(100) NOT NULL,
    Email        VARCHAR(150) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    RoleID       INT NOT NULL,
    CONSTRAINT FK_User_Role FOREIGN KEY (RoleID) REFERENCES Role(RoleID)
);
GO

/* -----------------------------
   Table: Event
   ----------------------------- */
CREATE TABLE Event (
    EventID     INT IDENTITY(1,1) PRIMARY KEY,
    EventName   VARCHAR(150) NOT NULL,
    EventDate   DATE NOT NULL,
    Location    VARCHAR(150) NOT NULL,
    OrganizerID INT NOT NULL,
    CONSTRAINT FK_Event_Organizer FOREIGN KEY (OrganizerID) REFERENCES [User](UserID)
);
GO

/* -----------------------------
   Table: Category
   ----------------------------- */
CREATE TABLE Category (
    CategoryID   INT IDENTITY(1,1) PRIMARY KEY,
    EventID      INT NOT NULL,
    CategoryName VARCHAR(100) NOT NULL,
    Distance     DECIMAL(5,2) NOT NULL,
    CONSTRAINT FK_Category_Event FOREIGN KEY (EventID) REFERENCES Event(EventID)
);
GO

/* -----------------------------
   Table: Enrolment
   ----------------------------- */
CREATE TABLE Enrolment (
    EnrolmentID   INT IDENTITY(1,1) PRIMARY KEY,
    UserID        INT NOT NULL,
    CategoryID    INT NOT NULL,
    EnrolmentDate DATETIME NOT NULL DEFAULT GETDATE(),
    Status        VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    CONSTRAINT FK_Enrolment_User FOREIGN KEY (UserID) REFERENCES [User](UserID),
    CONSTRAINT FK_Enrolment_Category FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    CONSTRAINT UQ_Enrolment_User_Category UNIQUE (UserID, CategoryID)
);
GO

/* -----------------------------
   Table: Result
   ----------------------------- */
CREATE TABLE Result (
    ResultID    INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL UNIQUE,
    FinishTime  TIME NOT NULL,
    Position    INT NULL,
    CONSTRAINT FK_Result_Enrolment FOREIGN KEY (EnrolmentID) REFERENCES Enrolment(EnrolmentID)
);
GO

/* =========================================================
   Populate with sample data
   ========================================================= */

INSERT INTO Role (RoleName) VALUES ('Athlete'), ('Organizer');
GO

INSERT INTO [User] (FullName, Email, PasswordHash, RoleID) VALUES
('Thabo Nkosi',          'thabo@example.com', 'hashed_pw_1', 2),  -- Organizer
('Lindiwe Dlamini',      'lindiwe@example.com', 'hashed_pw_2', 1), -- Athlete
('Sarah van der Merwe',  'sarah@example.com', 'hashed_pw_3', 1);  -- Athlete
GO

INSERT INTO Event (EventName, EventDate, Location, OrganizerID) VALUES
('Johannesburg City Marathon', '2026-10-15', 'Johannesburg', 1);
GO

INSERT INTO Category (EventID, CategoryName, Distance) VALUES
(1, '10km Open', 10.0),
(1, 'Half Marathon', 21.1);
GO

INSERT INTO Enrolment (UserID, CategoryID) VALUES
(2, 1),
(3, 2);
GO

INSERT INTO Result (EnrolmentID, FinishTime, Position) VALUES
(1, '00:52:30', 1),
(2, '01:48:12', 1);
GO

/* Quick sanity check */
SELECT * FROM Role;
SELECT * FROM [User];
SELECT * FROM Event;
SELECT * FROM Category;
SELECT * FROM Enrolment;
SELECT * FROM Result;
