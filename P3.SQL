-- Create a new database called 'Project'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'Movie'
)
CREATE DATABASE Movie
GO

USE Movie

CREATE TABLE [User] (
    UserID INT NOT NULL,
    [Name] VARCHAR(20),
    Email VARCHAR(50),
    PassHash VARBINARY(64),
    Bio VARCHAR(1000),
    CONSTRAINT User_PK PRIMARY KEY (UserID)
);

CREATE TABLE Person (
    PersonID INT NOT NULL,
    [Name] VARCHAR(50),
    DOB DATE,
    Age INT,
    CONSTRAINT Person_PK PRIMARY KEY (PersonID)
);

CREATE TABLE Director (
    person_id INT,
    CONSTRAINT Director_PK PRIMARY KEY (person_id),
    FOREIGN KEY (person_id) REFERENCES Person(PersonID)
);

CREATE TABLE Actor (
    person_id INT,
    CONSTRAINT Actor_PK PRIMARY KEY (person_id),
    FOREIGN KEY (person_id) REFERENCES Person(PersonID)
);

CREATE TABLE Writer (
    person_id INT,
    CONSTRAINT Writer_PK PRIMARY KEY (person_id),
    FOREIGN KEY (person_id) REFERENCES Person(PersonID)
);

CREATE TABLE Studio (
    StudioID INT NOT NULL,
    StudioName VARCHAR(50),
    DateFounded DATE,
    StudioHead VARCHAR(50),
    CONSTRAINT Studio_PK PRIMARY KEY (StudioID)
);

CREATE TABLE Movie (
    MovieID INT NOT NULL,
    StudioID INT,
    Title VARCHAR(50),
    [Year] INT NOT NULL,
    DirectorID INT,
    WriterID INT,
    CONSTRAINT Movie_PK PRIMARY KEY (MovieID),
    FOREIGN KEY (StudioID) REFERENCES Studio(StudioID),
    FOREIGN KEY (DirectorID) REFERENCES Director(person_id),
    FOREIGN KEY (WriterID) REFERENCES Writer(person_id)
);

CREATE TABLE TVShow (
    ShowID INT NOT NULL,
    [Name] VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    [Date] DATE NOT NULL,
    CONSTRAINT TVShow_PK PRIMARY KEY (ShowID)
);

CREATE TABLE Season (
    SeasonID INT NOT NULL,
    ShowID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    [Date] DATE NOT NULL,
    CONSTRAINT Season_PK PRIMARY KEY (SeasonID),
    FOREIGN KEY (ShowID) REFERENCES TVShow(ShowID)
);

CREATE TABLE Episode (
    EpisodeID INT NOT NULL,
    SeasonID INT NOT NULL,
    ShowID INT NOT NULL,
    DirectorID INT,
    WriterID INT,
    [Date] DATE NOT NULL,
    Title VARCHAR(255) NOT NULL,
    [Length] INT NOT NULL CHECK ([Length] > 0),
    CONSTRAINT Episode_PK PRIMARY KEY (EpisodeID),
    FOREIGN KEY (SeasonID) REFERENCES Season(SeasonID),
    FOREIGN KEY (ShowID) REFERENCES TVShow(ShowID),
    FOREIGN KEY (DirectorID) REFERENCES Director(person_id),
    FOREIGN KEY (WriterID) REFERENCES Writer(person_id)
);

