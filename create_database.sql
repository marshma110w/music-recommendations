CREATE TABLE genres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE artists (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE tracks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    is_russian BOOLEAN NOT NULL DEFAULT false,
    mood VARCHAR(32),
    artist_id INT,
    genre_id INT,
    external_id VARCHAR(20),
    FOREIGN KEY (artist_id) REFERENCES artists(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    login VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE users_tracks_likes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INT,
    track_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (track_id) REFERENCES tracks(id),
    UNIQUE (user_id, track_id)
);

CREATE TABLE users_artists_likes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INT,
    artist_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (artist_id) REFERENCES artists(id),
    UNIQUE (user_id, artist_id)
);



INSERT INTO genres (name) VALUES 
('Хип-хоп/Рэп'),
('Поп'),
('Рок'),
('Хаус');


INSERT INTO artists (name, genre_id) VALUES 
('Jay-Z', 1),
('Eminem', 1),
('Kanye West', 1),
('Nicki Minaj', 1),
('Kendrick Lamar', 1),
('Taylor Swift', 2),
('Ariana Grande', 2),
('Ed Sheeran', 2),
('Madonna', 2),
('Lady Gaga', 2),
('The Rolling Stones', 3),
('Foo Fighters', 3),
('Green Day', 3),
('Linkin Park', 3),
('U2', 3),
('Avicii', 4),
('Tiesto', 4),
('David Guetta', 4),
('Deadmau5', 4),
('Calvin Harris', 4);


INSERT INTO tracks (name, artist_id, genre_id) VALUES 
-- Jay-Z
('Empire State of Mind', 1, 1),
('99 Problems', 1, 1),
('Hard Knock Life', 1, 1),
('Holy Grail', 1, 1),
('Run This Town', 1, 1),
-- Eminem
('Lose Yourself', 2, 1),
('The Real Slim Shady', 2, 1),
('Without Me', 2, 1),
('Rap God', 2, 1),
('Stan', 2, 1),
-- Kanye West
('Stronger', 3, 1),
('Gold Digger', 3, 1),
('Heartless', 3, 1),
('All of the Lights', 3, 1),
('Runaway', 3, 1),
-- Nicki Minaj
('Super Bass', 4, 1),
('Starships', 4, 1),
('Anaconda', 4, 1),
('Pound the Alarm', 4, 1),
('Bang Bang', 4, 1),
-- Kendrick Lamar
('HUMBLE.', 5, 1),
('Alright', 5, 1),
('King Kunta', 5, 1),
('Swimming Pools (Drank)', 5, 1),
('DNA.', 5, 1),
-- Taylor Swift
('Love Story', 6, 2),
('Shake It Off', 6, 2),
('Blank Space', 6, 2),
('You Belong With Me', 6, 2),
('I Knew You Were Trouble', 6, 2),
-- Ariana Grande
('Thank U, Next', 7, 2),
('7 Rings', 7, 2),
('Problem', 7, 2),
('Into You', 7, 2),
('No Tears Left to Cry', 7, 2),
-- Ed Sheeran
('Shape of You', 8, 2),
('Thinking Out Loud', 8, 2),
('Perfect', 8, 2),
('Photograph', 8, 2),
('Castle on the Hill', 8, 2),
-- Madonna
('Like a Virgin', 9, 2),
('Like a Prayer', 9, 2),
('Material Girl', 9, 2),
('Vogue', 9, 2),
('Hung Up', 9, 2),
-- Lady Gaga
('Bad Romance', 10, 2),
('Poker Face', 10, 2),
('Born This Way', 10, 2),
('Shallow', 10, 2),
('Just Dance', 10, 2),

