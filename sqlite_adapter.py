import sqlite3

class SqliteAdapter:
    _instance = None

    def new(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(SqliteAdapter, cls).new(cls, *args, **kwargs)
        return cls._instance
    
    def __init__(self):
        self.connection = sqlite3.connect("music.db")

    def query(self, q):
        print(q)
        self.connection = sqlite3.connect("music.db")
        cursor = self.connection.cursor()
        records = list(cursor.execute(q))
        self.connection.commit()
        self.connection.close()
        return records
    
    def get_library(self, user_id):
        return self.query("""
            SELECT t.name, a.name, g.name, t.external_id, t.id
            FROM tracks t
                JOIN artists a ON a.id = t.artist_id
                JOIN genres g ON g.id = t.genre_id 
                JOIN users_tracks_likes l ON l.track_id = t.id
                WHERE l.user_id = '{}'
        """.format(user_id))
    
    def library_ids(self, user_id):
        result =  self.query("""
            SELECT track_id
            FROM users_tracks_likes
            WHERE user_id = {}
        """.format(user_id))

        return [record[0] for record in result]
    
    def songs_count(self):
        return self.query("""
            SELECT COUNT(*) FROM tracks           
        """)[0][0]
    
    def users_count(self):
        return self.query("""
            SELECT COUNT(*) FROM users
        """)[0][0]
    
    def like_vectors(self):
        songs_count = self.songs_count()
        lib = [[0 for i in range(songs_count)] for j in range(self.users_count())]
        result = self.query("""
            SELECT user_id, track_id
            FROM users_tracks_likes
            ORDER BY user_id, track_id
        """)
        for record in result:
            lib[record[0]-1][record[1]-1] = 1
        return lib
    
    def tracks_by_ids(self, ids):
        return self.query("""
            SELECT t.name, a.name, g.name, t.external_id, t.id
            FROM tracks t
                JOIN artists a ON a.id = t.artist_id
                JOIN genres g ON g.id = t.genre_id 
            WHERE t.id IN {}
        """.format(tuple(ids)))
    

    def tracks_by_ids_for_user(self, ids, user_id):
        return self.query("""
            SELECT t.name, a.name, g.name, t.external_id, t.id, l.user_id IS NOT NULL
            FROM tracks t
                JOIN artists a ON a.id = t.artist_id
                JOIN genres g ON g.id = t.genre_id 
            LEFT JOIN (
                SELECT user_id, track_id FROM users_tracks_likes WHERE user_id = {}
            ) AS l
                ON t.id = l.track_id
            WHERE t.id IN {}               
        """.format(user_id, tuple(ids)))

    def genres(self):
        return self.query("""
            SELECT name, id FROM genres                  
        """)

    def like_songs(self, user_id, songs_ids):
        pairs = []
        for song_id in songs_ids:
            pairs.append('({}, {})'.format(user_id, song_id))
        return self.query("""
            INSERT INTO users_tracks_likes (user_id, track_id) VALUES
            {}
        """.format(',\n'.join(pairs)))
    
    def artists_by_genres(self, genres_ids):
        return self.query("""
            SELECT a.name, g.name, a.id
            FROM artists a JOIN genres g ON a.genre_id = g.id
            WHERE g.id IN {}
        """.format(self._int_seq(genres_ids)))
    
    def tracks_by_artists(self, artists_ids):
        return self.query("""
            SELECT t.name, a.name, g.name, t.external_id, t.id
            FROM tracks t
                JOIN artists a ON a.id = t.artist_id
                JOIN genres g ON g.id = t.genre_id 
                WHERE a.id in {}
        """.format(self._int_seq(artists_ids)))
    
    def users(self):
        return self.query("""
            SELECT login, id
            FROM users
        """)
    
    def create_user(self, login, password):
        self.query("""
            INSERT INTO users (login, password) VALUES ('{}', '{}')
        """.format(login, password))

        id = self.query("""
            SELECT id FROM users
            WHERE login = '{}'                
        """.format(login))
        return id[0][0]
    
    def user_exists(self, login):
        result = self.query("""
            SELECT 1 FROM users WHERE login = '{}'
        """.format(login))
        return bool(result)
    
    def authenticate(self, login, password):
        result = self.query("""
            SELECT 1 FROM users WHERE login = '{}' AND password = '{}'                    
        """.format(login, password))
        return bool(result)
    
    def id_by_login(self, login):
        result = self.query("""
            SELECT id FROM users WHERE login = '{}'                    
        """.format(login))
        return result[0][0]
    
    def login_by_id(self, id):
        result = self.query("""
            SELECT login FROM users WHERE id = {}                    
        """.format(id))
        return result[0][0]
    
    # def clear_liked_genres(self, id):
    #     self.query("""
    #         DELETE FROM users_genres_likes
    #         WHERE user_id = {}           
    #     """.format(id))

    def clear_liked_artists(self, id):
        self.query("""
            DELETE FROM users_artists_likes
            WHERE user_id = {}           
        """.format(id))

    def clear_liked_songs(self, id):
        self.query("""
            DELETE FROM users_tracks_likes
            WHERE user_id = {}           
        """.format(id))

    def moods(self):
        result = self.query("""
            SELECT DISTINCT mood FROM tracks                    
        """)
        return [row[0] for row in result]
    
    def mood_by_id(self, id):
        result = self.query("""
            SELECT mood FROM tracks WHERE id = {}                    
        """.format(id))

        return result[0][0]
    
    def ids_by_moods(self, moods):
        result = self.query("""
            SELECT id FROM tracks WHERE mood IN {}
        """.format(self._str_seq(moods)))

        return [record[0] for record in result]
    
    def like(self, song_id, user_id):
        self.query("""
            INSERT INTO users_tracks_likes (track_id, user_id)
            VALUES ({}, {})
        """.format(song_id, user_id))

    def unlike(self, song_id, user_id):
        self.query("""
            DELETE FROM users_tracks_likes
            WHERE user_id = {} AND track_id = {}           
        """.format(user_id, song_id))

    def is_liked(self, song_id, user_id):
        result = self.query("""
            SELECT 1 FROM users_tracks_likes
            WHERE track_id = {} AND user_id = {}                 
        """.format(song_id, user_id))
        return bool(result)
    
    def delete_account(self, user_id):
        self.query("""
            DELETE FROM users
            WHERE id = {}           
        """.format(user_id))
    
    def _int_seq(self, iterable):
        return "({})".format(', '.join(map(str, iterable)))
    
    def _str_seq(self, iterable):
        return "({})".format(', '.join("'{}'".format(x) for x in iterable))
    