CREATE TABLE Review (
    ReviewID INT NOT NULL,
    UserID INT NOT NULL,
    MovieID INT NOT NULL,
    [Date] DATE,
    CONSTRAINT Review_PK PRIMARY KEY (ReviewID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

CREATE TABLE Rating (
    RatingID INT NOT NULL,
    ReviewID INT,
    UserID INT NOT NULL,
    MovieID INT NOT NULL,
    rating_value INT NOT NULL CHECK (rating_value BETWEEN 1 AND 10),
    CONSTRAINT Rating_PK PRIMARY KEY (RatingID),
    FOREIGN KEY (ReviewID) REFERENCES Review(ReviewID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

CREATE TABLE Genre (
    GenreID INT NOT NULL,
    Genre VARCHAR(100) UNIQUE NOT NULL,
    CONSTRAINT Genre_PK PRIMARY KEY (GenreID)
);

CREATE TABLE Watchlist (
    WatchListID INT NOT NULL,
    UserID INT NOT NULL,
    MovieID INT NOT NULL,
    CONSTRAINT Watchlist_PK PRIMARY KEY (WatchListID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

INSERT INTO [User] (UserID, [Name], Email, PassHash, Bio)
VALUES 
(1, 'John Doe', 'john@example.com', HASHBYTES('SHA2_256', 'password123'), 'Movie enthusiast and critic.'),
(2, 'Jane Smith', 'jane@example.com', HASHBYTES('SHA2_256', 'jane_password'), 'Love independent films and documentaries.'),
(3, 'Sam Wilson', 'sam@example.com', HASHBYTES('SHA2_256', 'sam_wilson_pwd'), 'Avid TV series watcher.'),
(4, 'Ethan Hunt', 'ethan@example.com', HASHBYTES('SHA2_256', 'ethan_mission'), 'Action movie fanatic.'),
(5, 'Laura Croft', 'laura@example.com', HASHBYTES('SHA2_256', 'laura_pass'), 'Adventure seeker through film.'),
(6, 'Michael Jordan', 'mjordan@example.com', HASHBYTES('SHA2_256', 'basketball_pass'), 'Documentary lover.'),
(7, 'Bruce Wayne', 'bruce@example.com', HASHBYTES('SHA2_256', 'dark_knight'), 'Batman movie fan.'),
(8, 'Clark Kent', 'clark@example.com', HASHBYTES('SHA2_256', 'superman_rules'), 'Loves superhero films.'),
(9, 'Peter Parker', 'peter@example.com', HASHBYTES('SHA2_256', 'spidey_pass'), 'Marvel movie lover.'),
(10, 'Tony Stark', 'tony@example.com', HASHBYTES('SHA2_256', 'ironman123'), 'Tech geek and action fan.'),
(11, 'Diana Prince', 'diana@example.com', HASHBYTES('SHA2_256', 'wonder_woman'), 'Superhero movie buff.'),
(12, 'Wade Wilson', 'wade@example.com', HASHBYTES('SHA2_256', 'deadpool_rulez'), 'Comedy-action lover.'),
(13, 'Natasha Romanoff', 'natasha@example.com', HASHBYTES('SHA2_256', 'blackwidow123'), 'Spy thriller fan.'),
(14, 'Stephen Strange', 'strange@example.com', HASHBYTES('SHA2_256', 'doctor_magic'), 'Sci-fi and fantasy lover.'),
(15, 'Bruce Banner', 'bruceb@example.com', HASHBYTES('SHA2_256', 'hulk_smasher'), 'Science fiction geek.'),
(16, 'Thor Odinson', 'thor@example.com', HASHBYTES('SHA2_256', 'thunder_god'), 'Mythological and historical fan.'),
(17, 'Steve Rogers', 'steve@example.com', HASHBYTES('SHA2_256', 'cap_am_pass'), 'War movie enthusiast.'),
(18, 'James Bond', 'bond@example.com', HASHBYTES('SHA2_256', '007bond'), 'Spy movie expert.'),
(19, 'Jack Ryan', 'ryan@example.com', HASHBYTES('SHA2_256', 'action_soldier'), 'Action and espionage film lover.'),
(20, 'Han Solo', 'han@example.com', HASHBYTES('SHA2_256', 'starwars_rulez'), 'Sci-fi adventure fan.'),
(21, 'Leia Organa', 'leia@example.com', HASHBYTES('SHA2_256', 'rebellion_pass'), 'Loves epic space dramas.'),
(22, 'Luke Skywalker', 'luke@example.com', HASHBYTES('SHA2_256', 'jedi_master123'), 'Fantasy and space operas enthusiast.'),
(23, 'Yoda', 'yoda@example.com', HASHBYTES('SHA2_256', 'force_user_pass'), 'Master of all things Star Wars.'),
(24, 'Frodo Baggins', 'frodo@example.com', HASHBYTES('SHA2_256', 'one_ring_to_rule'), 'Fantasy lover.'),
(25, 'Aragorn', 'aragorn@example.com', HASHBYTES('SHA2_256', 'king_of_gondor'), 'Historical and fantasy film fan.'),
(26, 'Gandalf', 'gandalf@example.com', HASHBYTES('SHA2_256', 'you_shall_not_pass'), 'Fantasy magic enthusiast.'),
(27, 'Darth Vader', 'vader@example.com', HASHBYTES('SHA2_256', 'dark_side_pass'), 'Lover of dark and intense movies.'),
(28, 'Kylo Ren', 'kylo@example.com', HASHBYTES('SHA2_256', 'sith_apprentice'), 'Anti-hero film fan.'),
(29, 'Rey Skywalker', 'rey@example.com', HASHBYTES('SHA2_256', 'new_hope_pass'), 'Loves stories about new beginnings.'),
(30, 'Obi-Wan Kenobi', 'obiwan@example.com', HASHBYTES('SHA2_256', 'force_master_pass'), 'Mentor movie lover.'),
(31, 'Tony Montana', 'tony@example.com', HASHBYTES('SHA2_256', 'scarface_rules'), 'Crime and gangster film fan.'),
(32, 'Vito Corleone', 'vito@example.com', HASHBYTES('SHA2_256', 'godfather_pass'), 'Mafia movies are life.'),
(33, 'Michael Corleone', 'michael@example.com', HASHBYTES('SHA2_256', 'mafia_boss_pass'), 'Family drama enthusiast.'),
(34, 'Al Pacino', 'al@example.com', HASHBYTES('SHA2_256', 'actor_life_pass'), 'Drama and method acting fanatic.'),
(35, 'Marty McFly', 'marty@example.com', HASHBYTES('SHA2_256', 'back_to_future'), 'Time travel adventure lover.');


SELECT * FROM [User]


INSERT INTO Person (PersonID, [Name], DOB, Age)
VALUES 
(1, 'Steven Spielberg', '1946-12-18', 77),
(2, 'Christopher Nolan', '1970-07-30', 54),
(3, 'Quentin Tarantino', '1963-03-27', 61),
(4, 'Martin Scorsese', '1942-11-17', 81),
(5, 'James Cameron', '1954-08-16', 69),
(6, 'Peter Jackson', '1961-10-31', 63),
(7, 'Ridley Scott', '1937-11-30', 86),
(8, 'Stanley Kubrick', '1928-07-26', 95),
(9, 'Wes Anderson', '1969-05-01', 55),
(10, 'David Fincher', '1962-08-28', 62),
(11, 'Paul Thomas Anderson', '1970-06-26', 54),
(12, 'Greta Gerwig', '1983-08-04', 41),
(13, 'Sofia Coppola', '1971-05-14', 53),
(14, 'Alfred Hitchcock', '1899-08-13', 125),
(15, 'Francis Ford Coppola', '1939-04-07', 85),
(16, 'Guillermo del Toro', '1964-10-09', 60),
(17, 'Taika Waititi', '1975-08-16', 49),
(18, 'Jordan Peele', '1979-02-21', 45),
(19, 'George Lucas', '1944-05-14', 80),
(20, 'J.J. Abrams', '1966-06-27', 58),
(21, 'Joss Whedon', '1964-06-23', 60),
(22, 'Michael Bay', '1965-02-17', 59),
(23, 'Clint Eastwood', '1930-05-31', 94),
(24, 'Ava DuVernay', '1972-08-24', 52),
(25, 'Ryan Coogler', '1986-05-23', 38),
(26, 'Damien Chazelle', '1985-01-19', 39),
(27, 'Spike Lee', '1957-03-20', 67),
(28, 'Robert Zemeckis', '1952-05-14', 72),
(29, 'John Carpenter', '1948-01-16', 76),
(30, 'Tim Burton', '1958-08-25', 66),
(31, 'David Lynch', '1946-01-20', 78),
(32, 'Sergio Leone', '1929-01-03', 95),
(33, 'John Ford', '1894-02-01', 130),
(34, 'Frank Capra', '1897-05-18', 127),
(35, 'Cecil B. DeMille', '1881-08-12', 143);


SELECT * FROM Person


INSERT INTO Director (person_id)
VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30),
(31), (32), (33), (34), (35);

SELECT * FROM Director

INSERT INTO Actor (person_id)
VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30),
(31), (32), (33), (34), (35);

SELECT * FROM Actor

INSERT INTO Writer (person_id)
VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30),
(31), (32), (33), (34), (35);

SELECT * FROM Writer


INSERT INTO Studio (StudioID, StudioName, DateFounded, StudioHead)
VALUES 
(1, 'Warner Bros.', '1923-04-04', 'David Zaslav'),
(2, 'Universal Pictures', '1912-06-08', 'Donna Langley'),
(3, 'Paramount Pictures', '1912-05-08', 'Brian Robbins'),
(4, '20th Century Fox', '1935-05-31', 'Steve Asbell'),
(5, 'Sony Pictures', '1987-09-01', 'Tom Rothman'),
(6, 'Walt Disney Studios', '1923-10-16', 'Alan Bergman'),
(7, 'DreamWorks', '1994-10-12', 'Steven Spielberg'),
(8, 'Lionsgate', '1997-07-10', 'Jon Feltheimer'),
(9, 'MGM', '1924-04-17', 'Mike De Luca'),
(10, 'New Line Cinema', '1967-07-18', 'Carolyn Blackwood'),
(11, 'Focus Features', '2002-05-01', 'Peter Kujawski'),
(12, 'A24', '2012-08-20', 'David Fenkel'),
(13, 'Netflix', '1997-08-29', 'Ted Sarandos'),
(14, 'Hulu', '2007-03-12', 'Randy Freer'),
(15, 'Amazon Studios', '2010-11-18', 'Jennifer Salke'),
(16, 'Apple TV+', '2019-11-01', 'Matt Cherniss'),
(17, 'Blumhouse Productions', '2000-09-01', 'Jason Blum'),
(18, 'Pixar', '1986-02-03', 'Jim Morris'),
(19, 'Illumination Entertainment', '2007-02-01', 'Chris Meledandri'),
(20, 'Columbia Pictures', '1924-01-10', 'Sanford Panitch'),
(21, 'TriStar Pictures', '1982-05-16', 'Nicole Brown'),
(22, 'Legendary Entertainment', '2000-01-01', 'Joshua Grode'),
(23, 'Studio Ghibli', '1985-06-15', 'Toshio Suzuki'),
(24, 'Toei Animation', '1956-01-01', 'Katsuhiro Takagi'),
(25, 'Miramax Films', '1979-12-31', 'Bill Block'),
(26, 'The Weinstein Company', '2005-03-01', 'Bob Weinstein'),
(27, 'DC Films', '2016-04-10', 'James Gunn'),
(28, 'Marvel Studios', '1993-12-31', 'Kevin Feige'),
(29, 'Blue Sky Studios', '1987-02-22', 'Andrew Millstein'),
(30, 'Laika', '2005-07-01', 'Travis Knight'),
(31, 'Ghibli Museum', '2001-10-01', 'Hayao Miyazaki'),
(32, 'Nickelodeon Movies', '1996-02-26', 'Brian Robbins'),
(33, 'Metrograph Pictures', '2016-03-01', 'Alexander Olch'),
(34, 'IFC Films', '2000-01-01', 'Arianna Bocco'),
(35, 'Neon', '2017-01-01', 'Tom Quinn');

SELECT * FROM Studio



INSERT INTO Movie (MovieID, StudioID, Title, [Year], DirectorID, WriterID)
VALUES
(1, 1, 'Inception', 2010, 2, 2),
(2, 2, 'Pulp Fiction', 1994, 3, 3),
(3, 3, 'The Godfather', 1972, 15, 15),
(4, 4, 'The Dark Knight', 2008, 2, 2),
(5, 5, 'Interstellar', 2014, 2, 2),
(6, 6, 'Avatar', 2009, 5, 5),
(7, 7, 'The Lord of the Rings: The Fellowship of the Ring', 2001, 6, 6),
(8, 8, 'Mad Max: Fury Road', 2015, 7, 7),
(9, 9, 'Schindlers List', 1993, 1, 1),
(10, 10, 'Django Unchained', 2012, 3, 3),
(11, 11, 'Fight Club', 1999, 10, 10),
(12, 12, 'Get Out', 2017, 18, 18),
(13, 13, 'Hereditary', 2018, 12, 12),
(14, 14, 'Joker', 2019, 9, 9),
(15, 15, 'Once Upon a Time in Hollywood', 2019, 3, 3),
(16, 16, '1917', 2019, 14, 14),
(17, 17, 'The Irishman', 2019, 4, 4),
(18, 18, 'Parasite', 2019, 16, 16),
(19, 19, 'The Social Network', 2010, 10, 10),
(20, 20, 'La La Land', 2016, 26, 26),
(21, 21, 'Moonlight', 2016, 25, 25),
(22, 22, 'Black Panther', 2018, 25, 25),
(23, 23, 'Whiplash', 2014, 26, 26),
(24, 24, 'Blade Runner 2049', 2017, 7, 7),
(25, 25, 'Dune', 2021, 7, 7),
(26, 26, 'The Shining', 1980, 8, 8),
(27, 27, 'Psycho', 1960, 14, 14),
(28, 28, 'The Grand Budapest Hotel', 2014, 9, 9),
(29, 29, 'The French Dispatch', 2021, 9, 9),
(30, 30, 'Midsommar', 2019, 12, 12),
(31, 31, 'No Country for Old Men', 2007, 16, 16),
(32, 32, 'The Shape of Water', 2017, 16, 16),
(33, 33, 'Gravity', 2013, 5, 5),
(34, 34, 'Roma', 2018, 17, 17),
(35, 35, 'The Departed', 2006, 4, 4);


SELECT * FROM Movie

INSERT INTO TVShow (ShowID, [Name], Genre, [Date])
VALUES
(1, 'Breaking Bad', 'Crime, Thriller', '2008-01-20'),
(2, 'The Office', 'Comedy', '2005-03-24'),
(3, 'Friends', 'Comedy', '1994-09-22'),
(4, 'Game of Thrones', 'Fantasy, Drama', '2011-04-17'),
(5, 'Stranger Things', 'Sci-Fi, Horror', '2016-07-15'),
(6, 'The Mandalorian', 'Action, Sci-Fi', '2019-11-12'),
(7, 'The Crown', 'Drama', '2016-11-04'),
(8, 'House of Cards', 'Drama, Thriller', '2013-02-01'),
(9, 'The Witcher', 'Fantasy, Drama', '2019-12-20'),
(10, 'Westworld', 'Sci-Fi, Drama', '2016-10-02'),
(11, 'Better Call Saul', 'Crime, Drama', '2015-02-08'),
(12, 'The Boys', 'Action, Drama', '2019-07-26'),
(13, 'Peaky Blinders', 'Crime, Drama', '2013-09-12'),
(14, 'Fargo', 'Crime, Drama', '2014-04-15'),
(15, 'True Detective', 'Crime, Drama', '2014-01-12'),
(16, 'Sherlock', 'Crime, Drama', '2010-07-25'),
(17, 'The Walking Dead', 'Drama, Horror', '2010-10-31'),
(18, 'Arrow', 'Action, Adventure', '2012-10-10'),
(19, 'The Flash', 'Action, Sci-Fi', '2014-10-07'),
(20, 'Supernatural', 'Drama, Fantasy', '2005-09-13'),
(21, 'Homeland', 'Crime, Drama', '2011-10-02'),
(22, 'Dexter', 'Crime, Drama', '2006-10-01'),
(23, 'The X-Files', 'Sci-Fi, Drama', '1993-09-10'),
(24, 'The Simpsons', 'Comedy, Animation', '1989-12-17'),
(25, 'Rick and Morty', 'Sci-Fi, Animation', '2013-12-02'),
(26, 'BoJack Horseman', 'Comedy, Drama', '2014-08-22'),
(27, 'Narcos', 'Crime, Drama', '2015-08-28'),
(28, 'Ozark', 'Crime, Drama', '2017-07-21'),
(29, 'Dark', 'Sci-Fi, Thriller', '2017-12-01'),
(30, 'The Handmaids Tale', 'Drama, Sci-Fi', '2017-04-26'),
(31, 'The Expanse', 'Sci-Fi, Drama', '2015-12-14'),
(32, 'Mindhunter', 'Crime, Drama', '2017-10-13'),
(33, 'The Haunting of Hill House', 'Drama, Horror', '2018-10-12'),
(34, 'The Umbrella Academy', 'Action, Comedy', '2019-02-15'),
(35, 'West Wing', 'Drama', '1999-09-22');

SELECT * FROM TVShow


INSERT INTO Season (SeasonID, ShowID, Title, [Date])
VALUES 
(1, 1, 'Season 1', '2008-01-20'),
(2, 1, 'Season 2', '2009-03-08'),
(3, 1, 'Season 3', '2010-07-17'),
(4, 1, 'Season 4', '2011-07-17'),
(5, 2, 'Season 1', '2005-03-24'),
(6, 2, 'Season 2', '2006-09-21'),
(7, 2, 'Season 3', '2007-09-27'),
(8, 2, 'Season 4', '2008-09-25'),
(9, 3, 'Season 1', '1994-09-22'),
(10, 3, 'Season 2', '1995-09-21'),
(11, 3, 'Season 3', '1996-09-19'),
(12, 3, 'Season 4', '1997-09-25'),
(13, 4, 'Season 1', '2011-04-17'),
(14, 4, 'Season 2', '2012-04-01'),
(15, 4, 'Season 3', '2013-03-31'),
(16, 4, 'Season 4', '2014-04-06'),
(17, 5, 'Season 1', '2016-07-15'),
(18, 5, 'Season 2', '2017-10-27'),
(19, 5, 'Season 3', '2019-07-04'),
(20, 5, 'Season 4', '2022-05-27'),
(21, 6, 'Season 1', '2019-11-12'),
(22, 6, 'Season 2', '2020-10-30'),
(23, 6, 'Season 3', '2023-03-01'),
(24, 7, 'Season 1', '2016-11-04'),
(25, 7, 'Season 2', '2017-12-08'),
(26, 7, 'Season 3', '2019-11-17'),
(27, 8, 'Season 1', '2013-02-01'),
(28, 8, 'Season 2', '2014-02-14'),
(29, 8, 'Season 3', '2015-02-27'),
(30, 9, 'Season 1', '2019-12-20'),
(31, 9, 'Season 2', '2021-12-17'),
(32, 10, 'Season 1', '2016-10-02'),
(33, 10, 'Season 2', '2018-04-22'),
(34, 10, 'Season 3', '2020-03-15'),
(35, 10, 'Season 4', '2022-06-26');

SELECT * FROM TVShow


INSERT INTO Episode (EpisodeID, SeasonID, ShowID, DirectorID, WriterID, [Date], Title, [Length])
VALUES 
(1, 1, 1, 2, 2, '2008-01-20', 'Pilot', 58),
(2, 1, 1, 2, 2, '2008-01-27', 'Cats in the Bag...', 48),
(3, 1, 1, 2, 2, '2008-02-10', '...And the Bags in the River', 47),
(4, 1, 1, 2, 2, '2008-02-17', 'Cancer Man', 46),
(5, 1, 2, 9, 9, '2005-03-24', 'Pilot', 23),
(6, 1, 2, 9, 9, '2005-03-29', 'Diversity Day', 22),
(7, 1, 2, 9, 9, '2005-04-05', 'Health Care', 22),
(8, 1, 2, 9, 9, '2005-04-12', 'The Alliance', 21),
(9, 2, 2, 9, 9, '2006-09-21', 'Gay Witch Hunt', 22),
(10, 2, 3, 15, 15, '1994-09-22', 'The One Where Monica Gets a Roommate', 22),
(11, 2, 3, 15, 15, '1994-09-29', 'The One with the Sonogram at the End', 23),
(12, 2, 3, 15, 15, '1994-10-06', 'The One with the Thumb', 22),
(13, 3, 4, 4, 4, '2011-04-17', 'Winter is Coming', 60),
(14, 3, 4, 4, 4, '2011-04-24', 'The Kingsroad', 56),
(15, 3, 4, 4, 4, '2011-05-01', 'Lord Snow', 58),
(16, 4, 5, 5, 5, '2016-07-15', 'Chapter One: The Vanishing of Will Byers', 47),
(17, 4, 5, 5, 5, '2016-07-15', 'Chapter Two: The Weirdo on Maple Street', 55),
(18, 4, 5, 5, 5, '2016-07-15', 'Chapter Three: Holly, Jolly', 51),
(19, 5, 6, 6, 6, '2019-11-12', 'Chapter 1: The Mandalorian', 39),
(20, 5, 6, 6, 6, '2019-11-15', 'Chapter 2: The Child', 32),
(21, 5, 6, 6, 6, '2019-11-22', 'Chapter 3: The Sin', 38),
(22, 6, 7, 7, 7, '2016-11-04', 'Wolferton Splash', 57),
(23, 6, 7, 7, 7, '2016-11-04', 'Hyde Park Corner', 60),
(24, 6, 7, 7, 7, '2016-11-04', 'Windsor', 58),
(25, 7, 8, 8, 8, '2013-02-01', 'Chapter 1', 55),
(26, 7, 8, 8, 8, '2013-02-01', 'Chapter 2', 49),
(27, 7, 8, 8, 8, '2013-02-01', 'Chapter 3', 49),
(28, 8, 9, 9, 9, '2019-12-20', 'The Ends Beginning', 61),
(29, 8, 9, 9, 9, '2019-12-20', 'Four Marks', 60),
(30, 8, 9, 9, 9, '2019-12-20', 'Betrayer Moon', 67),
(31, 9, 10, 10, 10, '2016-10-02', 'The Original', 68),
(32, 9, 10, 10, 10, '2016-10-09', 'Chestnut', 60),
(33, 9, 10, 10, 10, '2016-10-16', 'The Stray', 59),
(34, 9, 10, 10, 10, '2016-10-23', 'Dissonance Theory', 56),
(35, 9, 10, 10, 10, '2016-10-30', 'Contrapasso', 56);

SELECT * FROM Episode

INSERT INTO Review (ReviewID, UserID, MovieID, [Date])
VALUES 
(1, 1, 1, '2024-10-01'),
(2, 2, 2, '2024-10-03'),
(3, 3, 3, '2024-10-05'),
(4, 4, 4, '2024-10-06'),
(5, 5, 5, '2024-10-07'),
(6, 6, 6, '2024-10-08'),
(7, 7, 7, '2024-10-09'),
(8, 8, 8, '2024-10-10'),
(9, 9, 9, '2024-10-11'),
(10, 10, 10, '2024-10-12'),
(11, 11, 11, '2024-10-13'),
(12, 12, 12, '2024-10-14'),
(13, 13, 13, '2024-10-15'),
(14, 14, 14, '2024-10-16'),
(15, 15, 15, '2024-10-17'),
(16, 16, 16, '2024-10-18'),
(17, 17, 17, '2024-10-19'),
(18, 18, 18, '2024-10-20'),
(19, 19, 19, '2024-10-21'),
(20, 20, 20, '2024-10-22'),
(21, 21, 21, '2024-10-23'),
(22, 22, 22, '2024-10-24'),
(23, 23, 23, '2024-10-25'),
(24, 24, 24, '2024-10-26'),
(25, 25, 25, '2024-10-27'),
(26, 26, 26, '2024-10-28'),
(27, 27, 27, '2024-10-29'),
(28, 28, 28, '2024-10-30'),
(29, 29, 29, '2024-10-31'),
(30, 30, 30, '2024-11-01'),
(31, 31, 31, '2024-11-02'),
(32, 32, 32, '2024-11-03'),
(33, 33, 33, '2024-11-04'),
(34, 34, 34, '2024-11-05'),
(35, 35, 35, '2024-11-06');

SELECT * FROM Review


INSERT INTO Rating (RatingID, ReviewID, UserID, MovieID, rating_value)
VALUES 
(1, 1, 1, 1, 9),
(2, 2, 2, 2, 10),
(3, 3, 3, 3, 8),
(4, 4, 4, 4, 9),
(5, 5, 5, 5, 10),
(6, 6, 6, 6, 7),
(7, 7, 7, 7, 9),
(8, 8, 8, 8, 8),
(9, 9, 9, 9, 9),
(10, 10, 10, 10, 7),
(11, 11, 11, 11, 8),
(12, 12, 12, 12, 9),
(13, 13, 13, 13, 8),
(14, 14, 14, 14, 10),
(15, 15, 15, 15, 9),
(16, 16, 16, 16, 7),
(17, 17, 17, 17, 10),
(18, 18, 18, 18, 9),
(19, 19, 19, 19, 8),
(20, 20, 20, 20, 7),
(21, 21, 21, 21, 9),
(22, 22, 22, 22, 10),
(23, 23, 23, 23, 8),
(24, 24, 24, 24, 9),
(25, 25, 25, 25, 8),
(26, 26, 26, 26, 7),
(27, 27, 27, 27, 9),
(28, 28, 28, 28, 9),
(29, 29, 29, 29, 8),
(30, 30, 30, 30, 7),
(31, 31, 31, 31, 9),
(32, 32, 32, 32, 10),
(33, 33, 33, 33, 9),
(34, 34, 34, 34, 9),
(35, 35, 35, 35, 8);


SELECT * FROM Review


INSERT INTO Genre (GenreID, Genre)
VALUES 
(1, 'Action'),
(2, 'Drama'),
(3, 'Comedy'),
(4, 'Thriller'),
(5, 'Horror'),
(6, 'Fantasy'),
(7, 'Sci-Fi'),
(8, 'Adventure'),
(9, 'Romance'),
(10, 'Mystery'),
(11, 'Musical'),
(12, 'Animation'),
(13, 'Crime'),
(14, 'Documentary'),
(15, 'War'),
(16, 'Western'),
(17, 'Family'),
(18, 'Historical'),
(19, 'Biography'),
(20, 'Superhero'),
(21, 'Sport'),
(22, 'Noir'),
(23, 'Disaster'),
(24, 'Epic'),
(25, 'Spy'),
(26, 'Political'),
(27, 'Satire'),
(28, 'Parody'),
(29, 'Silent'),
(30, 'Experimental'),
(31, 'Film Noir'),
(32, 'Psychological'),
(33, 'Suspense'),
(34, 'Coming of Age'),
(35, 'Romantic Comedy');

SELECT * FROM Genre


INSERT INTO Watchlist (WatchListID, UserID, MovieID)
VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10),
(11, 11, 11),
(12, 12, 12),
(13, 13, 13),
(14, 14, 14),
(15, 15, 15),
(16, 16, 16),
(17, 17, 17),
(18, 18, 18),
(19, 19, 19),
(20, 20, 20),
(21, 21, 21),
(22, 22, 22),
(23, 23, 23),
(24, 24, 24),
(25, 25, 25),
(26, 26, 26),
(27, 27, 27),
(28, 28, 28),
(29, 29, 29),
(30, 30, 30),
(31, 31, 31),
(32, 32, 32),
(33, 33, 33),
(34, 34, 34),
(35, 35, 35);


SELECT * FROM Genre





--Write 10 Descriptive Aggregate, Joins, Subqueries
--Finally, you are required to write 10 SQL queries that involve aggregate functions (like COUNT,
--SUM, AVG, MAX, MIN) and subqueries.


-- Aggregate Query: Find the Average Movie Rating (aggregate 1)
SELECT AVG(rating_value) AS AverageRating
FROM Rating;

-- List All Movies with Their Studios
SELECT m.Title, s.StudioName
FROM Movie m
JOIN Studio s ON m.StudioID = s.StudioID;



-- Find the Movies with Ratings Above Average (subquery1)
SELECT Title
FROM Movie
WHERE MovieID IN (
  SELECT MovieID 
  FROM Rating 
  GROUP BY MovieID 
  HAVING AVG(rating_value) > (SELECT AVG(rating_value) FROM Rating)
);

--Find the Minimum Rating Given by Any User
SELECT MIN(rating_value) AS HighestRating
FROM Rating;

--Find the Maximum Rating Given by Any User
SELECT MAX(rating_value) AS HighestRating
FROM Rating;

--List All TV Shows Along with Their Genres
SELECT t.[Name] AS ShowName, t.Genre
FROM TVShow t;

-- Find the Users Who Have Watched "Inception" (Subquery2)
SELECT [Name], Email
FROM [User]
WHERE UserID IN (
  SELECT UserID 
  FROM Watchlist 
  WHERE MovieID = (SELECT MovieID FROM Movie WHERE Title = 'Inception')
);

-- Directors Who Have Directed More Than 2 Movies (subquery + aggregate)
SELECT p.[Name] AS DirectorName
FROM Director d
JOIN Person p ON d.person_id = p.PersonID
WHERE d.person_id IN (
  SELECT DirectorID
  FROM Movie
  GROUP BY DirectorID
  HAVING COUNT(MovieID) > 2
);

-- Total reviews
SELECT COUNT(*) AS TotalReviews
FROM Review;

-- Movies after 2010
SELECT COUNT(*) AS MoviesAfter2010
FROM Movie
WHERE [Year] > 2010;

-- Total Movies
SELECT COUNT(*) AS TotalMovies
FROM Movie;


--List All Users Who Have Reviewed a Movie with a Rating of 10
SELECT [Name], Email
FROM [User]
WHERE UserID IN (SELECT UserID FROM Rating WHERE rating_value = 10);