-- The Rolling Stones
('Angie', 11, 3),
('Sympathy for the Devil', 11, 3),
('Miss You', 11, 3),
('Wild Horses', 11, 3),
('You Can''t Always Get What You Want', 11, 3),
-- Foo Fighters
('Everlong', 12, 3),
('The Pretender', 12, 3),
('Learn to Fly', 12, 3),
('Best of You', 12, 3),
('Times Like These', 12, 3),
-- Green Day
('Basket Case', 13, 3),
('American Idiot', 13, 3),
('Wake Me Up When September Ends', 13, 3),
('Good Riddance (Time of Your Life)', 13, 3),
('Boulevard of Broken Dreams', 13, 3),
-- Linkin Park
('In the End', 14, 3),
('Numb', 14, 3),
('Crawling', 14, 3),
('One Step Closer', 14, 3),
('Breaking the Habit', 14, 3),
-- U2
('With or Without You', 15, 3),
('I Still Haven''t Found What I''m Looking For', 15, 3),
('One', 15, 3),
('Beautiful Day', 15, 3),
('Sunday Bloody Sunday', 15, 3),
-- Avicii
('Wake Me Up', 16, 4),
('Levels', 16, 4),
('The Nights', 16, 4),
('Waiting for Love', 16, 4),
('Hey Brother', 16, 4),
-- Tiesto
('Red Lights', 17, 4),
('The Business', 17, 4),
('Jackie Chan', 17, 4),
('Secrets', 17, 4),
('Ritual', 17, 4),
-- David Guetta
('Titanium', 18, 4),
('Without You', 18, 4),
('Hey Mama', 18, 4),
('Sexy Bitch', 18, 4),
('Play Hard', 18, 4),
-- Deadmau5
('Ghosts ''n'' Stuff', 19, 4),
('Strobe', 19, 4),
('I Remember', 19, 4),
('Raise Your Weapon', 19, 4),
('The Veldt', 19, 4),
-- Calvin Harris
('Summer', 20, 4),
('Feel So Close', 20, 4),
('This Is What You Came For', 20, 4),
('Outside', 20, 4),
('How Deep Is Your Love', 20, 4);


