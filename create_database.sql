CREATE TABLE genres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE moods (
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
    mood_id INT,
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
('Хип-хоп'),
('Поп'),
('Рок'),
('Хаус'),
('Блюз'),
('Джаз'),
('Кантри'),
('Регги'),
('Диско'),
('Фанк'),
('Инструментал');

INSERT INTO moods (name) VALUES 
('бодрое'),
('грустное'),
('веселое'),
('спокойное');


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
('Calvin Harris', 4),
('B.B. King',5),
('Muddy Waters',5),
('Robert Johnson',5),
('John Lee Hooker',5),
("Howlin' Wolf",5),
('Miles Davis',6),
('John Coltrane',6),
('Charlie Parker',6),
('Ella Fitzgerald',6),
('Louis Armstrong',6),
('Johnny Cash',7),
('Dolly Parton',7),
('Willie Nelson',7),
('Garth Brooks',7),
('Bob Marley',8),
('Peter Tosh',8),    
('Bunny Wailer',8),
('Jimmy Cliff',8),
('Toots and the Maytals',8),
('Bee Gees',9),
('Donna Summer',9),
('ABBA',9),
('Gloria Gaynor',9),
('Chic',9),
('James Brown',10),
('Parliament-Funkadelic',10),
('Sly and the Family Stone',10),
('Earth, Wind & Fire',10),
('Kool & the Gang',10),
('The Ventures',11),
("Booker T. & the M.G.'s",11),
('Joe Satriani',11),
('Steve Vai',11),
('Yngwie Malmsteen',11);
INSERT INTO tracks (name, artist_id, genre_id) VALUES 
("Empire State Of Mind", 1, 1),
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
("You Can't Always Get What You Want", 11, 3),
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
("I Still Haven't Found What I'm Looking For", 15, 3),
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
("Ghosts 'n' Stuff", 19, 4),
('Strobe', 19, 4),
('I Remember', 19, 4),
('Raise Your Weapon', 19, 4),
('The Veldt', 19, 4),
-- Calvin Harris
('Summer', 20, 4),
('Feel So Close', 20, 4),
('This Is What You Came For', 20, 4),
('Outside', 20, 4),
('How Deep Is Your Love', 20, 4),
-- B.B. King
('The Thrill Is Gone', 21, 5),
('Every Day I Have the Blues', 21, 5),
('Sweet Little Angel', 21, 5),
('Rock Me Baby', 21, 5),
("Payin' the Cost to Be the Boss", 21, 5),
-- Muddy Waters
('Hoochie Coochie Man',22,5),
('Mannish Boy',22,5),
('Got My Mojo Working',22,5),
("Rollin' Stone",22,5),
("I'm Your Hoochie Coochie Man",22,5),
-- Robert Johnson
('Cross Road Blues',23,5),
('Love in Vain',23,5),
('Sweet Home Chicago',23,5),
('Me and the Devil Blues',23,5),
('Traveling Riverside Blues',23,5),
-- John Lee Hooker
('Boom Boom',24,5),
('One Bourbon, One Scotch, One Beer',24,5),
("Boogie Chillen'",24,5),
('Dimples',24,5),
("Crawlin' King Snake",24,5),
-- Howlin Wolf
("Smokestack Lightnin'",25,5),
('Spoonful',25,5),
('Back Door Man',25,5),
('Killing Floor',25,5),
('Evil',25,5),

-- Miles Davis:**
('So What', 26, 6),
('All Blues', 26, 6),
('Kind of Blue', 26, 6),
('Blue in Green', 26, 6),
('Freddie Freeloader', 26, 6),
-- John Coltrane:**
('Giant Steps', 27, 6),
('My Favorite Things', 27, 6),
('A Love Supreme', 27, 6),
('Blue Train', 27, 6),
('Impressions', 27, 6),
-- Charlie Parker:**
("Now's the Time", 28, 6),
('Confirmation', 28, 6),
('Yardbird Suite', 28, 6),
('Ornithology', 28, 6),
('Anthropology', 28, 6),
--Ella Fitzgerald:**
('Summertime', 29, 6),
('A-Tisket, A-Tasket', 29, 6),
('Dream a Little Dream of Me', 29, 6),
('Mack the Knife', 29, 6),
("They Can't Take That Away from Me", 29, 6),
-- Louis Armstrong:**
('What a Wonderful World', 30, 6),
('Hello, Dolly!', 30, 6),
('La Vie En Rose', 30, 6),
('When the Saints Go Marching In',30, 6),
('Blueberry Hill',30, 6),

-- Johnny Cash:**
('Ring of Fire', 31, 7),
('I Walk the Line', 31, 7),
('A Boy Named Sue', 31, 7),
('Folsom Prison Blues', 31, 7),
('Hurt', 31, 7),
-- Dolly Parton:**
('Jolene', 32, 7),
('9 to 5', 32, 7),
('I Will Always Love You', 32, 7),
('Coat of Many Colors', 32, 7),
('Here You Come Again', 32, 7),
-- Willie Nelson:**
('On the Road Again', 33, 7),
('Crazy', 33, 7),
('Blue Eyes Crying in the Rain', 33, 7),
('Always on My Mind', 33, 7),
("Mammas Don't Let Your Babies Grow Up to Be Cowboys", 33, 7),
-- Garth Brooks:**
('Friends in Low Places', 34, 7),
('The Thunder Rolls', 34, 7),
('The Dance', 34, 7),
('If Tomorrow Never Comes', 34, 7),
('Shameless', 34, 7),

--Bob Marley:**
('No Woman, No Cry', 35, 8),
('Redemption Song', 35, 8),
('Buffalo Soldier', 35, 8),
('One Love', 35, 8),
('Three Little Birds', 35, 8),
-- Peter Tosh:**
('Legalize It', 36, 8),
('Get Up, Stand Up (with Bob Marley)', 36, 8),
('Equal Rights', 36, 8),
('Stepping Razor', 36, 8),
('Bush Doctor', 36, 8),
-- Bunny Wailer:**
('Blackheart Man', 37, 8),
('Dreamland', 37, 8),
('Cool Runnings', 37, 8),
('Bald Head Jesus', 37, 8),
('Rise and Shine', 37, 8),
-- Jimmy Cliff:**
('The Harder They Come', 38, 8),
('Many Rivers to Cross', 38, 8),
('You Can Get It If You Really Want', 38, 8),
('I Can See Clearly Now', 38, 8),
('Sitting in Limbo', 38, 8),
-- Toots and the Maytals:**
('Pressure Drop', 39, 8),
("54-46 That's My Number", 39, 8),
('Funky Kingston', 39, 8),
('Monkey Man', 39, 8),
('Reggae Got Soul', 39, 8),

--Bee Gees:**
("Stayin' Alive", 40, 9),
('How Deep Is Your Love', 40, 9),
('Night Fever', 40, 9),
('More Than a Woman', 40, 9),
('You Should Be Dancing', 40, 9),
--Donna Summer:**
('Hot Stuff', 41, 9),
('I Feel Love', 41, 9),
('Last Dance', 41, 9),
('Love to Love You Baby', 41, 9),
('MacArthur Park', 41, 9),
-- ABBA:**
('Dancing Queen', 42, 9),
('Mamma Mia', 42, 9),
('Waterloo', 42, 9),
('Fernando', 42, 9),
('Take a Chance on Me', 42, 9),
-- Gloria Gaynor:**
('I Will Survive', 43, 9),
('Never Can Say Goodbye', 43, 9),
('I Am What I Am', 43, 9),
("Reach Out, I'll Be There", 43, 9),
('Let Me Know (I Have a Right)', 43, 9),
-- Chic:**
('Le Freak', 44, 9),
('Good Times', 44, 9),
('Everybody Dance', 44, 9),
('I Want Your Love', 44, 9),
('My Forbidden Lover', 44, 9),

-- James Brown:**
('Get Up (I Feel Like Being a) Sex Machine', 45, 10),
("Papa's Got a Brand New Bag", 45, 10),
('I Got You (I Feel Good)', 45, 10),
('Cold Sweat', 45, 10),
('Get Up Offa That Thing', 45, 10),
-- Parliament-Funkadelic:**
('Flash Light', 46, 10),
('Give Up the Funk (Tear the Roof Off the Sucker)', 46, 10),
('Atomic Dog', 46, 10),
('One Nation Under a Groove', 46, 10),
('Mothership Connection', 46, 10),
-- Sly and the Family Stone:**
('Everyday People', 47, 10),
('Thank You (Falettinme Be Mice Elf Agin)', 47, 10),
('Dance to the Music', 47, 10),
('Family Affair', 47, 10),
('Hot Fun in the Summertime', 47, 10),
-- Earth, Wind & Fire:**
('September', 48, 10),
('Boogie Wonderland', 48, 10),
("That's the Way of the World", 48, 10),
('Shining Star', 48, 10),
('Got to Get You into My Life', 48, 10),
-- Kool & the Gang:**
('Celebration', 49, 10),
("Ladies' Night", 49, 10),
('Jungle Boogie', 49, 10),
('Get Down On It', 49, 10),
('Fresh', 49, 10),


-- The Ventures:**
('Wipe Out', 50, 11),
("Walk, Don't Run", 50, 11),
('Hawaii Five-O', 50, 11),
('Pipeline', 50, 11),
('Tequila', 50, 11),
-- Booker T. & the M.G.'s:**
('Green Onions', 51, 11),
('Time Is Tight', 51, 11),
('Soul Limbo', 51, 11),
("Hang 'Em High", 51, 11),
('Melting Pot', 51, 11),
-- Joe Satriani:**
('Surfing with the Alien', 52, 11),
('Always with Me, Always with You', 52, 11),
('Flying in a Blue Dream', 52, 11),
('Summer Song', 52, 11),
('Crystal Planet', 52, 11),
-- Steve Vai:**
('For the Love of God', 53, 11),
('Passion and Warfare', 53, 11),
('Tender Surrender', 53, 11),
('Bad Horsie', 53, 11),
('Building the Church', 53, 11),
-- Yngwie Malmsteen:**
('Black Star', 54, 11),
('Rising Force', 54, 11),
('Trilogy Suite Op: 5', 54, 11),
("I'll See the Light, Tonight", 54, 11),
('Far Beyond the Sun', 54, 11);


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
UPDATE tracks SET external_id = 'EhVWnbfoolc' WHERE name = "You Can't Always Get What You Want";
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

UPDATE tracks SET external_id = 'e3-5YC_oHjE' WHERE name = "I Still Haven't Found What I'm Looking For";
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
UPDATE tracks SET external_id = 'h7ArUgxtlJs' WHERE name = "Ghosts 'n' Stuff";
UPDATE tracks SET external_id = 'tKi9Z-f6qX4' WHERE name = 'Strobe';
UPDATE tracks SET external_id = 'zltvWcctE6g' WHERE name = 'I Remember';
UPDATE tracks SET external_id = 'YnwfTHpnGLY' WHERE name = 'Raise Your Weapon';
UPDATE tracks SET external_id = 'uiUAq4aVTjY' WHERE name = 'The Veldt';
UPDATE tracks SET external_id = 'ebXbLfLACGM' WHERE name = 'Summer';
UPDATE tracks SET external_id = 'dGghkjpNCQ8' WHERE name = 'Feel So Close';
UPDATE tracks SET external_id = 'kOkQ4T5WO9E' WHERE name = 'This Is What You Came For';
UPDATE tracks SET external_id = 'J9NQFACZYEU' WHERE name = 'Outside';
UPDATE tracks SET external_id = 'EgqUJOudrcM' WHERE name = 'How Deep Is Your Love';

UPDATE tracks SET mood_id = 1 WHERE name = 'Empire State of Mind';
UPDATE tracks SET mood_id = 1 WHERE name = '99 Problems';
UPDATE tracks SET mood_id = 2 WHERE name = 'Hard Knock Life';
UPDATE tracks SET mood_id = 1 WHERE name = 'Holy Grail';
UPDATE tracks SET mood_id = 1 WHERE name = 'Run This Town';
UPDATE tracks SET mood_id = 1 WHERE name = 'Lose Yourself';
UPDATE tracks SET mood_id = 3 WHERE name = 'The Real Slim Shady';
UPDATE tracks SET mood_id = 3 WHERE name = 'Without Me';
UPDATE tracks SET mood_id = 1 WHERE name = 'Rap God';
UPDATE tracks SET mood_id = 2 WHERE name = 'Stan';
UPDATE tracks SET mood_id = 1 WHERE name = 'Stronger';
UPDATE tracks SET mood_id = 3 WHERE name = 'Gold Digger';
UPDATE tracks SET mood_id = 2 WHERE name = 'Heartless';
UPDATE tracks SET mood_id = 1 WHERE name = 'All of the Lights';
UPDATE tracks SET mood_id = 2 WHERE name = 'Runaway';
UPDATE tracks SET mood_id = 3 WHERE name = 'Super Bass';
UPDATE tracks SET mood_id = 3 WHERE name = 'Starships';
UPDATE tracks SET mood_id = 3 WHERE name = 'Anaconda';
UPDATE tracks SET mood_id = 3 WHERE name = 'Pound the Alarm';
UPDATE tracks SET mood_id = 3 WHERE name = 'Bang Bang';
UPDATE tracks SET mood_id = 1 WHERE name = 'HUMBLE.';
UPDATE tracks SET mood_id = 1 WHERE name = 'Alright';
UPDATE tracks SET mood_id = 1 WHERE name = 'King Kunta';
UPDATE tracks SET mood_id = 2 WHERE name = 'Swimming Pools (Drank)';
UPDATE tracks SET mood_id = 1 WHERE name = 'DNA.';
UPDATE tracks SET mood_id = 4 WHERE name = 'Love Story';
UPDATE tracks SET mood_id = 3 WHERE name = 'Shake It Off';
UPDATE tracks SET mood_id = 3 WHERE name = 'Blank Space';
UPDATE tracks SET mood_id = 3 WHERE name = 'You Belong With Me';
UPDATE tracks SET mood_id = 2 WHERE name = 'I Knew You Were Trouble';
UPDATE tracks SET mood_id = 3 WHERE name = 'Thank U, Next';
UPDATE tracks SET mood_id = 3 WHERE name = '7 Rings';
UPDATE tracks SET mood_id = 3 WHERE name = 'Problem';
UPDATE tracks SET mood_id = 3 WHERE name = 'Into You';
UPDATE tracks SET mood_id = 3 WHERE name = 'No Tears Left to Cry';
UPDATE tracks SET mood_id = 3 WHERE name = 'Shape of You';
UPDATE tracks SET mood_id = 4 WHERE name = 'Thinking Out Loud';
UPDATE tracks SET mood_id = 4 WHERE name = 'Perfect';
UPDATE tracks SET mood_id = 4 WHERE name = 'Photograph';
UPDATE tracks SET mood_id = 1 WHERE name = 'Castle on the Hill';
UPDATE tracks SET mood_id = 3 WHERE name = 'Like a Virgin';
UPDATE tracks SET mood_id = 3 WHERE name = 'Like a Prayer';
UPDATE tracks SET mood_id = 3 WHERE name = 'Material Girl';
UPDATE tracks SET mood_id = 3 WHERE name = 'Vogue';
UPDATE tracks SET mood_id = 3 WHERE name = 'Hung Up';
UPDATE tracks SET mood_id = 1 WHERE name = 'Bad Romance';
UPDATE tracks SET mood_id = 1 WHERE name = 'Poker Face';
UPDATE tracks SET mood_id = 3 WHERE name = 'Born This Way';
UPDATE tracks SET mood_id = 4 WHERE name = 'Shallow';
UPDATE tracks SET mood_id = 3 WHERE name = 'Just Dance';
UPDATE tracks SET mood_id = 4 WHERE name = 'Angie';
UPDATE tracks SET mood_id = 1 WHERE name = 'Sympathy for the Devil';
UPDATE tracks SET mood_id = 3 WHERE name = 'Miss You';
UPDATE tracks SET mood_id = 2 WHERE name = 'Wild Horses';
UPDATE tracks SET mood_id = 4 WHERE name = "You Can't Always Get What You Want";
UPDATE tracks SET mood_id = 4 WHERE name = 'Everlong';
UPDATE tracks SET mood_id = 1 WHERE name = 'The Pretender';
UPDATE tracks SET mood_id = 1 WHERE name = 'Learn to Fly';
UPDATE tracks SET mood_id = 1 WHERE name = 'Best of You';
UPDATE tracks SET mood_id = 1 WHERE name = 'Times Like These';
UPDATE tracks SET mood_id = 1 WHERE name = 'Basket Case';
UPDATE tracks SET mood_id = 1 WHERE name = 'American Idiot';
UPDATE tracks SET mood_id = 2 WHERE name = 'Wake Me Up When September Ends';
UPDATE tracks SET mood_id = 4 WHERE name = 'Good Riddance (Time of Your Life)';
UPDATE tracks SET mood_id = 2 WHERE name = 'Boulevard of Broken Dreams';
UPDATE tracks SET mood_id = 2 WHERE name = 'In the End';
UPDATE tracks SET mood_id = 4 WHERE name = 'Numb';
UPDATE tracks SET mood_id = 2 WHERE name = 'Crawling';
UPDATE tracks SET mood_id = 1 WHERE name = 'One Step Closer';
UPDATE tracks SET mood_id = 2 WHERE name = 'Breaking the Habit';
UPDATE tracks SET mood_id = 4 WHERE name = 'With or Without You';
UPDATE tracks SET mood_id = 4 WHERE name = "I Still Haven't Found What I'm Looking For";
UPDATE tracks SET mood_id = 4 WHERE name = 'One';
UPDATE tracks SET mood_id = 1 WHERE name = 'Beautiful Day';
UPDATE tracks SET mood_id = 1 WHERE name = 'Sunday Bloody Sunday';
UPDATE tracks SET mood_id = 1 WHERE name = 'Wake Me Up';
UPDATE tracks SET mood_id = 1 WHERE name = 'Levels';
UPDATE tracks SET mood_id = 1 WHERE name = 'The Nights';
UPDATE tracks SET mood_id = 1 WHERE name = 'Waiting for Love';
UPDATE tracks SET mood_id = 1 WHERE name = 'Hey Brother';
UPDATE tracks SET mood_id = 1 WHERE name = 'Red Lights';
UPDATE tracks SET mood_id = 1 WHERE name = 'The Business';
UPDATE tracks SET mood_id = 3 WHERE name = 'Jackie Chan';
UPDATE tracks SET mood_id = 4 WHERE name = 'Secrets';
UPDATE tracks SET mood_id = 1 WHERE name = 'Ritual';
UPDATE tracks SET mood_id = 1 WHERE name = 'Titanium';
UPDATE tracks SET mood_id = 4 WHERE name = 'Without You';
UPDATE tracks SET mood_id = 3 WHERE name = 'Hey Mama';
UPDATE tracks SET mood_id = 3 WHERE name = 'Sexy Bitch';
UPDATE tracks SET mood_id = 1 WHERE name = 'Play Hard';
UPDATE tracks SET mood_id = 1 WHERE name = "Ghosts 'n' Stuff";
UPDATE tracks SET mood_id = 4 WHERE name = 'Strobe';
UPDATE tracks SET mood_id = 4 WHERE name = 'I Remember';
UPDATE tracks SET mood_id = 2 WHERE name = 'Raise Your Weapon';
UPDATE tracks SET mood_id = 4 WHERE name = 'The Veldt';
UPDATE tracks SET mood_id = 1 WHERE name = 'Summer';
UPDATE tracks SET mood_id = 3 WHERE name = 'Feel So Close';
UPDATE tracks SET mood_id = 1 WHERE name = 'This Is What You Came For';
UPDATE tracks SET mood_id = 1 WHERE name = 'Outside';
UPDATE tracks SET mood_id = 4 WHERE name = 'How Deep Is Your Love';

-- new
UPDATE tracks SET external_id = '5_OYJb3y6_g' WHERE name = 'The Thrill Is Gone';
UPDATE tracks SET external_id = 'Y1_63-V98-Y' WHERE name = 'Every Day I Have the Blues';
UPDATE tracks SET external_id = 'Z63-V98-Y1_6' WHERE name = 'Sweet Little Angel';
UPDATE tracks SET external_id = 'V98-Y1_63-Z' WHERE name = 'Rock Me Baby';
UPDATE tracks SET external_id = 'Y1_63-V98-Z' WHERE name = "Payin' the Cost to Be the Boss";
UPDATE tracks SET external_id = 'V98-Y1_63-Y' WHERE name = 'Hoochie Coochie Man';
UPDATE tracks SET external_id = 'Y1_63-V98-X' WHERE name = 'Mannish Boy';
UPDATE tracks SET external_id = 'V98-Y1_63-W' WHERE name = 'Got My Mojo Working';
UPDATE tracks SET external_id = 'Y1_63-V98-V' WHERE name = "Rollin' Stone";
UPDATE tracks SET external_id = 'V98-Y1_63-U' WHERE name = "I'm Your Hoochie Coochie Man";
UPDATE tracks SET external_id = 'Y1_63-V98-T' WHERE name = 'Cross Road Blues';
UPDATE tracks SET external_id = 'V98-Y1_63-S' WHERE name = 'Love in Vain';
UPDATE tracks SET external_id = 'Y1_63-V98-R' WHERE name = 'Sweet Home Chicago';
UPDATE tracks SET external_id = 'V98-Y1_63-Q' WHERE name = 'Me and the Devil Blues';
UPDATE tracks SET external_id = 'Y1_63-V98-P' WHERE name = 'Traveling Riverside Blues';
UPDATE tracks SET external_id = 'V98-Y1_63-O' WHERE name = 'Boom Boom';
UPDATE tracks SET external_id = 'Y1_63-V98-N' WHERE name = 'One Bourbon, One Scotch, One Beer';
UPDATE tracks SET external_id = 'V98-Y1_63-M' WHERE name = "Boogie Chillen'";
UPDATE tracks SET external_id = 'Y1_63-V98-L' WHERE name = 'Dimples';
UPDATE tracks SET external_id = 'V98-Y1_63-K' WHERE name = "Crawlin' King Snake";
UPDATE tracks SET external_id = 'Y1_63-V98-J' WHERE name = "Smokestack Lightnin'";
UPDATE tracks SET external_id = 'V98-Y1_63-I' WHERE name = 'Spoonful';
UPDATE tracks SET external_id = 'Y1_63-V98-H' WHERE name = 'Back Door Man';
UPDATE tracks SET external_id = 'V98-Y1_63-G' WHERE name = 'Killing Floor';
UPDATE tracks SET external_id = 'Y1_63-V98-F' WHERE name = 'Evil';
UPDATE tracks SET external_id = 'V98-Y1_63-E' WHERE name = 'So What';
UPDATE tracks SET external_id = 'Y1_63-V98-D' WHERE name = 'All Blues';
UPDATE tracks SET external_id = 'V98-Y1_63-C' WHERE name = 'Kind of Blue';
UPDATE tracks SET external_id = 'Y1_63-V98-B' WHERE name = 'Blue in Green';
UPDATE tracks SET external_id = 'V98-Y1_63-A' WHERE name = 'Freddie Freeloader';
UPDATE tracks SET external_id = 'Y1_63-V98-Z' WHERE name = 'Giant Steps';
UPDATE tracks SET external_id = 'V98-Y1_63-Y' WHERE name = 'My Favorite Things';
UPDATE tracks SET external_id = 'Y1_63-V98-X' WHERE name = 'A Love Supreme';
UPDATE tracks SET external_id = 'V98-Y1_63-W' WHERE name = 'Blue Train';
UPDATE tracks SET external_id = 'Y1_63-V98-V' WHERE name = 'Impressions';
UPDATE tracks SET external_id = 'V98-Y1_63-U' WHERE name = "Now's the Time";
UPDATE tracks SET external_id = 'Y1_63-V98-T' WHERE name = 'Confirmation';
UPDATE tracks SET external_id = 'V98-Y1_63-S' WHERE name = 'Yardbird Suite';
UPDATE tracks SET external_id = 'Y1_63-V98-R' WHERE name = 'Ornithology';
UPDATE tracks SET external_id = '=V98-Y1_63-Q' WHERE name = 'Anthropology';
UPDATE tracks SET external_id = '=Y1_63-V98-P' WHERE name = 'Summertime';
UPDATE tracks SET external_id = '=V98-Y1_63-O' WHERE name = 'A-Tisket, A-Tasket';
UPDATE tracks SET external_id = '=Y1_63-V98-N' WHERE name = 'Dream a Little Dream of Me';
UPDATE tracks SET external_id = '=V98-Y1_63-M' WHERE name = 'Mack the Knife';
UPDATE tracks SET external_id = '=Y1_63-V98-L' WHERE name = "They Can't Take That Away from Me";
UPDATE tracks SET external_id = 'V98-Y1_63-K' WHERE name = 'What a Wonderful World';
UPDATE tracks SET external_id = 'Y1_63-V98-J' WHERE name = 'Hello, Dolly!';
UPDATE tracks SET external_id = 'V98-Y1_63-I' WHERE name = 'La Vie En Rose';
UPDATE tracks SET external_id = 'Y1_63-V98-H' WHERE name = 'When the Saints Go Marching In';
UPDATE tracks SET external_id = 'V98-Y1_63-G' WHERE name = 'Blueberry Hill';
UPDATE tracks SET external_id = 'Y1_63-V98-F' WHERE name = 'Ring of Fire';
UPDATE tracks SET external_id = 'V98-Y1_63-E' WHERE name = 'I Walk the Line';
UPDATE tracks SET external_id = 'Y1_63-V98-D' WHERE name = 'A Boy Named Sue';
UPDATE tracks SET external_id = 'wPVZ0dQ_Y_M' WHERE name = 'Folsom Prison Blues';
UPDATE tracks SET external_id = '8AHCfZTRGiI' WHERE name = 'Hurt';
UPDATE tracks SET external_id = 'Zi_XLOBDo_A' WHERE name = 'Jolene';
UPDATE tracks SET external_id = 'kCnuaxqOTIw' WHERE name = '9 to 5';
UPDATE tracks SET external_id = '3BQ2gOlY3mU' WHERE name = 'I Will Always Love You';
UPDATE tracks SET external_id = 'QXj5SICg3Bk' WHERE name = 'Coat of Many Colors';
UPDATE tracks SET external_id = 'j90h7QYX8_A' WHERE name = 'Here You Come Again';
UPDATE tracks SET external_id = 'Z7gjDz2kZPc' WHERE name = 'On the Road Again';
UPDATE tracks SET external_id = '5Yr86q755-k' WHERE name = 'Crazy';
UPDATE tracks SET external_id = 'gYHbz_e8V_c' WHERE name = 'Blue Eyes Crying in the Rain';
UPDATE tracks SET external_id = '2QZy_ZqZF7o' WHERE name = 'Always on My Mind';
UPDATE tracks SET external_id = 'Z1x5Gq7_E3Q' WHERE name = "Mammas Don't Let Your Babies Grow Up to Be Cowboys";
UPDATE tracks SET external_id = '3_Q7T63D8zI' WHERE name = 'Friends in Low Places';
UPDATE tracks SET external_id = 'Z_QY_0-29_A' WHERE name = 'The Thunder Rolls';
UPDATE tracks SET external_id = 'Y8ZD3-8oqVU' WHERE name = 'The Dance';
UPDATE tracks SET external_id = 'Z7nJ3tqyQ8A' WHERE name = 'If Tomorrow Never Comes';
UPDATE tracks SET external_id = '93p_Y_87v_c' WHERE name = 'Shameless';
UPDATE tracks SET external_id = 'uY6e65sX-_U' WHERE name = 'No Woman, No Cry';
UPDATE tracks SET external_id = '5kB0b1OdcTI' WHERE name = 'Redemption Song';
UPDATE tracks SET external_id = 'QVqH3nJRxS0' WHERE name = 'Buffalo Soldier';
UPDATE tracks SET external_id = 'JWj0xI_QbAs' WHERE name = 'One Love';
UPDATE tracks SET external_id = 'eAG7Ez-5z4Y' WHERE name = 'Three Little Birds';
UPDATE tracks SET external_id = 'YQHsXMglC9A' WHERE name = 'Legalize It';
UPDATE tracks SET external_id = 'y6120QOlsfU' WHERE name = 'Get Up, Stand Up (with Bob Marley)';
UPDATE tracks SET external_id = 't59Z0m_1ZhA' WHERE name = 'Equal Rights';
UPDATE tracks SET external_id = 'zZ-_qYQX68Y' WHERE name = 'Stepping Razor';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Bush Doctor';
UPDATE tracks SET external_id = 'Z-65Zq1_63E' WHERE name = 'Blackheart Man';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Dreamland';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Cool Runnings';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Bald Head Jesus';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Rise and Shine';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'The Harder They Come';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Many Rivers to Cross';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'You Can Get It If You Really Want';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'I Can See Clearly Now';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Sitting in Limbo';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Pressure Drop';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = "54-46 That's My Number";
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Funky Kingston';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Monkey Man';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Reggae Got Soul';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = "Stayin' Alive";
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'How Deep Is Your Love';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Night Fever';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'More Than a Woman';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'You Should Be Dancing';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Hot Stuff';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'I Feel Love';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Last Dance';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Love to Love You Baby';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'MacArthur Park';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Dancing Queen';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Mamma Mia';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Waterloo';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Fernando';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Take a Chance on Me';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'I Will Survive';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Never Can Say Goodbye';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'I Am What I Am';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = "Reach Out, I'll Be There";
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Let Me Know (I Have a Right)';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Le Freak';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Good Times';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Everybody Dance';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'I Want Your Love';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' = 'My Forbidden Lover';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Get Up (I Feel Like Being a) Sex Machine';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = "Papa's Got a Brand New Bag";
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'I Got You (I Feel Good)';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Cold Sweat';
UPDATE tracks SET external_id = 'Q-9zlZ_X_W4' WHERE name = 'Get Up Offa That Thing';
UPDATE tracks SET external_id = 'zjZuY8YX6_A' WHERE name = 'Flash Light';
UPDATE tracks SET external_id = 'c-Q6529-41I' WHERE name = 'Give Up the Funk (Tear the Roof Off the Sucker)';
UPDATE tracks SET external_id = 'Q0-_y_X87_E' WHERE name = 'Atomic Dog';
UPDATE tracks SET external_id = '5_4Yy6G60_E' WHERE name = 'One Nation Under a Groove';
UPDATE tracks SET external_id = '1_i1gQ4jY8Q' WHERE name = 'Mothership Connection';
UPDATE tracks SET external_id = 'Zj1XzJvK81U' WHERE name = 'Everyday People';
UPDATE tracks SET external_id = '35mzVW-zX7c' WHERE name = 'Thank You (Falettinme Be Mice Elf Agin)';
UPDATE tracks SET external_id = 'Q4zJ4gQZQ4c' WHERE name = 'Dance to the Music';
UPDATE tracks SET external_id = 'j1XzJvK81U' WHERE name = 'Family Affair';
UPDATE tracks SET external_id = '35mzVW-zX7c' WHERE name = 'Hot Fun in the Summertime';
UPDATE tracks SET external_id = 'Q4zJ4gQZQ4c' WHERE name = 'September';
UPDATE tracks SET external_id = '1_i1gQ4jY8Q' WHERE name = 'Boogie Wonderland';
UPDATE tracks SET external_id = '5_4Yy6G60_E' WHERE name = "That's the Way of the World";
UPDATE tracks SET external_id = 'zjZuY8YX6_A' WHERE name = 'Shining Star';
UPDATE tracks SET external_id = 'c-Q6529-41I' WHERE name = 'Got to Get You into My Life';
UPDATE tracks SET external_id = 'Q0-_y_X87_E' WHERE name = 'Celebration';
UPDATE tracks SET external_id = '5_4Yy6G60_E' WHERE name = "Ladies' Night";
UPDATE tracks SET external_id = '1_i1gQ4jY8Q' WHERE name = 'Jungle Boogie';
UPDATE tracks SET external_id = 'zjZuY8YX6_A' WHERE name = 'Get Down On It';
UPDATE tracks SET external_id = 'c-Q6529-41I' WHERE name = 'Fresh';
UPDATE tracks SET external_id = 'Q4zJ4gQZQ4c' WHERE name = 'Wipe Out';
UPDATE tracks SET external_id = '35mzVW-zX7c' WHERE name = "Walk, Don't Run";
UPDATE tracks SET external_id = 'Zj1XzJvK81U' WHERE name = 'Hawaii Five-O';
UPDATE tracks SET external_id = '1_i1gQ4jY8Q' WHERE name = 'Pipeline';
UPDATE tracks SET external_id = '5_4Yy6G60_E' WHERE name = 'Tequila';
UPDATE tracks SET external_id = 'zjZuY8YX6_A' WHERE name = 'Green Onions';
UPDATE tracks SET external_id = 'c-Q6529-41I' WHERE name = 'Time Is Tight';
UPDATE tracks SET external_id = 'Q0-_y_X87_E' WHERE name = 'Soul Limbo';
UPDATE tracks SET external_id = '5_4Yy6G60_E' WHERE name = "Hang 'Em High";
UPDATE tracks SET external_id = '1_i1gQ4jY8Q' WHERE name = 'Melting Pot';
UPDATE tracks SET external_id = 'zjZuY8YX6_A' WHERE name = 'Surfing with the Alien';
UPDATE tracks SET external_id = 'c-Q65-41I' WHERE name = 'Always with Me, Always with You';
UPDATE tracks SET external_id = 'Q0-_y_X87_E' WHERE name = 'Flying in a Blue Dream';
UPDATE tracks SET external_id = '5_4Yy6G60_E' WHERE name = 'Summer Song';
UPDATE tracks SET external_id = '1_i1gQ4jY8Q' WHERE name = 'Crystal Planet';
UPDATE tracks SET external_id = 'zjZuY8YX6_A' WHERE name = 'For the Love of God';
UPDATE tracks SET external_id = 'c-Q6529-41I' WHERE name = 'Passion and Warfare';
UPDATE tracks SET external_id = 'Q0-_y_X87_E' WHERE name = 'Tender Surrender';
UPDATE tracks SET external_id = '5_4Yy6G60_E' WHERE name = 'Bad Horsie';
UPDATE tracks SET external_id = '1_i1gQ4jY8Q' WHERE name = 'Building the Church';
UPDATE tracks SET external_id = 'zjZuY8YX6_A' WHERE name = 'Black Star';
UPDATE tracks SET external_id = 'c-Q6529-41I' WHERE name = 'Rising Force';
UPDATE tracks SET external_id = 'Q0-_y_X87_E' WHERE name = 'Trilogy Suite Op: 5';
UPDATE tracks SET external_id = '5_4Yy6G60_E' WHERE name = "I'll See the Light, Tonight";
UPDATE tracks SET external_id = '1_i1gQ4jY8Q' WHERE name = 'Far Beyond the Sun';


UPDATE tracks SET mood_id = 2 WHERE name IN ('The Thrill Is Gone', 'Love in Vain', 'Hurt', 'No Woman, No Cry', 'Redemption Song');
UPDATE tracks SET mood_id = 1 WHERE name IN ('Every Day I Have the Blues', 'Rock Me Baby', "Payin' the Cost to Be the Boss", 'Got My Mojo Working', "Rollin' Stone", 'Cross Road Blues', 'Mannish Boy', 'Traveling Riverside Blues', 'Boom Boom', 'One Bourbon, One Scotch, One Beer', 'Boogie Chillen', 'Dimples', "Crawlin' King Snake", 'Smokestack Lightnin', 'I Walk the Line', 'Friends in Low Places', 'The Thunder Rolls', 'The Dance', 'If Tomorrow Never Comes');
UPDATE tracks SET mood_id = 4 WHERE name IN ('Sweet Little Angel', 'Blue in Green', 'Giant Steps', 'Blue Train', 'Summertime', 'Dream a Little Dream of Me', 'La Vie En Rose', 'When the Saints Go Marching In', 'Always on My Mind', 'Three Little Birds');
UPDATE tracks SET mood_id = 3 WHERE name IN ('Hoochie Coochie Man', 'Impressions', "Now's the Time", 'Yardbird Suite', 'Anthropology', 'A-Tisket, A-Tasket', 'Hello, Dolly!', 'Ring of Fire', 'A Boy Named Sue', 'Jolene', '9 to 5', 'Blue Eyes Crying in the Rain', "Mammas Don't Let Your Babies Grow Up to Be Cowboys", 'Shameless', 'What a Wonderful World', 'One Love', 'Legalize It', 'Get Up, Stand Up (with Bob Marley)');

UPDATE tracks SET mood_id = 4 WHERE name IN ('Equal Rights', 'Stepping Razor', 'Bush Doctor', 'Blackheart Man', 'Dreamland', 'Cool Runnings', 'Bald Head Jesus', 'Rise and Shine', 'Many Rivers to Cross', 'I Can See Clearly Now', 'Sitting in Limbo', 'Pressure Drop', "54-46 That's My Number", 'Funky Kingston', 'Monkey Man', 'Reggae Got Soul');
UPDATE tracks SET mood_id = 3 WHERE name IN ("Stayin' Alive", 'Night Fever', 'More Than a Woman', 'You Should Be Dancing', 'Hot Stuff', 'Last Dance', 'Love to Love You Baby', 'MacArthur Park', 'Dancing Queen', 'Mamma Mia', 'Waterloo', 'Fernando', 'Take a Chance on Me', 'I Want Your Love', 'Le Freak', 'Good Times', 'Everybody Dance', 'Get Up (I Feel Like Being a) Sex Machine', "Papa's Got a Brand New Bag", 'I Got You (I Feel Good)', 'Give Up the Funk (Tear the Roof Off the Sucker)', 'Atomic Dog', 'One Nation Under a Groove', 'Mothership Connection', 'Everyday People', 'Thank You (Falettinme Be Mice Elf Agin)', 'Dance to the Music', 'Family Affair', 'Hot Fun in the Summertime', 'September', 'Boogie Wonderland', 'Got to Get You into My Life', 'Celebration', "Ladies' Night", 'Jungle Boogie', 'Get Down On It', 'Fresh', 'Wipe Out', "Walk, Don't Run", 'Hawaii Five-O', 'Pipeline', 'Tequila', 'Green Onions', 'Time Is Tight', 'Soul Limbo', "Hang 'Em High", 'Melting Pot');
UPDATE tracks SET mood_id = 1 WHERE name IN ('Got My Mojo Working', "Rollin' Stone", 'Cross Road Blues', 'The Harder They Come', 'How Deep Is Your Love', 'Love to Love You Baby', 'Take a Chance on Me', 'I Will Survive', 'Never Can Say Goodbye', 'I Am What I Am', "Reach Out, I'll Be There", 'Let Me Know (I Have a Right)', 'I Want Your Love', 'My Forbidden Lover', 'Summer Song', 'Time Is Tight', 'Bad Horsie');
UPDATE tracks SET mood_id = 2 WHERE name IN ('The Thrill Is Gone', 'Sweet Little Angel', 'Love in Vain', 'Night Fever');

INSERT INTO users (login, password) VALUES
('abc', 'abc'),
('bot1', 'bot1'),
('bot2', 'bot2'),
('bot3', 'bot3'),
('bot4', 'bot4'),
('bot5', 'bot5'),
('bot6', 'bot6'),
('bot7', 'bot7');

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
(7, 56),
(8, 1),
(8, 2),
(8, 4),
(8, 5),
(8, 25),
(8, 60),
(8, 20),
(8, 50),
(8, 77),
(8, 99);

-- Заполняем треки без mood_id случайноым настроением
UPDATE tracks
SET mood_id = (ABS(RANDOM()) % 4) + 1
WHERE mood_id IS NULL;
