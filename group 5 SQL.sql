CREATE DATABASE EntertainmentDB;

USE EntertainmentDB;

####create table for Famous People
CREATE TABLE FamousPeople (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(100),
    profession VARCHAR(30),
    net_worth DECIMAL(12,2)
);
#### Insert into FamousPeople
INSERT INTO FamousPeople (name, birth_date, nationality, profession, net_worth) VALUES
('Dwayne Johnson', '1984-11-11', 'USA', 'Actor', 260000000),
('Celine Dion', '1941-09-04', 'USA', 'Singer', 500000000),
('Chris Brown', '1998-09-25', 'USA', 'Both', 350000000),
('Adele', '1988-05-05', 'UK', 'Singer', 220000000),
('Johnny Depp', '1965-06-09', 'USA', 'Singer', 200000000),
('Rihanna', '1989-02-20', 'Barbados', 'Both', 170000000),
('Brad Pitt', '1973-12-18', 'USA', 'Actor', 400000000),
('Ed Sheeran', '1994-02-17', 'UK', 'Singer', 200000000),
('Keke Palmer', '1995-03-28', 'USA', 'Both', 320000000),
('Tom Cruise', '1972-07-03', 'USA', 'Actor', 600000000),
('Akabenezer', '1975-07-03', 'GHANA', 'Actor', 700000000),
('Agya Koo', '1972-09-03', 'USA', 'Both', 650000000),
('Nicki Minaj', '1992-09-03', 'USA', 'Both', 890000000),
('fifty cent', '1979-03-03', 'USA', 'Both', 500000000),
('Selena Gomez', '1992-06-06', 'USA', 'Actor', 680000000),
('Ludacris', '1972-07-08', 'USA', 'Both', 710000000),
('Kendrick Lamar', '1980-07-03', 'USA', 'Actor', 960000000),
('Drake', '1989-05-03', 'USA', 'singer', 870000000),
('Sam Locco', '1962-10-03', 'NIGERIA', 'Actor', 6900000000),
('Van Vicker', '1975-06-06', 'GHANA', 'Actor', 800000000),
('Kim K', '1992-09-03', 'USA', 'Actor', 630000000),
('Lil wayne', '1977-07-03', 'USA', 'Singer', 610000000),
('Sabinus', '1999-05-08', 'NIGERIA', 'Actor', 950000000),
('Wizkid', '1989-07-03', 'NIGERIA', 'Singer', 840000000),
('Stormzy', '1995-02-02', 'UK', 'Singer', 770000000),
('Bob Marley', '1971-01-01', 'JAMAICA', 'Singer', 740000000),
('Jamie Foxx', '1980-06-09', 'USA', 'Both', 690000000),
('Scarlett Johanson', '1992-09-09', 'USA', 'Both', 470000000),
('Kate Winslet', '1982-04-04', 'USA', 'Both', 580000000),
('Adjoa Smart', '1977-05-03', 'GHANA', 'Both', 430000000),
('Maame Dorkono', '1969-07-07', 'GHANA', 'Singer', 660000000);

####create table for movies
CREATE TABLE Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year YEAR,
    genre VARCHAR(100),
    revenue DECIMAL(15,2),
    actor_id INT,
    FOREIGN KEY (actor_id) REFERENCES FamousPeople(person_id)
);
##Insert table into movies
INSERT INTO Movies (title, release_year, genre, revenue, actor_id) VALUES
('Whitehouse', 1997, 'Romance', 2200000000, 1),
('Gunpoint', 1997, 'Sci-Fi', 589000000, 3),
('Garden of Eden',2000,'Sci-Fi',2250000000,5),
('Sin no more', 1999, 'Drama', 101000000, 7),
('Mission possible', 1996, 'Action', 457000000, 10);

##Create table for Music
CREATE TABLE Songs (
    song_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year YEAR,
    genre VARCHAR(100),
    revenue DECIMAL(15,2),
    singer_id INT,
    FOREIGN KEY (singer_id) REFERENCES FamousPeople(person_id)
);
###Insert values into music
INSERT INTO Songs (title, release_year, genre, revenue, singer_id) VALUES
('Halo', 2008, 'R&B', 10000000, 2),
('Hello', 2015, 'Pop', 12000000, 4),
('Umbrella', 2007, 'Pop', 15000000, 6),
('Shape of You', 2017, 'Pop', 18000000, 8),
('Poker Face', 2008, 'Pop', 14000000, 9);

## create table for awards
CREATE TABLE Awards (
    award_id INT AUTO_INCREMENT PRIMARY KEY,
    award_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    year_received YEAR,
    person_id INT,
    FOREIGN KEY (person_id) REFERENCES FamousPeople(person_id)
);
##Insert values into awards
INSERT INTO Awards (award_name, category, year_received, person_id) VALUES
('Oscar', 'Best Actor', 2016, 1),
('Grammy', 'Best Song', 2010, 2),
('Grammy', 'Best Album', 2012, 4),
('Oscar', 'Best Supporting Actor', 2008, 5),
('MTV Award', 'Best Pop Song', 2017, 9);

####Create table for regions
CREATE TABLE Regions (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(100),
    continent VARCHAR(100),
    famous_person_id INT,
    FOREIGN KEY (famous_person_id) REFERENCES FamousPeople(person_id)
);
### insert values into regions
INSERT INTO Regions (country, continent, famous_person_id) VALUES
('USA', 'North America', 1),
('UK', 'Europe', 4),
('Barbados', 'North America', 6),
('USA', 'North America', 7),
('USA', 'North America', 10);

SELECT *
FROM FamousPeople;

SELECT *
FROM Movies;

SELECT *
FROM Songs;

SELECT *
FROM Awards;

##TOP 5 MOST CONNECTED(BOTH)
SELECT name, count(*) AS total_works 
FROM FamousPeople
WHERE profession = 'Both'
GROUP BY name
ORDER BY total_works DESC
LIMIT 5;

SELECT *
FROM Regions;

###GEOGRAPHIC DISTRIBUTION OF FAMOUS PEOPLE
SELECT r.country, COUNT(*) AS total_people
FROM Regions r
JOIN FamousPeople f ON r.famous_person_id = f.person_id
GROUP BY r.country
ORDER BY total_people DESC;

###AWARD DISTRIBUTION ACROSS CATEGORY
SELECT category, COUNT(*) AS total_awards 
FROM Awards 
GROUP BY category 
ORDER BY total_awards DESC;

##TREND OF REVENUE FOR MUSIC AND SONG BY YEAR
SELECT release_year, SUM(revenue) AS total_revenue 
FROM (
    SELECT release_year, revenue FROM Movies 
    UNION ALL 
    SELECT release_year, revenue FROM Songs
) AS combined
GROUP BY release_year
ORDER BY release_year;

###MOST COMMONLY WON AWARD
SELECT category, COUNT(*) AS occurrences 
FROM Awards 
GROUP BY category 
ORDER BY occurrences DESC 
LIMIT 5;
 
 
 ####5 LEAST SUCCESSFUL PPL IN THE FIELD
 SELECT f.name, SUM(IFNULL(m.revenue, 0) + IFNULL(s.revenue, 0)) AS total_revenue
FROM FamousPeople f
LEFT JOIN Movies m ON f.person_id = m.actor_id
LEFT JOIN Songs s ON f.person_id = s.singer_id
GROUP BY f.name
ORDER BY total_revenue ASC
LIMIT 5;