UPDATE tracks SET external_id = '0UjsXo9l6I8' WHERE name = 'Empire State of Mind';
UPDATE tracks SET external_id = 'WwoM5fLITfk' WHERE name = '99 Problems';
UPDATE tracks SET external_id = '9AjkUyX0rVw' WHERE name = 'Hard Knock Life';
UPDATE tracks SET external_id = '6AIdXisPqHc' WHERE name = 'Holy Grail';
UPDATE tracks SET external_id = 'ejOR7n9vg3I' WHERE name = 'Run This Town';
UPDATE tracks SET external_id = '_Yhyp-_hX2s' WHERE name = 'Lose Yourself';
UPDATE tracks SET external_id = 'eJO5HU_7_1w' WHERE name = 'The Real Slim Shady';
UPDATE tracks SET external_id = 'YVkUvmDQ3HY' WHERE name = 'Without Me';
UPDATE tracks SET external_id = 'XbGs_qK2PQA' WHERE name = 'Rap God';
UPDATE tracks SET external_id = 'aSLZFdqwh7E' WHERE name = 'Stan';
UPDATE tracks SET external_id = 'PsO6ZnUZI0g' WHERE name = 'Stronger';
UPDATE tracks SET external_id = '6vwNcNOTVzY' WHERE name = 'Gold Digger';
UPDATE tracks SET external_id = 'Co0tTeuUVhU' WHERE name = 'Heartless';
UPDATE tracks SET external_id = 'HAfFfqiYLp0' WHERE name = 'All of the Lights';
UPDATE tracks SET external_id = 'OYws8biwOYc' WHERE name = 'Runaway';
UPDATE tracks SET external_id = '4JipHEz53sU' WHERE name = 'Super Bass';
UPDATE tracks SET external_id = 'SeIJmciN8mo' WHERE name = 'Starships';
UPDATE tracks SET external_id = 'LDZX4ooRsWs' WHERE name = 'Anaconda';
UPDATE tracks SET external_id = 'vdrqA93sW-8' WHERE name = 'Pound the Alarm';
UPDATE tracks SET external_id = '0HDdjwpPM3Y' WHERE name = 'Bang Bang';
UPDATE tracks SET external_id = 'tvTRZJ-4EyI' WHERE name = 'HUMBLE.';
UPDATE tracks SET external_id = 'Z-48u_uWMHY' WHERE name = 'Alright';
UPDATE tracks SET external_id = 'hRK7PVJFbS8' WHERE name = 'King Kunta';
UPDATE tracks SET external_id = '8-ejyHzz3XE' WHERE name = 'Swimming Pools (Drank)';
UPDATE tracks SET external_id = 'NLZRYQMLDW4' WHERE name = 'DNA.';
UPDATE tracks SET external_id = '8xg3vE8Ie_E' WHERE name = 'Love Story';
UPDATE tracks SET external_id = 'nfWlot6h_JM' WHERE name = 'Shake It Off';
UPDATE tracks SET external_id = 'e-ORhEE9VVg' WHERE name = 'Blank Space';
UPDATE tracks SET external_id = 'VuNIsY6JdUw' WHERE name = 'You Belong With Me';
UPDATE tracks SET external_id = 'vNoKguSdy4Y' WHERE name = 'I Knew You Were Trouble';
UPDATE tracks SET external_id = 'gl1aHhXnN1k' WHERE name = 'Thank U, Next';
UPDATE tracks SET external_id = 'QYh6mYIJG2Y' WHERE name = '7 Rings';
UPDATE tracks SET external_id = 'iS1g8G_njx8' WHERE name = 'Problem';
UPDATE tracks SET external_id = '1ekzeVeXwek' WHERE name = 'Into You';
UPDATE tracks SET external_id = 'ffxKSjUwKdU' WHERE name = 'No Tears Left to Cry';
UPDATE tracks SET external_id = 'JGwWNGJdvx8' WHERE name = 'Shape of You';
UPDATE tracks SET external_id = 'lp-EO5I60KA' WHERE name = 'Thinking Out Loud';
UPDATE tracks SET external_id = '2Vv-BfVoq4g' WHERE name = 'Perfect';
UPDATE tracks SET external_id = 'nSDgHBxUbVQ' WHERE name = 'Photograph';
UPDATE tracks SET external_id = 'K0ibBPhiaG0' WHERE name = 'Castle on the Hill';
UPDATE tracks SET external_id = 's__rX_WL100' WHERE name = 'Like a Virgin';
UPDATE tracks SET external_id = '79fzeNUqQbQ' WHERE name = 'Like a Prayer';
UPDATE tracks SET external_id = 'Fy8mO8jy4C8' WHERE name = 'Material Girl';
UPDATE tracks SET external_id = 'GuJQSAiODqI' WHERE name = 'Vogue';
UPDATE tracks SET external_id = 'EDwb9jOVRtU' WHERE name = 'Hung Up';
UPDATE tracks SET external_id = 'qrO4YZeyl0I' WHERE name = 'Bad Romance';
UPDATE tracks SET external_id = 'bESGLojNYSo' WHERE name = 'Poker Face';
UPDATE tracks SET external_id = 'wV1FrqwZyKw' WHERE name = 'Born This Way';
UPDATE tracks SET external_id = 'bo_efYhYU2A' WHERE name = 'Shallow';
UPDATE tracks SET external_id = '2Abk1jAONjw' WHERE name = 'Just Dance';
UPDATE tracks SET external_id = '5vK-ZiQTvDg' WHERE name = 'Angie';
UPDATE tracks SET external_id = 'GgnClrx8N2k' WHERE name = 'Sympathy for the Devil';
UPDATE tracks SET external_id = 'wCJG6qCCyt0' WHERE name = 'Miss You';
UPDATE tracks SET external_id = '5N0tAzvI-Go' WHERE name = 'Wild Horses';
UPDATE tracks SET external_id = 'EhVWnbfoolc' WHERE name = 'You Can''t Always Get What You Want';
UPDATE tracks SET external_id = 'eBG7P-K-r1Y' WHERE name = 'Everlong';
UPDATE tracks SET external_id = 'SBjQ9tuuTJQ' WHERE name = 'The Pretender';

