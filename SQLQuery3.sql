-- Create Database
CREATE DATABASE SpotifyDB;

-- Use the database (SQL Server/MySQL)
USE SpotifyDB;

-- Create Tables

CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    ArtistName VARCHAR(100),
    Genre VARCHAR(50),
    Country VARCHAR(50)
);

CREATE TABLE Albums (
    AlbumID INT PRIMARY KEY,
    Title VARCHAR(100),
    ArtistID INT,
    ReleaseYear INT,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

CREATE TABLE Songs (
    SongID INT PRIMARY KEY,
    Title VARCHAR(100),
    AlbumID INT,
    Duration INT,
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID)
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(100),
    Email VARCHAR(100),
    Country VARCHAR(50),
    SubscriptionType VARCHAR(20)
);

CREATE TABLE Streams (
    StreamID INT PRIMARY KEY,
    UserID INT,
    SongID INT,
    StreamDate DATE,
    Device VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

-- Insert Artists

INSERT INTO Artists (ArtistID, ArtistName, Genre, Country) VALUES
(1,'Adele','Pop','UK'),
(2,'Drake','Hip-Hop','Canada'),
(3,'Coldplay','Alternative Rock','UK'),
(4,'Burna Boy','Afrobeats','Nigeria'),
(5,'Taylor Swift','Pop','USA'),
(6,'BTS','K-Pop','South Korea'),
(7,'Black Coffee','House','South Africa'),
(8,'Ed Sheeran','Pop','UK'),
(9,'Amapiano Bros','Amapiano','South Africa'),
(10,'Rihanna','R&B','Barbados');

-- Insert Albums

INSERT INTO Albums (AlbumID, Title, ArtistID, ReleaseYear) VALUES
(1,'25',1,2015),
(2,'Scorpion',2,2018),
(3,'Everyday Life',3,2019),
(4,'Twice as Tall',4,2020),
(5,'1989',5,2014),
(6,'Map of the Soul',6,2020),
(7,'Subconsciously',7,2021),
(8,'Divide',8,2017),
(9,'Amapiano Nation',9,2022),
(10,'Anti',10,2016);

-- Insert Songs

INSERT INTO Songs (SongID, Title, AlbumID, Duration) VALUES
(1,'Hello',1,295),
(2,'Nice for What',2,210),
(3,'Orphans',3,240),
(4,'Way Too Big',4,220),
(5,'Blank Space',5,231),
(6,'ON',6,280),
(7,'Drive',7,300),
(8,'Shape of You',8,233),
(9,'Piano Party',9,190),
(10,'Work',10,220);

-- Insert Users

INSERT INTO Users (UserID, UserName, Email, Country, SubscriptionType) VALUES
(1,'SibusisoM','sibusiso.m@gmail.com','South Africa','Premium'),
(2,'EmilyR','emily.r@yahoo.com','USA','Free'),
(3,'ChenWei','chen.wei@qq.com','China','Premium'),
(4,'SaraK','sara.k@outlook.com','UK','Free'),
(5,'LeboT','lebo.t@gmail.com','South Africa','Free'),
(6,'CarlosV','carlos.v@gmail.com','Mexico','Premium'),
(7,'AnikaS','anika.s@gmail.com','India','Premium'),
(8,'JabuM','jabu.m@gmail.com','South Africa','Free'),
(9,'TomH','tom.h@icloud.com','Canada','Premium'),
(10,'FatimaZ','fatima.z@gmail.com','UAE','Free');

-- Insert Streams

INSERT INTO Streams (StreamID, UserID, SongID, StreamDate, Device) VALUES
(1,1,8,'2025-07-25','Android'),
(2,2,5,'2025-07-24','iPhone'),
(3,3,2,'2025-07-23','Web'),
(4,4,3,'2025-07-22','iPhone'),
(5,5,9,'2025-07-25','Android'),
(6,6,10,'2025-07-21','Web'),
(7,7,6,'2025-07-25','iPhone'),
(8,8,4,'2025-07-23','Android'),
(9,9,1,'2025-07-22','Web'),
(10,10,7,'2025-07-25','iPhone');

-- ALTER TABLE

ALTER TABLE Artists
ADD MonthlyListeners INT;

UPDATE Artists
SET MonthlyListeners = 1000000
WHERE ArtistID = 1;

-- UPDATE

UPDATE Users
SET SubscriptionType = 'Premium'
WHERE UserID = 2;

-- DELETE

DELETE FROM Streams
WHERE StreamID = 10;

-- Reflection
-- UPDATE and DELETE statements without a WHERE clause
-- affect every row in a table.
-- Always use a WHERE clause to avoid accidentally
-- updating or deleting all records.