UPDATE tracks SET external_id = '1VQ_3sBZEm0' WHERE name = 'Learn to Fly';
UPDATE tracks SET external_id = 'h_L4Rixya64' WHERE name = 'Best of You';
UPDATE tracks SET external_id = 'BMkBgYTbBtQ' WHERE name = 'Times Like These';
UPDATE tracks SET external_id = 'NUTGr5t3MoY' WHERE name = 'Basket Case';
UPDATE tracks SET external_id = 'Ee_uujKuJMI' WHERE name = 'American Idiot';
UPDATE tracks SET external_id = 'NU9JoFKlaZ0' WHERE name = 'Wake Me Up When September Ends';
UPDATE tracks SET external_id = 'CnQ8N1KacJc' WHERE name = 'Good Riddance (Time of Your Life)';
UPDATE tracks SET external_id = 'Soa3gO7tL-c' WHERE name = 'Boulevard of Broken Dreams';
UPDATE tracks SET external_id = 'eVTXPUF4Oz4' WHERE name = 'In the End';
UPDATE tracks SET external_id = 'kXYiU_JCYtU' WHERE name = 'Numb';
UPDATE tracks SET external_id = 'Gd9OhYroLN0' WHERE name = 'Crawling';
UPDATE tracks SET external_id = '4qlCC1GOwFw' WHERE name = 'One Step Closer';
UPDATE tracks SET external_id = 'v2H4l9RpkwM' WHERE name = 'Breaking the Habit';
UPDATE tracks SET external_id = 'XmSdTa9kaiQ' WHERE name = 'With or Without You';

UPDATE tracks SET external_id = 'e3-5YC_oHjE' WHERE name = 'I Still Haven''t Found What I''m Looking For';
UPDATE tracks SET external_id = 'ftjEcrrf7r0' WHERE name = 'One';
UPDATE tracks SET external_id = 'co6WMzDOh1o' WHERE name = 'Beautiful Day';
UPDATE tracks SET external_id = 'SvK3R2PACKw' WHERE name = 'Sunday Bloody Sunday';
UPDATE tracks SET external_id = 'IcrbM1l_BoI' WHERE name = 'Wake Me Up';
UPDATE tracks SET external_id = '_ovdm2yX4MA' WHERE name = 'Levels';
UPDATE tracks SET external_id = 'UtF6Jej8yb4' WHERE name = 'The Nights';
UPDATE tracks SET external_id = 'cHHLHGNpCSA' WHERE name = 'Waiting for Love';
UPDATE tracks SET external_id = 'YxIiPLVR6NA' WHERE name = 'Hey Brother';

UPDATE tracks SET external_id = 'SfINPNM9Buo' WHERE name = 'Red Lights';
UPDATE tracks SET external_id = 'Gdj82s3DpWY' WHERE name = 'The Business';
UPDATE tracks SET external_id = '3c3Ee0C9zDQ' WHERE name = 'Jackie Chan';
UPDATE tracks SET external_id = 'Mk8xYgEkvBE' WHERE name = 'Secrets';

UPDATE tracks SET external_id = 'dtQQzKk7_KQ' WHERE name = 'Ritual';
UPDATE tracks SET external_id = 'JRfuAukYTKg' WHERE name = 'Titanium';
UPDATE tracks SET external_id = 'jUe8uoKdHao' WHERE name = 'Without You';
UPDATE tracks SET external_id = 'uO59tfQ2TbA' WHERE name = 'Hey Mama';
UPDATE tracks SET external_id = '1DPTpIC4mDE' WHERE name = 'Sexy Bitch';
UPDATE tracks SET external_id = '5dbEhBKGOtY' WHERE name = 'Play Hard';
UPDATE tracks SET external_id = 'h7ArUgxtlJs' WHERE name = 'Ghosts ''n'' Stuff';
UPDATE tracks SET external_id = 'tKi9Z-f6qX4' WHERE name = 'Strobe';
UPDATE tracks SET external_id = 'zltvWcctE6g' WHERE name = 'I Remember';
UPDATE tracks SET external_id = 'YnwfTHpnGLY' WHERE name = 'Raise Your Weapon';
UPDATE tracks SET external_id = 'uiUAq4aVTjY' WHERE name = 'The Veldt';
UPDATE tracks SET external_id = 'ebXbLfLACGM' WHERE name = 'Summer';
UPDATE tracks SET external_id = 'dGghkjpNCQ8' WHERE name = 'Feel So Close';
UPDATE tracks SET external_id = 'kOkQ4T5WO9E' WHERE name = 'This Is What You Came For';
UPDATE tracks SET external_id = 'J9NQFACZYEU' WHERE name = 'Outside';
UPDATE tracks SET external_id = 'EgqUJOudrcM' WHERE name = 'How Deep Is Your Love';

UPDATE tracks SET mood = 'бодрое' WHERE name = 'Empire State of Mind';
UPDATE tracks SET mood = 'бодрое' WHERE name = '99 Problems';
UPDATE tracks SET mood = 'грустное' WHERE name = 'Hard Knock Life';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Holy Grail';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Run This Town';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Lose Yourself';
UPDATE tracks SET mood = 'веселое' WHERE name = 'The Real Slim Shady';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Without Me';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Rap God';
UPDATE tracks SET mood = 'грустное' WHERE name = 'Stan';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Stronger';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Gold Digger';
UPDATE tracks SET mood = 'грустное' WHERE name = 'Heartless';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'All of the Lights';
UPDATE tracks SET mood = 'грустное' WHERE name = 'Runaway';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Super Bass';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Starships';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Anaconda';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Pound the Alarm';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Bang Bang';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'HUMBLE.';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Alright';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'King Kunta';
UPDATE tracks SET mood = 'грустное' WHERE name = 'Swimming Pools (Drank)';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'DNA.';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Love Story';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Shake It Off';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Blank Space';
UPDATE tracks SET mood = 'веселое' WHERE name = 'You Belong With Me';
UPDATE tracks SET mood = 'грустное' WHERE name = 'I Knew You Were Trouble';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Thank U, Next';
UPDATE tracks SET mood = 'веселое' WHERE name = '7 Rings';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Problem';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Into You';
UPDATE tracks SET mood = 'веселое' WHERE name = 'No Tears Left to Cry';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Shape of You';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Thinking Out Loud';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Perfect';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Photograph';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Castle on the Hill';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Like a Virgin';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Like a Prayer';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Material Girl';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Vogue';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Hung Up';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Bad Romance';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Poker Face';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Born This Way';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Shallow';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Just Dance';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Angie';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Sympathy for the Devil';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Miss You';
UPDATE tracks SET mood = 'грустное' WHERE name = 'Wild Horses';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'You Can''t Always Get What You Want';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Everlong';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'The Pretender';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Learn to Fly';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Best of You';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Times Like These';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Basket Case';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'American Idiot';
UPDATE tracks SET mood = 'грустное' WHERE name = 'Wake Me Up When September Ends';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Good Riddance (Time of Your Life)';
UPDATE tracks SET mood = 'грустное' WHERE name = 'Boulevard of Broken Dreams';
UPDATE tracks SET mood = 'грустное' WHERE name = 'In the End';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Numb';
UPDATE tracks SET mood = 'грустное' WHERE name = 'Crawling';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'One Step Closer';
UPDATE tracks SET mood = 'грустное' WHERE name = 'Breaking the Habit';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'With or Without You';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'I Still Haven''t Found What I''m Looking For';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'One';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Beautiful Day';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Sunday Bloody Sunday';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Wake Me Up';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Levels';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'The Nights';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Waiting for Love';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Hey Brother';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Red Lights';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'The Business';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Jackie Chan';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Secrets';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Ritual';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Titanium';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Without You';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Hey Mama';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Sexy Bitch';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Play Hard';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Ghosts ''n'' Stuff';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'Strobe';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'I Remember';
UPDATE tracks SET mood = 'грустное' WHERE name = 'Raise Your Weapon';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'The Veldt';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Summer';
UPDATE tracks SET mood = 'веселое' WHERE name = 'Feel So Close';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'This Is What You Came For';
UPDATE tracks SET mood = 'бодрое' WHERE name = 'Outside';
UPDATE tracks SET mood = 'спокойное' WHERE name = 'How Deep Is Your Love';


INSERT INTO users (login, password) VALUES
('abc', 'abc'),
('bot1', 'bot1'),
('bot2', 'bot2'),
('bot3', 'bot3'),
('bot4', 'bot4'),
('bot5', 'bot5'),
('bot6', 'bot6');

INSERT INTO users_tracks_likes (user_id, track_id) VALUES
(1, 1),
(1, 2),
(1, 4),
(1, 20),
(1, 50),
(1, 77),
(1, 99),
(2, 24),
(2, 57),
(2, 89),
(2, 42),
(2, 61),
(2, 5),
(2, 70),
(2, 66),
(2, 30),
(2, 81),
(2, 74),
(2, 36),
(2, 96),
(2, 91),
(2, 60),
(2, 71),
(2, 20),
(2, 82),
(2, 56),
(2, 63),
(2, 37),
(2, 19),
(2, 95),
(2, 12),
(2, 28),
(2, 62),
(2, 90),
(2, 26),
(3, 86),
(3, 10),
(3, 59),
(3, 97),
(3, 53),
(3, 22),
(3, 52),
(3, 72),
(3, 15),
(3, 91),
(3, 40),
(3, 64),
(3, 9),
(3, 3),
(3, 49),
(3, 57),
(3, 5),
(3, 25),
(3, 32),
(3, 84),
(3, 48),
(3, 61),
(3, 92),
(3, 93),
(3, 46),
(3, 14),
(3, 71),
(3, 47),
(3, 73),
(3, 28),
(3, 29),
(3, 95),
(3, 1),
(3, 100),
(3, 6),
(3, 54),
(3, 90),
(3, 13),
(3, 68),
(3, 58),
(3, 66),
(4, 32),
(4, 99),
(4, 54),
(4, 62),
(4, 78),
(4, 15),
(4, 83),
(4, 27),
(4, 21),
(4, 91),
(4, 75),
(4, 1),
(4, 90),
(4, 36),
(4, 80),
(4, 74),
(4, 44),
(4, 48),
(4, 76),
(4, 92),
(4, 64),
(4, 16),
(4, 23),
(4, 87),
(4, 7),
(4, 63),
(4, 3),
(4, 61),
(4, 5),
(4, 10),
(4, 25),
(4, 17),
(4, 19),
(4, 88),
(5, 81),
(5, 22),
(5, 99),
(5, 54),
(5, 2),
(5, 29),
(5, 50),
(5, 8),
(5, 44),
(5, 91),
(5, 17),
(5, 4),
(5, 32),
(5, 77),
(5, 89),
(5, 11),
(5, 87),
(5, 38),
(5, 52),
(5, 37),
(5, 28),
(5, 64),
(5, 76),
(5, 5),
(5, 85),
(5, 90),
(5, 45),
(5, 49),
(5, 24),
(5, 95),
(5, 82),
(5, 46),
(5, 25),
(5, 63),
(5, 80),
(5, 97),
(5, 61),
(5, 56),
(5, 9),
(5, 42),
(5, 72),
(6, 53),
(6, 36),
(6, 65),
(6, 84),
(6, 98),
(6, 10),
(6, 37),
(6, 2),
(6, 25),
(6, 96),
(6, 46),
(6, 19),
(6, 41),
(6, 66),
(6, 60),
(6, 35),
(6, 67),
(6, 95),
(6, 34),
(6, 99),
(6, 48),
(6, 3),
(6, 94),
(6, 70),
(6, 56),
(6, 29),
(6, 39),
(6, 13),
(6, 5),
(6, 11),
(6, 92),
(7, 67),
(7, 68),
(7, 82),
(7, 25),
(7, 42),
(7, 43),
(7, 13),
(7, 60),
(7, 62),
(7, 7),
(7, 94),
(7, 71),
(7, 5),
(7, 59),
(7, 28),
(7, 89),
(7, 29),
(7, 65),
(7, 47),
(7, 76),
(7, 54),
(7, 18),
(7, 99),
(7, 9),
(7, 81),
(7, 51),
(7, 36),
(7, 31),
(7, 73),
(7, 48),
(7, 24),
(7, 8),
(7, 30),
(7, 56);
